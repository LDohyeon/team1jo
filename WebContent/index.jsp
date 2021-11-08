<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import ="java.util.*"%>
<%@ page import="DAO.ParagraphDAO" %>
<%@ page import="DTO.ParagraphDTO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="utf-8">
		<title>STATUS 200</title>
		<link rel="stylesheet" href="style.css">
		<link rel="stylesheet" href="list.css">
	</head>
		<body>
	<% 
		ParagraphDAO pDAO = ParagraphDAO.getInstance();
		List<ParagraphDTO> list = pDAO.paragraphList(1, 10);
	%>
		<jsp:include page="header.jsp"/>
		<div class ="paragraphListWrap">
			<h2 class="titleArea">최근 게시글</h2>
			<div class="spanWrap">
				<span>
					<span class="narrow th borderRight">번호</span>
					<span class="wideTitle th borderRight txt_line2">제목</span>
					<span class="narrow th borderRight">글쓴이</span>
					<span class="medium th borderRight">날짜</span>
					<span class="narrow th borderRight">조회수</span>
					<c:choose>
						<c:when test="${loginUser.getId()!=null && loginUser.getAuthority()=='1'}">
							<span class="narrow th">삭제</span>
						</c:when>
						<c:otherwise>
							<span class="narrow th">비고</span>
						</c:otherwise>
					</c:choose>
					<br>
				</span>
				<c:forEach items="<%=list %>" var="list">
					<span class="narrow borderRight">${list.getNum() }</span>
					<span class="wide borderRight">
						
					
						<c:set var="tag" value="${fn:split(list.getTag(),'★')}"></c:set>
							
						<c:choose>
							<c:when test="${list.getTag() == ''}">
								<div class="txt_line2">
						
									<a href="paragraphEachSelect.do?num=${list.getNum()}&&flag=0">[${list.getCategory()}]${list.getTitle()}
										
									</a>
									
								</div>
							</c:when>
							<c:when test="${fn:length(tag) <= 3}">
								<div class="txt_line">
						
									<a href="paragraphEachSelect.do?num=${list.getNum()}&&flag=0">[${list.getCategory()}]${list.getTitle()}
										
									</a>
									
								</div>
								<c:forEach items="${tag }" var="tags">
									<span class="tagColor">${tags }</span>
								</c:forEach>
							</c:when>
							<c:when test="${fn:length(tag) > 3}">
								<div class="txt_line">
						
									<a href="paragraphEachSelect.do?num=${list.getNum()}&&flag=0">[${list.getCategory()}]${list.getTitle()}
										
									</a>
									
								</div>
								<c:forEach begin="0" end="2" items="${tag }" var="tags">
									<span class="tagColor">${tags }</span>
								</c:forEach>
							</c:when>
						</c:choose>	
					</span>
					<span class="narrow borderRight">${list.getId()}</span>
					<span class="medium borderRight">${list.getDatetime()}</span>
					<span class="narrow borderRight">${list.getHits()}</span>		
					<span class="narrow"> 
						<c:choose>
							<c:when test="${loginUser.getId()!=null && loginUser.getAuthority()=='1'}">
								<a class="deleteButton" onclick="return confirm('정말 삭제하시겠습니까?')" href="paragraphDelete.do?num=${list.getNum()}">삭제</a>
							</c:when>
						</c:choose>	
					</span>		
				</c:forEach>
			</div>
			
			<input class="writebutton blackSmallButton" type="button" value="더보기" onclick="location.href='paragraphList.do?startPage=1';">
			
		</div>

	<jsp:include page="./footer.jsp"/>

	</body>
</html>