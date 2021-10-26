<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>비밀번호 수정 페이지</title>
		<style>
			#wrap2
			{
				width:500px;
				text-align:center;
				padding:10px 0 20px 0;
				border:1px solid black;
			}
			
			#wrap3
			{
				width:308px;
				text-align:left;
				display:inline-block;
			}
			
			input[type=password]
			{
				width:300px;
				height:30px;
				margin-top:10px;
			}
			
			.buttonsArea
			{
				padding-top:20px;
				text-align:center;
			}
			
			.under
			{
				display: block;
				font-size:small;
			}
		</style>
	</head>
	<body>
		<div id="wrap">
			<form name="update" method="post" action="changePw.do">
				<h2>비밀번호 수정</h2>
				<div id="wrap2">
					<div id="wrap3">
						<input name="cpw" type="password" placeholder="현재 비밀번호" onchange="isCpw(); checkCpw(); chekcCpwNPw();">
						<span class="under" id="underInfo0" style="display:none;">현재 비밀번호와 일치하지 않습니다.</span>    
						<span class="under" id="underInfo1" style="display:none;">현재 비밀번호를 입력해주세요.</span>    
						
						<input name="pw1" type="password" placeholder="새로운 비밀번호" onchange="checkPw(); chekcCpwNPw();">
						<span class="under" id="underInfo2" style="display:none;">새로운 비밀번호를 입력해주세요.</span>
						<span class="under" id="underInfo3" style="display:none;">현재 비밀번호와 새로운 비밀번호가 같습니다.</span>
						
						<input name="pw2" type="password" placeholder="새로운 비밀번호 확인" onchange="doubleCheckPw()">
						<span class="under" id="underInfo4" style="display:none;">비밀번호가 일치하지 않습니다.</span>
						
						<div class="buttonsArea">
							<input type="submit" value="수정" onclick="return check()">
							<input type="button" value="취소" onclick="location.href='userInfo.jsp'">
						</div>
					</div>
				</div>
			</form>
		</div>
		<script>
			//function0
			var currentPw=${loginUser.getPw()};
			function isCpw()
			{
				var fl=false;
				if(document.update.cpw.value!=currentPw)
				{
					document.getElementById("underInfo0").attributes.style.value="color:red;";
				}
				else
				{
					document.getElementById("underInfo0").attributes.style.value="display:none;";
					fl=true;
				}
				return fl;
			}
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
				var fl0=isCpw();
				var fl1=checkCpw();
				var fl2=checkPw();
				var fl3=chekcCpwNPw();
				var fl4=doubleCheckPw();
				if((fl0==true)&&(fl1==true)&&(fl2==true)&&(fl3==true)&&(fl4==true))
				{
					return true;
				}
				return false;
			}
		</script>
	</body>
</html>