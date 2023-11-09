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

<script>
    function joinForm(){
        window.location.href="/member/join"
    }

    function setTokenAndExpiration(token, expiration) {
  var currentTime = new Date().getTime();
  var expirationTime = currentTime + expiration * 1000; 
  localStorage.setItem('accessToken', token);
  localStorage.setItem('accessTokenExpiration', expirationTime);
}


    const userNameRegex = /^[a-zA-Z0-9]{4,12}$/;
    const passwordRegex = /^[a-zA-Z0-9]{8,20}$/;

    function checkUsername(username){
        if(!userNameRegex.test(username)){
            return false;
        }
        return true;
    }

    function checkPassword(password){
        if(!passwordRegex.test(password)){
            return false;
        }
        return true;
    }


function login() {
    const loginDto = {
        username: $("#username").val(),
        password: $("#password").val()
    };

    if (loginDto.username == "") {
        alert("아이디를 입력해 주세요.");

    } else if(!checkUsername(loginDto.username)){
        alert('아이디는 4자 이상 12자 영어만 가능 합니다.');
    }
    else if (loginDto.password == "") {
        alert("비밀번호를 입력해 주세요.");
    }else {
        $.ajax({
            async: true,
            type: 'POST',
            data: JSON.stringify(loginDto),
            url: "/api/member/login",
            dataType: "json",
            contentType: "application/json; charset=UTF-8",
            success: function(data, status, xhr){
                alert('로그인에 성공하였습니다.')
                const accessToken = xhr.getResponseHeader("Authorization");
                setTokenAndExpiration(accessToken, 300000);

                window.location.href="/";
            },
            error: function(data, textStatus, errorThrown){
                alert('아이디와 비밀번호가 틀렸습니다.')
                console.error(errorThrown);
            }
        });
    }
}
</script>

</script>
</head>
<body>
    <jsp:include page="../header/header.jsp"></jsp:include>

    <div class="container">
        <div class="col-lg-4"></div>
        <div class="col-lg-4">
            <div class="jumbotron" style="padding-top: 20px;">
                <h3 style="text-align: center">로그인</h3>
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="아이디" id="username" maxlength="20">
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" placeholder="비밀번호" id="password" maxlength="20">
                </div>
                <div style="text-align: center;">
                <button type="button" class="btn btn-primary" onclick="login()">로그인</button>
                <button type="button" class="btn btn-primary" onclick="joinForm()">회원가입</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>