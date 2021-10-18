<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>비밀번호 수정 페이지</title>
	</head>
	<body>
		<div id="wrap">
			<form name="update" method="post" action="changePw.do">
				<div id="wrap2">
					<span><input name="cpw" type="password" placeholder="현재 비밀번호" onchange="checkCpw(); chekcCpwNPw();"></span>
					<span id="underInfo1" style="display:none;">현재 비밀번호를 입력해주세요.</span>    
					
					<span><input name="pw1" type="password" placeholder="새로운 비밀번호" onchange="checkPw(); chekcCpwNPw();"></span>
					<span id="underInfo2" style="display:none;">새로운 비밀번호를 입력해주세요.</span>
					<span id="underInfo3" style="display:none;">현재 비밀번호와 새로운 비밀번호가 같습니다.</span>
					
					<span><input name="pw2" type="password" placeholder="새로운 비밀번호 확인" onchange="doubleCheckPw()"></span>
					<span id="underInfo4" style="display:none;">비밀번호가 일치하지 않습니다.</span>
					
					<input type="submit" value="수정" onclick="return check()">
					<input type="button" value="취소" onclick="location.href='userInfo.jsp'">
				</div>
			</form>
		</div>
		<script>
			//function1
			function checkCpw()
			{
				var fl=false;
				if(document.update.cpw.value.length==0)
				{
					document.getElementById("underInfo1").attributes.style.value="color:red;";
				}
				else
				{
					document.getElementById("underInfo1").attributes.style.value="display:none;";
					fl=true;
				}
				return fl;
			}
			//function2
			function checkPw()
			{
				var fl=false;
				if(document.update.pw1.value.length==0)
				{
					document.getElementById("underInfo2").attributes.style.value="color:red;";
				}
				else
				{
					document.getElementById("underInfo2").attributes.style.value="display:none;";
					fl=true;
				}
				return fl;
			}
			//function3
			function chekcCpwNPw()
			{
				if((document.update.cpw.value.length!=0)&&(document.update.pw1.value.length!=0))
				{
					var fl=false;
					if(document.update.cpw.value==document.update.pw1.value)
					{
						document.getElementById("underInfo3").attributes.style.value="color:red";
					}
					else
					{
						document.getElementById("underInfo3").attributes.style.value="display:none;";
						fl=true;
					}
					return fl;
				}
			}
			//function4
			function doubleCheckPw()
			{
				var fl=false;
				if(document.update.pw1.value!=document.update.pw2.value)
				{
					document.getElementById("underInfo4").attributes.style.value="color:red";
				}
				else
				{
					document.getElementById("underInfo4").attributes.style.value="display:none;";
					fl=true;
				}
				return fl;
			}
			//function5
			function check()
			{
				var fl1=checkCpw();
				var fl2=checkPw();
				var fl3=chekcCpwNPw();
				var fl4=doubleCheckPw();
				if((fl1==true)&&(fl2==true)&&(fl3==true)&&(fl4==true))
				{
					return true;
				}
				return false;
			}
		</script>
	</body>
</html>