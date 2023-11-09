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
    $(document).ready(function() {

                const accessToken = getCookie('accessToken');



                $.ajax({
                    type: 'GET',
                    url: '/api/member',
                    dataType: 'json',
                    headers: {
                        'Authorization' : accessToken
                    },
                    success: function(data) {
                        // JSON 데이터를 받아와서 페이지에 출력합니다.
                        $('#username').text(data.username);
                        $('#name').text(data.name);
                        $('#nickname').text(data.nickname);
                        $('#gender').text(data.gender);
                        $('#email').text(data.email);
                    },
                    error: function() {
                        console.log(data.username);
                        alert('회원 정보를 가져오는 데 실패했습니다.');
                    }
                });
            });
</script>

</head>
<body>
    <jsp:include page="../header/header.jsp"></jsp:include>

    <div class="container">
            <h2 style="text-align : center ">회원정보<h2>
                <table class="table" style = " border : 1px solid #dddddd margin: auto">
                    <tbody style="text-align: center">
                        <tr>
                            <td style="background-color: #fafafa; text-align: center;"><h4>아이디</h4></td>
                            <td> ${username} </td>
                        </tr>
                        <tr>
                            <td style="background-color: #fafafa; text-align: center;"><h4>이름</h4></td>
                            <td> ${name}</td>
                        </tr>
                        <tr>
                            <td style="background-color: #fafafa; text-align: center;"><h4>닉네임</h4></td>
                            <td> ${nickname} </td>
                        </tr>
                        <tr>
                            <td style="background-color: #fafafa; text-align: center;"><h4>성별</h4></td>
                            <td>
                                ${gender}
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color: #fafafa; text-align: center;"><h4>이메일</h4></td>
                            <td> ${email} </td>
                        </tr>
                    </tbody>
                </table>
        <div>
            <button class="btn btn-primary pull-right" style="margin-left: 10px;" onclick="getMain()" type="button">취소</button>
            <button id="registerUserButton" class="btn btn-primary pull-right" onclick="registerUser()" type="button" >회원가입</button>
        </div>
    </div>
</body>
</html>