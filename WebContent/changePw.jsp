<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>비밀번호 수정 페이지</title>
		<link rel="stylesheet" href="style.css">
		<style>
			body
			{
				background-color: #e2e2e2;
				margin:0;
			}
		
			#wrap
			{
				position: relative;
    			padding: 32px 51px 95px;
			}
		
			#wrap2
			{
				margin: 0 auto;
				background-color: #fff;
				
				width: 308px;
				text-align: left;
				padding: 40px;
				border: 1px solid #000;
			}
			
			.titleArea
			{
				margin: 0 0 10px 0;
			}
			
			input[type=password]
			{
				width: 300px;
				line-height: 30px;
				height: 30px;
				margin-top: 15px;
				padding: 5px;
				font-weight: bold;
			}
			
			.buttonsArea
			{
				padding-top: 20px;
				text-align: center;
			}
			
			.under
			{
				display: block;
				font-size: small;
			}
			
			.button
			{
				background-color: #064998;
				color: #fff;
				height: 40px;
				line-height: 40px;
				text-align: center;
				margin: 5px 0;
				font-size: 14px;
				
				width: 308px;
			}
			
			.button:hover
			{
				background-color: #005cc3;
			}
			
			.nonInputSub
			{
				padding: 0;
			    border-width: 0;
			    border-style: none;
			    border-color: #fff;
			    font-family: inherit;
			}
		</style>
	</head>
	<jsp:include page="./header.jsp"/>
	<body>
		<div id="wrap">
			<form name="update" method="post" action="changePw.do">
				<div id="wrap2">
					<h2 class="titleArea">비밀번호 수정</h2>
				
					<input name="cpw" type="password" placeholder="현재 비밀번호" onchange="isCpw(); checkCpw(); chekcCpwNPw();">
					<span class="under" id="underInfo0" style="display:none;">현재 비밀번호와 일치하지 않습니다.</span>    
					<span class="under" id="underInfo1" style="display:none;">현재 비밀번호를 입력해주세요.</span>    
					
					<input name="pw1" type="password" placeholder="새로운 비밀번호" onchange="checkPw(); chekcCpwNPw();">
					<span class="under" id="underInfo2" style="display:none;">새로운 비밀번호를 입력해주세요.</span>
					<span class="under" id="underInfo3" style="display:none;">현재 비밀번호와 새로운 비밀번호가 같습니다.</span>
					
					<input name="pw2" type="password" placeholder="새로운 비밀번호 확인" onchange="doubleCheckPw()">
					<span class="under" id="underInfo4" style="display:none;">비밀번호가 일치하지 않습니다.</span>
					
					<div class="buttonsArea">
						<input class="button nonInputSub" type="submit" value="수정" onclick="return check()">
						<div class="button" onclick="location.href='pwEnc.do'">취소</div>
					</div>
				</div>
			</form>
		</div>
		<script>
			<%request.setCharacterEncoding("utf-8");%>
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
	<jsp:include page="./footer.jsp"/>
</html>