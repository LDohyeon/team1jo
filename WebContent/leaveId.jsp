<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원 탈퇴 페이지</title>
		<style>
			body
			{
				background-color:#e2e2e2;
			}
		
			#wrap
			{
				position: relative;
    			padding: 32px 51px 95px;
			}
		
			#wrap2
			{
				margin:0 auto;
				background-color:#fff;
				
				width:470px;
				padding:20px;
				border:5px solid #000;
				border-style: double;
			}
		
			.leaveIdP
			{
				margin:5px 0 0 0;
			}
			
			.leaveIdcontext
			{
				color:#666;
			}
			
			.leaveIdPWrap
			{
				color:#FF4337;
				font-weight:bold;
			}
			
			.buttonsArea
			{
				padding-top:20px;
				text-align:center;
			}
			
			.button
			{
				background-color:#064998;
				color:#fff;
				height:40px;
				line-height:40px;
				text-align:center;
				margin:5px 0;
				font-size: 14px;
				
				width:80px;
			}
			
			.button:hover
			{
				background-color:#005cc3;
			}
			
			.nonInputSub
			{
				padding: 0;
			    border-width: 0;
			    border-style: none;
			    border-color: #fff;
			    font-family:inherit;
			}
		</style>
	</head>
	<body>
		<div id="wrap">
			<form name="update" method="post" action="leaveId.do">
				<div id="wrap2">
					<h2>탈퇴 안내</h2>
					<p class="leaveIdcontext">회원탈퇴를 신청하기 전에 안내 사항을 꼭 확인해주세요</p>
					<div class="leaveIdPWrap">
						<p class="leaveIdP">사용하고 계신 아이디(${loginUser.getId()})는 탈퇴할 경우 재사용 및 복구가 불가능합니다.</p>
						<p class="leaveIdP">탈퇴 후 회원정보 및 개인형 서비스 이용기록은 모두 삭제됩니다.</p>
						<p class="leaveIdP">삭제되는 내용을 확인하시고 필요한 데이터는 미리 백업을 해주세요.</p>
						<p class="leaveIdP">탈퇴 후에도 게시판형 서비스에 등록한 게시물은 그대로 남아 있습니다.</p>
					</div>
					<p><input type="checkbox" id="check"><b>안내 사항을 모두 확인하였으며, 이에 동의합니다.</b></p>
					<div class="buttonsArea"><input class="button nonInputSub" type="submit" onclick="return check1()" value="확인"></div>
				</div>
			</form>
		</div>
		<script>
			var checkbox=document.getElementById("check");
			function check1()
			{ 
				if(checkbox.checked==false)
				{
					alert("안내사항을 동의해야 탈퇴가 가능합니다.");
					return false;
				}
				return true;
			}
		</script>
	</body>
</html>