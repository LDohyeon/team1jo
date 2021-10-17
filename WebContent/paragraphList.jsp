<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
    
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="utf-8">
		<title>게시판</title>
		<style>
			*
			{
				margin:0;
				padding:0;
			}
			.paragraphListWrap
			{
				width:900px;
				padding:15px;
				border : 1px solid lightgray;
				margin : 60px auto;			
			}
			.spanWrap
			{
				border : 1px solid lightgray;
			}
			.spanWrap > span > span
			{
				text-align:center;
				display :inline-block;
				width:19%;
			}
			.writebutton{

			}
			
		</style>
	</head>
	<body>
		<div class ="paragraphListWrap">
			<h2>게시판</h2>
			<c:if test="${loginUser.id!=null}">
				<input class="writebutton" type="button" value="글쓰기" onclick="location.href='paragraphEditorWrite.do';">
			</c:if>
			<div class="spanWrap">
				<span>
					<span>번호</span>
					<span>제목</span>
					<span>글쓴이</span>
					<span>날짜</span>
					<span>조회수</span>
				</span>
				<c:forEach items="${list }" var="list">
					<span>
						<span>${list.getNum() }</span>
						<span><a href="paragraphEachSelect.do?num=${list.getNum()}">[${list.getCategory()}]${list.getTitle()}</a></span>
						<span>${list.getId()}</span>
						<span>${list.getDatetime()}</span>
						<span>${list.getHits()}</span>
					</span>				
				</c:forEach>
				
			</div>
		</div>
	</body>
</html>