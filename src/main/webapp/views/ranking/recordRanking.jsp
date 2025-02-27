<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Map"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html lang="">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Ranking Board</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="/assets/css/layout.css">
<link rel="stylesheet" href="/assets/css/reset.css">
<style>
body {
	color: #ffffff;
	background-color: #000000;
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
}

.tabs {
	display: flex;
	justify-content: center;
	flex-wrap: wrap;
	margin-bottom: 30px;
	gap: 10px;
}

.tabs button {
	background: #ffcc00;
	border: none;
	padding: 12px 25px;
	color: #000000;
	font-weight: bold;
	cursor: pointer;
	border-radius: 10px;
	font-size: 1rem;
}

.tabs button:hover {
	background: #ff5733;
	transform: scale(1.05);
}

.leaderboard-container {
	background: rgba(255, 255, 255, 0.1);
	padding: 20px;
	border-radius: 15px;
	max-width: 800px;
	margin: 0 auto;
}

.leaderboard {
	width: 100%;
	border-collapse: collapse;
}

.leaderboard th, .leaderboard td {
	padding: 12px;
	text-align: left;
	border-bottom: 1px solid rgba(255, 255, 255, 0.2);
}

.leaderboard th {
	background: #ffcc00;
	color: #000000;
}

.leaderboard tr:hover {
	background: rgba(255, 255, 255, 0.2);
}
</style>
</head>
<body>
<%@ include file="../../includes/header.jsp" %>
	<section>
		<div class="tabs">
			<button onclick="loadRanking(4001)">Barbecue Game</button>
			<button onclick="loadRanking(4002)">Rhythm Game</button>
			<button onclick="loadRanking(4003)">Zombie Crusher</button>
			<button onclick="loadRanking(4004)">스네이크 게임</button>
			<button onclick="loadRanking(4005)">크로스 로드</button>
			<button onclick="loadRanking(4006)">참참참!</button>
		</div>

		<div class="leaderboard-container">
			<h2>🏆 게임 랭킹</h2>
			<table class="leaderboard">
				<thead>
					<tr>
						<th>Ranking</th>
						<th>Name</th>
						<th>Score</th>
					</tr>
				</thead>
				<tbody id="rankingTable">
				</tbody>
			</table>
		</div>
	</section>
<%@ include file="../../includes/footer.jsp" %>
	<script>
	$(document).ready(function(){
		loadRanking(4001);
	})
        function loadRanking(gameId) {
            $.ajax({
                url: "/rankinglist.record",
                data: { gameId: gameId },
                dataType: "json",
                success: function(resp) {
                	
                    let tableBody = $("#rankingTable");
                    tableBody.empty();

                    if (resp.length === 0) {
                        tableBody.append("<tr><td colspan='3'>데이터가 없습니다.</td></tr>");
                        return;
                    }
                    for(let i = 0 ; i < resp.length ; i ++){
                		let tr = $("<tr>")
                        let ranking = $("<td>").html(resp[i].ranking);
                        let userid=$("<td>").html(resp[i].userid);
                        let record=$("<td>").html(resp[i].record +"🏆");
                        tr.append(ranking,userid,record);
                        tableBody.append(tr);

                	}
                   
                },
                error: function(xhr, status, error) {
                    console.error("데이터 로드 실패:", error);
                }
            });
        }
    </script>
</body>
</html>
