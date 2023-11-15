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
        if(accessToken === null){
                alert('로그인이 필요합니다.');
                window.location.href = "/member/login"
            }
    });

    function createPost(){
        const postCreateRequestDto = {
            title: $("#title").val(),
            body: $("#body").val()
        };

        $.ajax({
            url: "/api/post",
            type: "POST",
            data: JSON.stringify(postCreateRequestDto),
            contentType: "application/json; charset=UTF-8",
            headers: {
                        'Authorization': accessToken
                    },
            success: function(data){
                alert('게시글 작성이 완료되었습니다.')
                window.location.href = "/post/list";
            },
            error: function(data, textStatus, errorThrown){
                alert('게시글 작성에 실패하였습니다.')
            } 
        });


    }
</script>


</head>


<body>
    <jsp:include page="../header/header.jsp"></jsp:include>
    <div class="conainer">
        <div class="row">
            <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd;">
                <thead>
                    <tr>
                        <th colspan="2" style = "background-color : #eeeeee; text-align: center;">게시판 글 작성</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><input type="text" placeholder="제목" id="title" maxlength="50" style="width: 80%;"></td>
                    </tr>
                    <tr>
                        <td><textarea placeholder="내용" id="body" maxlength="2048" style="height : 350px; width: 80%;"></textarea></td>
                    </tr>
                </tbody>
            </table>
            <div style="margin-right: 20px;">
                <a href="/post/list" class="btn btn-primary pull-right">취소</a>
                <a class="btn btn-primary pull-right" onclick="createPost()" style="margin-right: 10px;"">작성</a>
            </div>
        </div>
    </div>


</body>
</html>