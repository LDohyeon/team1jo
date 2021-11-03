<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>초대 보기</title>
        <link rel="stylesheet" href="style.css">
	</head>
	<body style="margin:0;">
		<jsp:include page="header.jsp"/>
		<div id="inviteWrap">
			<div id="inviteList">
				<c:forEach items="${list }" var="list">
					<div>
						<div class="inviteNum">${list.getNum() }</div>
						<div class="inviteId">${list.getId()}</div>
						<div class="inviteGroupnum">${list.getGroupnum()}</div>
						<div class="inviteInvite">${list.getInvite()}</div>
						<input type="button" id="deniedInvite" value="거부">
						<input type="button" id="acceptInvite" value="수락">
					</div>				
				</c:forEach>
			</div>
		</div>
		<jsp:include page="footer.jsp"/>
	</body>
</html>