<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/list.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="/assets/css/layout.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
</head>
<style>
.list-menu>.notice> a{
	text-decoration: none !important;
}

.list-menu>.general> a{
	text-decoration-line: underline white;
	text-underline-position : under;
}
</style>
<body>
	<%@ include file="/includes/header.jsp" %>


	<main>
    <div class="container">
        
        <div class="list-menu">
                <span class="notice"><a href="/noticeList.board?cpage=1">공지사항</a></span>
                <span>I</span>
                <span class="general"><a href="/generalList.board?cpage=1">자유게시판</a></span>
        </div>
        
    
    
	<section class="general-board">

            <div class="board-header">
                <span class="seq">번호</span>
                <span class="title">제목</span>
                <span class="writer">작성자</span>
                <span class="writeDate">작성일</span>
                <span class="viewCount">조회수</span>
            </div>
            <div class="board-list">
                <!-- 공지게시판 목록 -->
                <c:forEach var="i" items="${generalList}">
                <div class="board-item">
                    <span class="seq">${i.seq }</span>
                    <span class="title"><a href="detail.board?seq=${i.seq}" name="seq">${i.title }</a>
                    <c:if test="${i.boardReplyCount > 0 }">
                    <span style="color:red;">[${i.boardReplyCount }]</span>
                    </c:if>
                    
                    </span>
                    <span class="writer">${i.writer }</span>
                    <span class="writeDate">${i.dateWrite }</span>
                    <span class="viewCount">${i.viewCount }</span>
                </div>
                </c:forEach>
			</div>
			
			<!-- 게시판 이동 내비게이션 -->
        <div class="pagination">
            <c:if test="${needPrev }">
    			<span class="paging" page="${startNavi - 1 }">< </span> 
    		</c:if>
    	
    		<c:forEach var="i" begin="${startNavi }" end="${endNavi }">
    			<span class="paging" page="${i }">${i }</span>
    		</c:forEach>
    	
    		<c:if test="${needNext }">
    			<span class="paging" page="${endNavi + 1  }"> ></span>
    		</c:if>
            
        </div>

        <form action="/generalSearchList.board?cpage=1" method="post" id="frm">
        <div class="search">
            <i class="fa-solid fa-magnifying-glass fa-l"></i>
            <input type="text" placeholder="Search" class="search-bar" name="searchGeneralTitle">
            <label class="sr-only" for="searchCategory">카테고리</label>
                  <select class="form-control" id="searchCategory" name="searchCategory">
                      
                      <option value="title">제목</option>
                      <option value="writer">작성자</option>
                      
                  </select>
              
          
            <button type="submit" id="search-btn">검색</button>
            
        </div>
        </form>
        	
        
        
        <div class="write-general">
        <c:choose>
        		<c:when test="${nickname == null}">
                   <button class="write-general-btn" id="write-false-Btn">게시글 작성하기</button>
                   
                </c:when>
        		<c:otherwise>    
                    <button class="write-general-btn" id="writeBtn">게시글 작성하기</button>
                </c:otherwise> 
                </c:choose>   
                
        </div>

    </section>
    </div>
	<script>
			
		document.getElementById("search-btn").addEventListener("click", function(event) {
			event.preventDefault(); // 기본 폼 제출 방지

			let searchInput = document.querySelector(".search-bar").value;
			let searchCategory = document.querySelector("#searchCategory").value;
			let currentPage = 1; // 초기 페이지 번호 설정

			// 검색어와 카테고리를 URL에 포함
			let url = "/generalSearchList.board?cpage=" + currentPage +
							"&searchKeyword=" + encodeURIComponent(searchInput) +
			                "&searchCategory=" + encodeURIComponent(searchCategory);
			location.href = url;
		});
			 
		$(".paging").on("click",function(){
			let pageNum = $(this).attr("page");
			sessionStorage.setItem("last_cpage",pageNum);
			location.href="/generalList.board?cpage="+pageNum;
		});
		
		$("#writeBtn").on("click",function(){
			location.href = "/toWrite.board";
		})
		$("#write-false-Btn").on("click",function(){
			alert("로그인이 필요합니다.");
		})
	
	</script>
	</main>		
			
			
        <footer>
         <%@ include file="/includes/footer.jsp" %>
        </footer>
           
        
    
</body>

</html>