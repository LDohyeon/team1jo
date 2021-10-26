<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


    
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
				width:1200px;
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
			.pageNum{
				text-align: center;
			}
			.tagColor
			{
				color: blue;
			    background-color: lightblue;
			    border-color: blue;
			    float:left;
			    margin-right:5px;
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
						<span>
							<a href="paragraphEachSelect.do?num=${list.getNum()}">[${list.getCategory()}]${list.getTitle()}</a>
							<br>
							<c:set var="tag" value="${fn:split(list.getTag(),'★')}"></c:set>
								
							<c:if test="${fn:length(tag) <= 3}">
								<c:forEach items="${tag }" var="tags">
									<span class="tagColor">${tags }</span>
								</c:forEach>
							</c:if>
							<c:if test="${fn:length(tag) > 3}">
								<c:forEach begin="0" end="2" items="${tag }" var="tags">
									<span class="tagColor">${tags }</span>
								</c:forEach>
							</c:if>



						</span>
						<span>${list.getId()}</span>
						<span>${list.getDatetime()}</span>
						<span>${list.getHits()}</span>
					</span>				
				</c:forEach>
				
			</div>
			<div class="pageNum">
				<c:forEach begin="1" end="${ nOfPages}" var="i">
					<c:choose>
						<c:when test="${StartPage eq i}">
							<a>${i}(현재)</a>
						</c:when>
						<c:otherwise>
							<a href="paragraphList.do?startPage=${i}">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>
		</div>
	</body>
</html>