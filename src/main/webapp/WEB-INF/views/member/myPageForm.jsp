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
<script src="../global/global.js"></script>

<script>
    $(document).ready(function() {

    const accessToken = localStorage.getItem('accessToken');

    function parseGender(gender){
        if(gender === 'MALE'){
            return '남자';
        } else {
            return '여자';
        }
    }

                $.ajax({
                    type: 'GET',
                    url: '/api/member',
                    dataType: 'json',
                    headers: {
                        'Authorization': accessToken
                    },
                    success: function(data) {
                                $('#username').text(data.username);
                                $('#name').text(data.name);
                                $('#nickname').text(data.nickname);
                                $('#gender').text(parseGender(data.gender));
                                $('#email').text(data.email);
                            },
                    error: function() {
                        console.log(accessToken);
                        alert('회원 정보를 가져오는 데 실패했습니다.');
                        window.location.href='/member/login';
                    }
                });
            });
            

    function deleteMember (){

        const accessToken = localStorage.getItem('accessToken');

        $.ajax({
                    type: 'DELETE',
                    url: '/api/member',
                    dataType: 'json',
                    headers: {
                        'Authorization': accessToken
                    },
                    success: function(data) {
                        alert('회원 탈퇴가 완료되었습니다.')
                        window.location.href='/';
                        localStorage.removeItem('accessToken');
                        localStorage.removeItem('accessTokenExpiration');
                            },
                    error: function() {
                        alert('회원 삭제에 실패했습니다.');
                        window.location.href='/';
                    }
                });
    }
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
                            <td id="username"></td>
                        </tr>
                        <tr>
                            <td style="background-color: #fafafa; text-align: center;"><h4>이름</h4></td>
                            <td id="name"></td>
                        </tr>
                        <tr>
                            <td style="background-color: #fafafa; text-align: center;"><h4>닉네임</h4></td>
                            <td id="nickname"></td>
                        </tr>
                        <tr>
                            <td style="background-color: #fafafa; text-align: center;"><h4>성별</h4></td>
                            <td id="gender"> </td>
                        </tr>
                        <tr>
                            <td style="background-color: #fafafa; text-align: center;"><h4>이메일</h4></td>
                            <td id="email"></td>
                        </tr>
                    </tbody>
                </table>
        <div>
            <button class="btn btn-primary pull-right" style="margin-left: 10px;" onclick="deleteMember()" type="button">회원탈퇴</button>
            <button id="registerUserButton" class="btn btn-primary pull-right" onclick="window.location.href='/member/update'" type="button" >회원수정</button>
        </div>
    </div>
</body>ㅌ
</html>