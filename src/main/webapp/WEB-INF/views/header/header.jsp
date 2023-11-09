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
    <nav class="navbar navbar-default">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expanded="false">
            </button>
            <a class="navbar-brand" href="/">SpringBoot JSP 게시판</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li class="active">
                    <a href="/">메인</a>
                </li>
                <li>
                    <a href="/postList">게시판</a>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
              <li class="dropdown">
                  <a href="#" class="dropdown-toggle"
                      data-toggle="dropdown" role="button" aria-haspopup="true"
                      aria-expanded="false">접속하기<span class="caret"></span></a>
                  <ul class="dropdown-menu">
                      <li id="joinMenuItem"><a href="/member/join">회원가입</li>
                      <li id="loginMenuItem"><a href="/member/login">로그인</a></li>
                      <li id="mypageItem"><a href="/member/my-page">회원정보</a></li>
                      <li id="logoutMenuItem"><a href="/member/logout">로그아웃</a></li>
                  </ul>
              </li>
            </ul>
        </div>
    </nav>
    <script>
      $(document).ready(function() {
          // 드롭다운 초기화
          $('.dropdown-toggle').dropdown();


          const accessToken = getCookieValue("accessToken");
                      if (accessToken) {
                          // accessToken이 존재할 때 실행할 코드

                          $("#joinMenuItem").hide(); // 회원가입 메뉴 숨김
                          $("#loginMenuItem").hide(); // 회원가입 메뉴 숨김
                          $(".dropdown-toggle").html("회원관리<span class='caret'></span>");
                      } else {
                           $("#mypageItem").hide(); // 회원가입 메뉴 숨김
                           $("#logoutMenuItem").hide(); // 회원가입 메뉴 숨김
                           $(".dropdown-toggle").html("접속하기<span class='caret'></span>");
                      }
      });


      function getCookieValue(cookieName) {
                  const cookies = document.cookie.split(';');
                  for (const cookie of cookies) {
                      const [name, value] = cookie.trim().split('=');
                      if (name === cookieName) {
                          return decodeURIComponent(value);
                      }
                  }
                  return null;
              }
  </script>
</body>
</html>