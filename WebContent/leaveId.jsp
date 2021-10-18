<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원 탈퇴 페이지</title>
	</head>
	<body>
		<div id="wrap">
			<form name="update" method="post" action="leaveId.do">
				<div id="wrap2">
					<h2>탈퇴 안내</h2>
					<p>회원탈퇴를 신청하기 전에 안내 사항을 꼭 확인해주세요</p>
					<P>사용하고 계신 아이디(${member.getId()})는 탈퇴할 경우 재사용 및 복구가 불가능합니다.</P>
					<P>탈퇴 후 회원정보 및 개인형 서비스 이용기록은 모두 삭제됩니다.</P>
					<P>삭제되는 내용을 확인하시고 필요한 데이터는 미리 백업을 해주세요.</P>
					<P>탈퇴 후에도 게시판형 서비스에 등록한 게시물은 그대로 남아 있습니다.</P>
					<P><input type="checkbox" id="check"><b>안내 사항을 모두 확인하였으며, 이에 동의합니다.</b></P>
					<p><input type="submit" onclick="return check1()" value="확인"></p>
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