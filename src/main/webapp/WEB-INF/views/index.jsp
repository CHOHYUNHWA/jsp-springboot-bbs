<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/css/bootstrap.css">
<title>SpringBoot JSP 게시판</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="/js/bootstrap.js"></script>
</head>
<body>
    <jsp:include page="./header/header.jsp"></jsp:include>
    <div class="container">
		<div class="jumbotron">
			<h1>웹 사이트 소개</h1>
			<p>이 웹 사이트는 SpringBoot, JSP, JPA, Querydsl, SpringSecurity를 이용한 게시판 서비스 입니다. <br>
                또한, Ajax를 이용하여 회원 중복체크, 게시글 검색 시 페이지 리로드 없는 비동기 처리방식을 채택하였습니다.
            </p>
		</div>
	</div>
    
    </div>
</body>
</html>