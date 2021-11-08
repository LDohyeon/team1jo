<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="utf-8">
		<title>초대 보기</title>
        <link rel="stylesheet" href="style.css">
        <style>
        	#inviteWrap{
        		width: 600px;
        		margin: 0 auto;
        		margin-top: 30px;
        		min-height: 68.7vh;
        		overflow: auto;
        		margin-bottom: 30px;
        		
        	}
        	
        	.inviteGroupName{
        		width: 434px;
        		height: 32px;
        		line-height: 32px;
       
        		border-radius: 10px;
        		display: block;
        		float: left;
        		text-overflow: ellipsis;
    
        	}
        	.inviteListWrap{
        		padding-top: 10px;
        		padding-bottom: 10px;
        	}
        	.inviteListWrap::after{
        		content: "";
        		display: block;
        		clear: both;
        	}
        	.deniedInvite, .acceptInvite{
        		border: 0;
        		border-radius: 4px;
        		height: 32px;
        		width: 80px;
        		background-color: rgb(245,245,245);
        		margin-left: 2px;
        		float: left;
        		font-size: 0.85em;
        		letter-spacing: -1px;
        	}
        	.deniedInvite:hover{
        		background-color: #e95159;
        	}
        	.acceptInvite:hover{
        		background-color: #81c147;
        	}
        	#inviteTitle{
        		font-size: 1em;
        		padding-bottom: 12px;
        		letter-spacing: -1px;
        		font-weight: 600;
        	}
        	hr{
        		opacity: 0.5;
        		width: 598px;
        		margin: 0 auto;
        	}
        	hr:last-child{
        		border: 0;
        	}
        </style>
	</head>
	<body style="margin:0;">
		<jsp:include page="header.jsp"/>
		<div id="inviteWrap">
			<div id="inviteList">
				<div id="inviteTitle">초대 리스트</div>	
				<c:forEach items="${list }" var="list">
					<div class="inviteListWrap">
						<input type="hidden" class="inviteNum" value="${list.getNum()}">
						<input type="hidden" class="inviteId" value="${list.getId()}">
						<input type="hidden" class="inviteGroupnum" value="${list.getGroupnum()}">
						<input type="hidden" class="inviteInvite" value="${list.getInvite()}">
						<div class="inviteGroupName">${list.getName() }</div>
						<input type="button" class="deniedInvite" value="거부" onclick="inviteDenied()">
						<input type="button" class="acceptInvite" value="수락" onclick="inviteAccept()">
					</div>	
					<hr>			
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