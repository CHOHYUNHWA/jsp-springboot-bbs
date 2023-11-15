<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/css/bootstrap.css">
<title>SpringBoot JSP 게시판</title>
<style>
    td{
        text-align: center;
    }
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="/js/bootstrap.js"></script>
<script src="../global/global.js"></script>
<script>
    $(document).ready(function() {
        getPostList();
    });

    function getPostList(){

    $.ajax({
        type: "GET",
        url: "/api/post/list?pageNum=1&pageSize=10",
        dataType : "json",
        success : function(data){
            $("#postTableBody").empty();
            $.each(data.data, function(index, post){
                let row = $("<tr>");
                    row.append($("<td>").text(post.id));
                    row.append($("<td>").html("<a href='#' class='post-title-link' data-post-id='" + post.id + "'>" + post.title + "</a>"));
                    row.append($("<td>").text(post.writer));
                    row.append($("<td>").text(post.created_date));
                    $("#postTableBody").append(row);
            });

            $(".post-title-link").click(function(event){
            event.preventDefault();
            let postId = $(this).data("post-id");
            window.location.href = "/post/" + postId;
            }); 

        },
            error: function(xhr, status, error){
                console.error("게시물 목록을 가져오는 중 오류 발생");
            }
        });
    }

</script>

</head>


<body>
    <jsp:include page="../header/header.jsp"></jsp:include>
    <div class="conainer">
        <table class="table table-striped" style=" text-align: center border= 1px solid #dddddd">
            <thead>
                <tr>
                    <th style="background-color: #eeeeee; text-align: center;">번호</th>
                    <th style="background-color: #eeeeee; text-align: center;">제목</th>
                    <th style="background-color: #eeeeee; text-align: center;">작성자</th>
                    <th style="background-color: #eeeeee; text-align: center;">작성일</th>
                </tr>
            </thead>
            <tbody id="postTableBody">
                
            </tbody>
        </table>
    </div>
    <div>
        <a href="/post/create" class="btn btn-primary pull-right" style="margin-right: 10px;">글 작성</a>
    </div>
</body>
</html>