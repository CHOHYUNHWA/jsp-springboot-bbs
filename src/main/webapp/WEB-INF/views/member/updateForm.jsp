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

                    $('#nickname').val(data.nickname);
                },
        error: function() {
            console.log(accessToken);
            alert('회원 정보를 가져오는 데 실패했습니다.');
            window.location.href='/member/login';
        }
    });
});



    $(document).ready(function() {

    const accessToken = localStorage.getItem('accessToken');

    // 회원 수정 버튼 클릭 시 비밀번호 검증 모달 열기
        $('#updateUserButton').click(function() {
            $('#password-verification-modal').modal('show');
        });

        // 비밀번호 확인 버튼 클릭 시 비밀번호 검증 요청 보내기
        $('#verifyPasswordBtn').click(function() {
            const verifyPasswordRequestDto = {
                password : $('#password').val()
            };

            // password를 서버로 보내어 비밀번호 검증 작업 수행
            $.ajax({
                type: 'POST',
                url: '/api/member/verifyPassword',
                dataType: 'json',
                data: JSON.stringify(verifyPasswordRequestDto),
                contentType: "application/json; charset=UTF-8",
                headers: {
                    'Authorization': accessToken
                },
                success: function(data) {
                    
                    $('#password-verification-modal').modal('hide'); // 모달 닫기
                    if(data === true){
                        updateUser();
                    } else {
                        alert('비밀번호가 일치하지 않습니다.')
                        window.location.href = '/member/my-page'
                    }
                },
                error: function() {
                    alert('비밀번호 확인에 실패했습니다.');
                    window.location.href = '/member/my-page'
            }
        });
    });
});


function updateUser(){

    const accessToken = localStorage.getItem('accessToken');

    const memberUpdateRequestDto = {
        nickname : $("#nickname").val(),
    };
    
    $.ajax({
        type: 'PATCH',
        url: '/api/member',
        dataType: 'json',
        data: JSON.stringify(memberUpdateRequestDto),
        contentType: "application/json; charset=UTF-8",
        headers: {
            'Authorization': accessToken
        },
        success: function(data) {
            alert('회원수정이 완료되었습니다.')
            window.location.href = '/member/my-page'
                },
        error: function() {
            console.log(accessToken);
            alert('회원 수정에 실패했습니다.');
            window.location.href='/member/my-page';
        }
    });
}
        



</script>
</head>
<body>
    <jsp:include page="../header/header.jsp"></jsp:include>
    <div class="container">
            <h2 style="text-align : center ">회원수정<h2>
                <table class="table" style = " border : 1px solid #dddddd">
                    <tbody style="text-align: center;">
                        <tr>
                            <td style="background-color: #fafafa; text-align: center;"><h4>아이디</h4></td>
                            <td id="username">
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color: #fafafa; text-align: center;"><h4>이름</h4></td>
                            <td id="name"></td>
                        </tr>
                        <tr>
                            <td style="background-color: #fafafa; text-align: center;"><h4>닉네임</h4></td>
                            <td><input type="text" id="nickname" size="20" placeholder="닉네임을 입력해 주세요" style="text-align: center;" ></td>
                        </tr>
                        <tr>
                            <td style="background-color: #fafafa; text-align: center;"><h4>성별</h4></td>
                            <td id="gender">
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color: #fafafa; text-align: center;"><h4>이메일</h4></td>
                            <td id="email"></td>
                        </tr>
                    </tbody>
                </table>
        <div>
            <button class="btn btn-primary pull-right" style="margin-left: 10px;" onclick="getMain()" type="button">취소</button>
            <button id="updateUserButton" class="btn btn-primary pull-right" type="button" >회원수정</button>
        </div>
    </div>




    <div class="modal fade" id="password-verification-modal" tabindex="-1" role="dialog" aria-labelledby="passwordVerificationModal" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="passwordVerificationModal">비밀번호 확인</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="닫기">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <label for="password">비밀번호</label>
                    <input type="password" id="password" class="form-control" placeholder="비밀번호를 입력하세요">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary" id="verifyPasswordBtn">확인</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>