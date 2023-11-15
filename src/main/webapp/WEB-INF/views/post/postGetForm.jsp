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

    let currnetUrl = window.location.href;
    let postId = extractPostId(currnetUrl);

    $(document).ready(function() {
        getPost();
    });

    function getPost(){
        console.log(postId);
        

    $.ajax({
        type: "GET",
        url: "/api/post/" + postId,
        dataType : "json",
        success : function(data){
            $("#title").text(data.title);
            $("#writer").text(data.writer);
            $("#created_date").text(data.created_date);
            $("#body").text(data.body);
        },
            error: function(xhr, status, error){
                console.error("게시물 목록을 가져오는 중 오류 발생");
            }
        });
    }

    function extractPostId(url) {
        var regex = /\/post\/(\d+)/;
        var match = url.match(regex);
        return match ? match[1] : null;
    }

    function deletePost(){

                if(accessToken === null){
            alert('로그인이 필요합니다.');
            window.location.href = "/member/login"
        }

        $.ajax({
        type: "DELETE",
        url: "/api/post/" + postId,
        headers: {
                        'Authorization': accessToken
                    },
        success : function(data){
            alert("게시글 삭제가 완료 되었습니다.");
            window.location.href = "/post/list";
        },
            error: function(xhr, status, error){
                console.error("게시글 삭제에 실패 했습니다.");
            }
        });
    }

    function getUpdatePage(){
        window.location.href = "/post/" + postId + "/update"; 
    }

</script>
</head>


<body>
    <jsp:include page="../header/header.jsp"></jsp:include>
    <div class="container">
        <div class="row">
            <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd;">
                <thead>
                    <tr>
                        <th colspan="3" style="background-color: #eeeeee; text-align: center;">게시글 글 보기</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td style="width: 30%;">글 제목</td>
                        <td colspan="2" id="title"></td>
                    </tr>
                    <tr>
                        <td>작성자</td>
                        <td colspan="2" id="writer"></td>
                    </tr>
                    <tr>
                        <td>작성일</td>
                        <td colspan="2" id="created_date"></td>
                    </tr>
                    <tr>
                        <td style="width: 20%;">내용</td>
                        <td colspan="2" id = "body"></td>
                    </tr>
                </tbody>
            </table>
            <a href="/post/list" class="btn btn-primary center">목록으로</a>
            <a class="btn btn-primary pull-right" onclick="deletePost()">삭제</a>
            <a class="btn btn-primary pull-right" style="margin-right: 10px;" onclick="getUpdatePage()">수정</a>
        </div>
    </div>
</body>
</html>