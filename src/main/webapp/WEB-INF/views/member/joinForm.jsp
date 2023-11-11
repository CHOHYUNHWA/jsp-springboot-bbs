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

const userNameRegex = /^[a-zA-Z0-9]{4,12}$/;
const passwordRegex = /^[a-zA-Z0-9]{8,20}$/;
const nameRegex = /^[가-힣]+$/;
const nicknameRegex = /^[A-Za-z]{4,20}$/;
const emailRegex =  /^(([^<>()[\].,;:\s@"]+(\.[^<>()[\].,;:\s@"]+)*)|(".+"))@(([^<>()[\].,;:\s@"]+\.)+[^<>()[\].,;:\s@"]{2,})$/i;


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

function checkName(name){
    if(!nameRegex.test(name)){
        return false;
    }
    return true;
}

function checkNickname(nickname){
    if(!nicknameRegex.test(nickname)){
        return false;
    }
    return true;
}

function checkEmail(email){
    if(!emailRegex.test(email)){
        return false;
    }
    return true;
}



function userNameCheck() {
    const usernameJoinDuplicateCheckDto = {
        username: $("#registerUsername").val()
    };
    if (usernameJoinDuplicateCheckDto.username === "") {
        alert("아이디를 입력해 주세요.");
    } else if (!checkUsername(usernameJoinDuplicateCheckDto.username)) {
        alert('아이디는 4자 이상 12자 영어만 가능 합니다.');
    } else {
        $.ajax({
            async: true,
            type: 'POST',
            data: JSON.stringify(usernameJoinDuplicateCheckDto),
            url: "/api/member/check-username-duplicate",
            dataType: "json",
            contentType: "application/json; charset=UTF-8",
            success: function(result, status, xhr) {
                console.log(result);
                if (result) {
                    alert("사용할 수 있는 아이디 입니다.");
                }
                if (!result) {
                    alert("이미 존재하는 아이디 입니다.");
                }
            }
        });
    }
}

function registerUser() {
    const memberJoinRequestDto = {
        username: $("#registerUsername").val(),
        password: $("#registerPassword").val(),
        name : $("#registerName").val(),
        nickname : $("#registerNickname").val(),
        gender : $("#registerGender").val(),
        email : $("#registerEmail").val()
    };

    console.log(memberJoinRequestDto)

    if (memberJoinRequestDto.username == "") {
        alert("아이디를 입력해 주세요.");

        /*
    } else if(!checkUsername(memberJoinRequestDto.username)){
        console.log(memberJoinRequestDto.username.length)
        alert('아이디는 4자 이상 12자 영어만 가능 합니다.');
    }
    else if (memberJoinRequestDto.password == "") {
        alert("비밀번호를 입력해 주세요.");
    } else if(!checkPassword(memberJoinRequestDto.password)){
        alert('비밀번호는 영어 숫자 조합 8자 이상 20자 이하 입니다.');
    }
    else if (memberJoinRequestDto.name == "") {
        alert("이름을 입력해 주세요.");
    }
    else if(!checkName(memberJoinRequestDto.name)){
        alert('이름은 한글만 사용가능 합니다.');
    }
    else if (memberJoinRequestDto.nickname == "") {
        alert("닉네임을 입력해 주세요.");
    }
    else if(!checkNickname(memberJoinRequestDto.nickname)){
        alert('닉네임은 영어 스펠링 4~20자 사이로 입력해 주세요.');
    }
    else if (memberJoinRequestDto.email == "") {
        alert("이메일을 입력해 주세요.");
    }
    else if(!checkEmail(memberJoinRequestDto.email)){
        alert('이메일은 양식을 올바르게 작성해 주세요.'); */
    }else {
        $.ajax({
            async: false,
            type: 'POST',
            data: JSON.stringify(memberJoinRequestDto),
            url: "/api/member",
            dataType: "json",
            contentType: "application/json; charset=UTF-8",
            success: function(data){
                alert('회원가입에 성공하였습니다.')
                window.location.href = "/";
                console.log(data);
            },
            error: function(data, textStatus, errorThrown){
                alert('회원가입에 실패하였습니다.')
                console.error(errorThrown);
            }
        });
    }
}
</script>
</head>
<body>
    <jsp:include page="../header/header.jsp"></jsp:include>
    <div class="container">
            <h2 style="text-align : center ">회원가입<h2>
                <table class="table" style = " border : 1px solid #dddddd">
                    <tbody>
                        <tr>
                            <td style="background-color: #fafafa; text-align: center;"><h4>아이디</h4></td>
                            <td>
                                <input id="registerUsername" type="text" size="20" placeholder="아이디를 입력해 주세요">
                                <button id="checkUsernameDuplicate" onclick="userNameCheck()" class="btn btn-primary" type="button">중복체크</button>
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color: #fafafa; text-align: center;"><h4>비밀번호</h4></td>
                            <td><input type="password" id="registerPassword" size="20" placeholder="비밀번호를 입력해 주세요."></td>
                        </tr>
                        <tr>
                            <td style="background-color: #fafafa; text-align: center;"><h4>이름</h4></td>
                            <td><input type="text" id="registerName" size="20" placeholder="이름을 입력해 주세요"></td>
                        </tr>
                        <tr>
                            <td style="background-color: #fafafa; text-align: center;"><h4>닉네임</h4></td>
                            <td><input type="text" id="registerNickname" size="20" placeholder="닉네임을 입력해 주세요"></td>
                        </tr>
                        <tr>
                            <td style="background-color: #fafafa; text-align: center;"><h4>성별</h4></td>
                            <td>
                                <div class="form-group" data-toggle="buttons">
                                    <label class="btn btn-primary active">
                                        <input type = "radio" id="registerGender" autocomplete="off" size="20" value="MALE" checked>남자
                                    </label>
                                    <label class="btn btn-primary">
                                        <input type = "radio" id="registerGender" autocomplete="off" size="20" value="FEMALE">여자
                                    </label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color: #fafafa; text-align: center;"><h4>이메일</h4></td>
                            <td><input type="text" id="registerEmail" size="20" placeholder="이메일을 입력해 주세요."></td>
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