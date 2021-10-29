<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


    
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="utf-8">
		<title>게시판</title>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
			.narrow{
				text-align:center;
				display :inline-block;
				width: 11%;
			}
			.medium{
				text-align:center;
				display :inline-block;
				width: 19%;
			}
			.wide{
				text-align:center;
				display :inline-block;
				width: 45%;
			}
			.pageNum{
				text-align: center;
			}
			.tagColor
			{
				color: blue;
			    background-color: lightblue;
			    border-color: blue;
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
			<span class="search">
				<form method="get" action="search.do" name="frm">
					<input type="text" name="searchValue" id="searchValue">
					<input type="hidden" name="startPage" value="1">
					<input type="submit" value="검색" onclick="writeCheck()">
				</form>
			</span>
			<div class="spanWrap">
				<span>
					<span class="narrow">번호</span>
					<span class="wide">제목</span>
					<span class="narrow">글쓴이</span>
					<span class="medium">날짜</span>
					<span class="narrow">조회수</span>
				</span>
				<c:forEach items="${list }" var="list">
					<span>
						<span class="narrow">${list.getNum() }</span>
						<span class="wide">
							<a href="paragraphEachSelect.do?num=${list.getNum()}&&flag=0">[${list.getCategory()}]${list.getTitle()}</a>

							<c:set var="tag" value="${fn:split(list.getTag(),'★')}"></c:set>
								
							<c:if test="${fn:length(tag) <= 3}">
								<c:forEach items="${tag }" var="tags">
									<span class="tagColor"><a onclick="getTag(this)" href="#">${tags }</a></span>
								</c:forEach>
							</c:if>
							<c:if test="${fn:length(tag) > 3}">
								<c:forEach begin="0" end="2" items="${tag }" var="tags">
									<span class="tagColor"><a onclick="getTag(this)" href="#">${tags }</a></span>
								</c:forEach>
							</c:if>
						</span>
						<span class="narrow">${list.getId()}</span>
						<span class="medium">${list.getDatetime()}</span>
						<span class="narrow">${list.getHits()}</span>
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
							<c:if test="${searchFlag==0 }">
								<a href="paragraphList.do?startPage=${i}">${i}</a>
							</c:if>
							<c:if test="${searchFlag==1 }">
								<a href="search.do?searchValue=${searchValue}&startPage=${i}">${i}</a>
							</c:if>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>
		</div>
	</body>
	<script>
		function writeCheck(){
			if(document.frm.searchValue.value.length==0){
				alert("검색어를 입력해주세요.");
				frm.searchValue.focus();
				return false;
			}
		}
		
		function getTag(ths){
			var text=$(ths).text();
			location.href="search.do?searchValue="+text.replace('#','')+"&startPage=1";
		}
	</script>
</html>