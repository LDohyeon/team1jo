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
				margin: 0;
				padding: 0;
			}
			
			.titleArea
			{
				margin: 0 0 10px 0;
			}
			
			.paragraphListWrap
			{
				width: 850px;
				padding: 35px;
				border : 1px solid #dbdadf;
				margin : 60px auto;		
			}
			
			.search
			{
				background-color: #f1f1f1;
				padding: 15px;
				margin: 15px 0;
			}
			
			#searchValue
			{
				width: 487px;
				height: 28px;
				padding: 5px;
			}
			
			.button
			{
				background-color: #064998;
				color: #fff;
				text-align: center;
				font-size: 14px;
				
				margin: 0;
				width: 60px;
				height: 42px;
				line-height: 42px;
				display: inline-block;
			}
			
			.writebutton
			{
    			background-color: #222;
    			color: #fff;
    			border: 1px solid #000;
    			line-height: 40px;
				text-align: center;
				font-size: 14px;
				
				margin: 0 0 0 190px;
				width: 60px;
				height: 42px;
				display: inline-block;
			}
			
			.nonInputSub
			{
				padding: 0;
			    border-width: 0;
			    border-style: none;
			    border-color: #fff;
			    font-family: inherit;
			}
			
			.spanWrap::after
			{
				content: "";
				display: block;
				clear: both;
			}
			
			.th
			{
				font-weight: bold;
				background-color: #f1f1f1;
				border-top: 1.5px solid #222;
				
			}
			
			.borderRight
			{
				border-right: 1px solid #dbdadf;
			}
			
			.narrow
			{
				text-align: center;
				display: inline-block;
				width: 70px;
				padding: 10px;
				float: left;
				border-bottom: 1px solid #dbdadf;
				
			}
			
			.medium
			{
				text-align: center;
				display: inline-block;
				width: 165px;
				padding: 10px;
				float: left;
				border-bottom: 1px solid #dbdadf;
			}
			
			.wide
			{
				text-align: center;
				display: inline-block;
				width: 371px;
				padding: 10px;
				float: left;
				border-bottom: 1px solid #dbdadf;
			}
			
			.pageNum
			{
				text-align: center;
			}
			
			.tagColor
			{
				color: blue;
			    background-color: lightblue;
			    border-color: blue;
			    margin-right: 5px;
			}
		</style>
	</head>
	<body>
		<div class ="paragraphListWrap">
			<h2 class="titleArea">게시판</h2>
			<div class="search">
				<form method="get" action="search.do" name="frm">
					<input type="text" name="searchValue" id="searchValue">
					<input type="hidden" name="startPage" value="1">
					<input class="button nonInputSub" type="submit" value="검색" onclick="writeCheck()">
					<c:if test="${loginUser.id!=null}">
						<input class="writebutton" type="button" value="글쓰기" onclick="location.href='paragraphEditorWrite.do';">
					</c:if>
				</form>
			</div>
			<div class="spanWrap">
				<span>
					<span class="narrow th borderRight">번호</span>
					<span class="wide th borderRight">제목</span>
					<span class="narrow th borderRight">글쓴이</span>
					<span class="medium th borderRight">날짜</span>
					<span class="narrow th">조회수</span>
				</span>
				<c:forEach items="${list }" var="list">
					<span>
						<span class="narrow borderRight">${list.getNum() }</span>
						<span class="wide borderRight">
							<a href="paragraphEachSelect.do?num=${list.getNum()}">[${list.getCategory()}]${list.getTitle()}</a>

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
						<span class="narrow borderRight">${list.getId()}</span>
						<span class="medium borderRight">${list.getDatetime()}</span>
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