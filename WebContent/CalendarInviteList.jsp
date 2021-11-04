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
					<div id="inviteListWrap">
						<input type="hidden" class="inviteNum" value="${list.getNum()}">
						<input type="hidden" class="inviteId" value="${list.getId()}">
						<input type="hidden" class="inviteGroupnum" value="${list.getGroupnum()}">
						<input type="hidden" class="inviteInvite" value="${list.getInvite()}">
						<div class="inviteGroupName">${list.getName() }</div>
						<input type="button" id="deniedInvite" value="거부" onclick="inviteDenied()">
						<input type="button" id="acceptInvite" value="수락" onclick="inviteAccept()">
					</div>				
				</c:forEach>
			</div>
		</div>
		<jsp:include page="footer.jsp"/>
		<form method="post" action="#" id="inviteFormData">
			<input type="hidden" id="inviteFormDataNum" name="num">
		</form>
	</body>
	<script>
		
		function inviteAccept(){
			let target = event.target;
			let v = target.parentNode;
			let num = v.getElementsByClassName("inviteNum")[0].value;
			let form = document.getElementById("inviteFormData");
			let input = document.getElementById("inviteFormDataNum");
			form.removeAttribute("action");
			
			input.setAttribute("value", num);
			form.setAttribute("action", "groupMemberInviteAccept");
			
			form.submit();
		}
		
		function inviteDenied(){
			let target = event.target;
			let v = target.parentNode;
			let num = v.getElementsByClassName("inviteNum")[0].value;
			let form = document.getElementById("inviteFormData");
			let input = document.getElementById("inviteFormDataNum");
			form.removeAttribute("action");
			
			input.setAttribute("value", num);
			form.setAttribute("action", "groupMemberInviteDenied");
			
			form.submit();
		}
	</script>
</html>