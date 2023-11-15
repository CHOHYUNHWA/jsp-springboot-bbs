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

    let currnetUrl = window.location.href;
    let postId = extractPostId(currnetUrl);

    function extractPostId(url) {
        var regex = /\/post\/(\d+)/;
        var match = url.match(regex);
        return match ? match[1] : null;
    }

$(document).ready(function() {
    if(accessToken === null){
            alert('로그인이 필요합니다.');
            window.location.href = "/member/login"
        }
        $.ajax({
        url: "/api/post/" + postId,
        type: "GET",
        data: "json",
        headers: {
                    'Authorization': accessToken
                },
        success: function(data){
            $("#title").val(data.title);
            $("#body").val(data.body);
            console.log(data);
        },
        error: function(data, textStatus, errorThrown){
            alert('게시글 수정에 실패하였습니다.')
        } 
    });

});

function updatePost(){
    const postUpdateRequestDto = {
        title: $("#title").val(),
        body: $("#body").val()
    };

    $.ajax({
        url: "/api/post/" + postId,
        type: "PATCH",
        data: JSON.stringify(postUpdateRequestDto),
        contentType: "application/json; charset=UTF-8",
        headers: {
                    'Authorization': accessToken
                },
        success: function(data){
            alert('게시글 수정이 완료되었습니다.')
            window.location.href = "/post/list";
        },
        error: function(data, textStatus, errorThrown){
            alert('게시글 수정에 실패하였습니다.')
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
                    <th colspan="2" style = "background-color : #eeeeee; text-align: center;">게시판 글 수정</th>
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
            <a class="btn btn-primary pull-right" onclick="updatePost()" style="margin-right: 10px;"">수정</a>
        </div>
    </div>
</div>
</body>
</html>