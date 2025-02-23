<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${post.title }</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/detail.css">
<link rel="stylesheet" href="/assets/css/reset.css">
<link rel="stylesheet" href="/assets/css/layout.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
        integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>

<script>
	//
	// share 버튼 눌렀을 시 나올 이벤트 필요
	//


	// 댓글 로드 메소드
	function loadReplies(){
		$.ajax({
			url:"/list.reply",
            data: {seq: "${post.seq }"}
		}).done(function(resp){
			$("#replyUl").empty();
			
			replyList = JSON.parse(resp);
			$("#replyCount").html("댓글\t" + replyList.length);
			$("#replyCountSm").html("댓글\t" + replyList.length);
			
            replyList.forEach(replyData => {
            	let replyLi = $("<li>").addClass("reply-li");
            	let reply = $("<div>").addClass("reply").attr("id", replyData.seq);
            	let replyWriter = $("<div>").addClass("reply-writer").html(replyData.writer);
            	let replyContents = $("<div>").css("white-space", "pre-wrap").addClass("reply-contents").html(replyData.contents);
            	let replyInfo = $("<div>").addClass("reply-info");
            	let replyWriteDate = $("<p>").addClass("reply-write-date").html(replyData.writeDate);
            	replyInfo.append(replyWriteDate);
            	
            	if("${nickname}" == replyData.writer){
            		let updateReplyBtn = $("<button>").addClass("update-reply-btn").html("수정");
            		let deleteReplyBtn = $("<button>").addClass("delete-reply-btn").html("삭제");
            		replyInfo.append(updateReplyBtn, deleteReplyBtn);
            	}
            	
            	reply.append(replyWriter, replyContents, replyInfo);
            	replyLi.append(reply);
            	
            	$("#replyUl").append(replyLi);
            });
		});
		
	}
	
	// 댓글 삭제 버튼 클릭 이벤트
	$(document).on("click", ".delete-reply-btn", function(){
		if(!confirm("댓글을 삭제하시겠습니까?")){
			return false;
		}
		
    	let seq = $(this).closest(".reply").attr("id");
    	
    	$.ajax({
    		url:"/delete.reply",
    		data: {seq: seq, parentBoardSeq: "${post.seq }"}
    	}).done(function(){
    		loadReplies();
    	});
	});
	
	// 댓글 수정 버튼 클릭 이벤트
	$(document).on("click", ".update-reply-btn", function(){
		//
		// !!! 한 번에 하나의 댓글 수정 폼만 열려있도록 개선 필요
		//
		
		let originalReply = $(this).closest(".reply").html();
	    let currentContents = $(this).closest(".reply").find(".reply-contents").html();
		
	    // 댓글 수정 클릭 시 나올 inbox 생성
		let replyInbox = $("<div>").addClass("reply-inbox update-reply-inbox");
		
		let replyInboxName = $("<p>").addClass("reply-inbox-name").html("${nickname}");
		let replyInboxText = $("<textarea>").addClass("reply-inbox-text").attr({name: "contents"}).html(currentContents);
		
		let replyBtns = $("<div>").addClass("reply-btns");		
		let replyCancelBtn = $("<button>").addClass("reply-cancel-btn").attr("id", "replyCancelBtn").html("취소");
		let replySaveBtn = $("<button>").addClass("reply-save-btn").attr("id", "replySaveBtn").html("등록");
		
		let hdParentBoardSeq = $("<input>").attr({type: "hidden", name: "parentBoardSeq", value:"${post.seq}"});
		let hdWriter = $("<input>").attr({type: "hidden", name: "writer", value:"${nickname}"});
	
		replyBtns.append(replyCancelBtn, replySaveBtn);
		replyInbox.append(replyInboxName, replyInboxText, replyBtns, hdParentBoardSeq, hdWriter)
		
		// 기존 댓글 inbox로 대체  
		$(this).closest(".reply").html(replyInbox);
		
		// 댓글 수정 취소 버튼 클릭 이벤트
		replyCancelBtn.on("click", function(){
			$(this).closest(".reply").html(originalReply);
		});
		
		// 댓글 수정 완료 버튼 클릭 이벤트
		replySaveBtn.on("click", function(){
			if(!confirm("수정을 완료하시겠습니까?")){
				return false;
			};
			
			let seq = $(this).closest(".reply").attr("id");
			let updateReplyContents = $(this).closest(".reply").find(".reply-inbox-text").val();
			
			$.ajax({
	    		url:"/update.reply",
	    		data: {seq: seq, contents: updateReplyContents }
	    	}).done(function(){
	    		loadReplies();
	    	});
		}); 
	});
	
	
	
	
	
	$(function(){
		
		// 로그인한 유저가 작성한 게시글일 경우 드롭다운 메뉴 생성
		if("${nickname}" == "${post.writer}"){
			let postMenu = $("<div>").addClass("post-menu");
			let menuBtn = $("<button>").addClass("menu-btn").html('<i class="fa-solid fa-ellipsis-vertical fa-2xs"></i>');
			let menuDropdown = $("<div>").addClass("menu-dropdown").attr("id", "menuDropdown");
			let updatePostBtn = $("<button>").addClass("menu-item").attr("id", "updatePostBtn").html("수정하기");
			let deletePostBtn = $("<button>").addClass("menu-item").attr("id", "deletePostBtn").html("삭제하기");
		
			menuDropdown.append(updatePostBtn, deletePostBtn);
			postMenu.append(menuBtn, menuDropdown);
		
			$("#postInfoRight").append(postMenu);
		}
		
	    // 드롭다운 메뉴 클릭 이벤트
	    $(document).on("click", ".menu-btn", function() {
	        $("#menuDropdown").toggleClass("show");
	    });
	    
		// 드롭다운 메뉴 외 공간 클릭 시 드롭다운 닫기 이벤트	    
	    $(document).on("click", function(event) {
	    	// 클릭된 요소가 #menuBtn 또는 #menuDropdown 내부 요소인지 확인
	   		if (!$(event.target).closest(".menu-btn, .menu-dropdown").length) {
	        	$("#menuDropdown").removeClass("show"); // 다른 곳 클릭 시 닫기
	    	}
		});
	    	
	    
	    
                        
	    // 공지 게시판일 경우 댓글 섹션 삭제
	    if ("${post.boardCategory}" == "notice") {
	    	$("#replyCountSm").remove();
        	$("#replySection").remove();
        	$("#boardNameH2").html("공지사항");
    	}else if ("${post.boardCategory}" == "general"){// 자유 게시판일 경우 댓글 로드
    		$("#boardNameH2").html("자유 게시판");
    		loadReplies();
    	}
	

	    $("#menuBtn").on("click", function () {
	        $("#menuDropdown").toggleClass("show");
	    });
	    
	    // 게시글 삭제 버튼 클릭 이벤트
	    $("#deletePostBtn").on("click", function(){
	    	if(confirm("게시글을 삭제하시겠습니까?")){
	    		$.ajax({
	    			url: "delete.board",
	    			type: "POST",
	    			data: {seq: "${post.seq}", boardCategory: "${post.boardCategory}"}
	    			
	    		}).done(function(){
    				if("${post.boardCategory}" == "notice") {
    					window.location.href = "/noticeList.board?cpage=1";
    				}else if("${post.boardCategory}" == "general") {
    					window.location.href = "/generalList.board?cpage=1";
    				}
		    	});
	    	}
	    });
	
	    // 게시글 수정 버튼 클릭 이벤트
	    $("#updatePostBtn").on("click", function(){
	    	
	    });
	    

	    // 스크롤 이벤트 감지
	    $(window).scroll(function() {
	        if ($(this).scrollTop() > 200) { // 200px 이상 스크롤되면 버튼 표시
	        	$(".scroll-top-btn").show();
	        } else {
	        	$(".scroll-top-btn").hide();
	        }
	    });

	    // 버튼 클릭 시 최상단 이동
	    $(".scroll-top-btn").on("click", function() {
	        $("html, body").animate({ scrollTop: 0 }, "slow");
	    });
	    
	    // 목록으로 버튼 클릭 이벤트
	    $("#toBoardBtn").on("click", function(){
	    	let last_cpage = sessionStorage.getItem("last_cpage");
	    	
	    	if ("${post.boardCategory}" == "notice"){
	    		location.href="/noticeList.board?cpage=" + last_cpage;
	    	}else if ("${post.boardCategory}" == "general"){
	    		location.href="/generalList.board?cpage=" + last_cpage;
	    	}
	    });
	    
	    
	});
	
	
	
</script>

</head>

<body>

	<%@ include file="/includes/header.jsp" %>


        <!-- 게시글 -->
        <main class="main-content">
            <div class="board-name">
                <h2 id="boardNameH2"></h2>
            </div>
            
            <!-- 게시글 섹션 -->
            <section class="post-section">
                <div class="post-title">
                    <h2>${post.title }</h2>
                </div>

                <div class="post-info">
                    <div class="post-info-left">
                        <p class="post-writer">${post.writer }</p>
                        <p class="post-write-date">${post.writeDate }</p>
                    </div>
                    <div class="post-info-right" id="postInfoRight">
                        <p class="view-count">조회수 ${post.viewCount }</p>
                        <p id="replyCountSm">댓글</p>
                        <button class="share-btn">
                            <i class="fa-regular fa-share-from-square"></i>
                        </button>
					
<!--                         <div class="post-menu" id="postMenu"> -->
<!--                             <button id="menuBtn" class="menu-btn"> -->
<!--                                 <i class="fa-solid fa-ellipsis-vertical fa-2xs"></i> -->
<!--                             </button> -->
<!--                             <div id="menuDropdown" class="menu-dropdown"> -->
<!--                             	<button class="menu-item" id="updatePostBtn">수정하기</button> -->
<!--                                 <button class="menu-item" id="deletePostBtn">삭제하기</button> -->
<!--                             </div> -->
<!--                         </div> -->
                    
                        
                    </div>
                </div>

                <div class="post-contents">
                	${post.contents }              
                </div>

                <div class="post-btn-area">
                    <button class="to-board-btn" id="toBoardBtn">목록으로</button>
                </div>
            </section>
            

            <!-- 댓글 섹션 -->
            <section class="reply-section" id="replySection">
                <!-- 댓글 작성란 -->
                
                <form action="/add.reply" method="post">
                <div class="reply-inbox">
                    <p class="reply-inbox-name">${nickname}</p>
                    <textarea class="reply-inbox-text" name="contents" placeholder="댓글을 작성해주세요."></textarea>
                    <div class="reply-btns">
                    	<button class="reply-resister-btn" id="replyResisterBtn">등록</button>
                    </div>
                    
                    <!-- 댓글 정보 넘기기 위한 hidden input -->
                    <input type="hidden" name="parentBoardSeq" value="${post.seq }">
        			<input type="hidden" name="writer" value="${nickname}">
                </div>
                </form>
                
                
        
                <div>
                    <h2 class="reply-count" id="replyCount"></h2>
                </div>
                
                <!-- 댓글 영역 -->
                <ul class="reply-ul" id="replyUl">
                    
                </ul>
            </section>

        </main>
        
        <button class="scroll-top-btn">
            <i class="fa-solid fa-arrow-up fa-2xl" style="color: #B197FC;"></i>
        </button>

    
    <%@ include file="/includes/footer.jsp" %>

</body>
</html>