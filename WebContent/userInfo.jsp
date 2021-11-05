<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원정보 수정 페이지</title>
		<link rel="stylesheet" href="style.css">
		<style>
			#wrap
			{
				position: relative;
    			padding: 32px 51px 95px;
			}
		
			#wrap2
			{
				margin: 0 auto;
				
				text-align: center;
				width: 600px;
			}
			
			.userInfoWrap
			{
				text-align: left;
			}
			
			.userInfoDiv
			{
				font-size: small;
			}
			
			.userInfoTable
			{
				
				margin: 5px 0;
				border-collapse: collapse;
				border-top: 1px solid #272324;
			}
			
			.userInfoTd
			{
				padding: 30px;
				font-weight: bolder;
				background-color: #f1f1f1;
				border-bottom: 1px solid #dbdadf;
				border-right: 1px solid #dbdadf;
			}
			
			.userInfoTdContext
			{
				padding: 30px;
				width: 400px;
				text-align: left;
				border-bottom: 1px solid #dbdadf;
			}
			
			.buttonsArea
			{
				padding-top: 20px;
				text-align: center;
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
				
				width: 80px;
				display: inline-block;
			}
			
			.button2
			{
			    height: 25px;
			    line-height: 25px;
			    text-align: center;
			    margin: 5px;
			    font-size: 10px;
			    width: 44px;
    			border: 1px solid #dbdadf;
    			background-color: #f1f1f1;
    			color: #000;
    			
    			display: inline-block;
			}
			
			.button:hover
			{
				background-color: #005cc3;
			}
			
			.button2:hover
			{
				background-color: #fff;
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
			<form name="update" method="post" action="userInfo.do">
				<div id="wrap2">
					<div class="userInfoWrap">
						<h2 class="userInfoH2">회원 정보 수정</h2>
						<div class="userInfoDiv">별명과 이메일을 수정할 수 있습니다.</div>
						<div class="userInfoDiv">비밀번호를 수정하려면 수정 버튼을 눌러주세요.</div>
					</div>
					<table class="userInfoTable">
						<tr>
							<td class="userInfoTd">아이디</td>
							<td class="userInfoTdContext"><p>${loginUser.getId()}</p></td>
						</tr>
		                <tr>
							<td class="userInfoTd">비밀번호</td>
							<td class="userInfoTdContext">
								<span>${pwEnc}</span>
								<div class="button2" onclick="location.href='changePw.jsp'">수정</div>
							</td>
						</tr>
						<tr>
							<td class="userInfoTd">이름</td>
							<td class="userInfoTdContext">
								<span><input onchange="return checkName()" type="text" name="name" value="${loginUser.getName()}"></span>
								<span id="underInfo1" style="display:none;">이름을 입력해주세요.</span>
							</td>
						</tr>
						<tr>
							<td class="userInfoTd">이메일</td>
							<td class="userInfoTdContext">
								<span><input onchange="return checkEmail()" type="email" name="email" value="${loginUser.getEmail()}"></span>
								<span id="underInfo2" style="display:none;">이메일 주소를 입력해주세요.</span>
							</td>
						</tr>
					</table>
					<div class="buttonsArea">
						<input class="button nonInputSub" name="submit" type="submit" value="적용" onclick="return check()">
						<div class="button" onclick="location.href='index.jsp'">취소</div>
					</div>
				</div>
			</form>
		</div>
		<script>
			//fucntion1
			function checkName()
			{
				var fl="false";
				if(document.update.name.value==0)
				{
					document.getElementById("underInfo1").attributes.style.value="color:red;";
				}
				else if(document.update.name.value!=0)
				{
					document.getElementById("underInfo1").attributes.style.value="display:none;";
					fl=true;
				}
				return fl;
			}
			//fucntion2   
			function checkEmail()
			{    
				var fl="false";
				if(document.update.email.value==0)
				{
					document.getElementById("underInfo2").attributes.style.value="color:red;";
				}
				else if(document.update.email.value!=0)
				{
					document.getElementById("underInfo2").attributes.style.value="display:none;";
					fl=true;
				}
				return fl;
			}
			/*fucntion3
			function changeBtnColor()
			{
			    var flag1=checkName();
			    var flag2=checkEmail();
			    console.log(flag1);
			    console.log(flag2);
			    console.log((flag1==false)||(flag2==false));
			    console.log(document.update.submit.attributes);
			    if((flag1==false)||(flag2==false))
			    {
			        document.update.submit.setAttributes("color",red);
			    }
			}*/
			//function4
			function check()
			{
				var flag1=checkName();
				var flag2=checkEmail();
				if((flag1==true)&&(flag2==true))
				{
					return true;
				}
				return false;
			}
	</script>
	</body>
	<jsp:include page="./footer.jsp"/>
</html>