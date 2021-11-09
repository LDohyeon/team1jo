<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="UTF-8">
		<title>로그인 페이지</title>
		<link rel="stylesheet" href="style.css">
		<style>
			.wrap{
				margin:30px 0px 100px 0px;
				align-items:center;
				display:flex;
				justify-content:center;
				
				min-height: calc(100vh - 290px);
			}
			.loginWrap{
				width:546px; 
				border:1px solid rgb(20, 20, 20);
				padding:15px 0px;
				
			}
			.loginForm{ 
				background:#f1f1f1;
			}
			.loginWrap{
				padding:20px 30px;
			}
			.loginForm .LoginH1{ 
				margin-bottom:10px; 
				font-size:25px;
				padding-top:10px;
				text-align:center;
			}
			.loginForm div span{
				display:inline-block; 
				width:150px; 
				text-align:center; 
			}
			.loginInput{
				margin:0; 
				padding:0 10px; 
				line-height:40px; 
				height: 40px;
				font-size: 0.9em; 
				border:1px solid #dbdadf;
			}
			.button
			{
				background-color:#064998;
				color:#fff;
				height:40px;
				line-height:40px;
				text-align:center;
				font-size: 0.9em;
			}
			.button:hover
			{
				background-color:#005cc3;
			}
			.buttonSub
			{
				padding:0;
			    border-width:0;
			    border-style:none;
			    border-color:#fff;
			    font-family:inherit;
			}	
			.loginIdPw{
				width:200px;
				color:#152aa1;
				height: 24px;
				line-height: 24px;
				text-align: center;
				font-size: 0.7em; 
			}
			.loginMsg{
				color:#152aa1;
				text-align:center;
			}	
			#loginArea{
				padding: 20px;
				margin: 0 auto;
			}
			.loginAreaInId, .loginAreaInPw{
				display: flex;
				margin-bottom: 3px;
			}
			.loginInputFlex{
				width: calc(100% - 22px);
			}
			.buttonArea, .loginAlertArea{
				display: flex;
			}
			.blankArea{
				flex: 3;
				margin-top: 5px;
			}
			.buttonSub{
				flex: 10;
				margin-bottom: 5px;
			}
			.loginAreaInText{
				line-height: 40px;
				flex: 3;
				font-size: 1em;
			}
			.loginAreaInput, .loginIdPw{
				flex: 10;
			}
			.loginAlertArea{
				margin-bottom: 2px;
			}
			.buttonArea:first-child{
				margin-top: 5px;
			}
		</style>
	</head>
	<body>
		<jsp:include page="./header.jsp"></jsp:include>
		<%
			String loginMsg = (String)request.getAttribute("loginMsg");
		%>
		<div class="wrap">
			<form name="login" method="post" action="login.do" class="loginForm">
				<div class="loginWrap">
					<div class="loginForm">
						<h1 class="LoginH1">로그인</h1>
						<%
							if(loginMsg != null){
						%>
								<div class="loginMsg"><%=loginMsg %>
								</div>
						<%
							}
						%>
						<div id="loginArea">
							<div class="loginAreaInId">
								<span class="loginAreaInText">아이디</span>
								<span class="loginAreaInput">
									<input type="text" name="id" class="loginInput loginInputFlex">
								</span>
								<span class="blankArea"></span>
							</div>
							<div class="loginAlertArea">
								<div class="blankArea"></div>
								<div class="loginIdPw"></div>
								<div class="blankArea"></div>
							</div>
							<div class="loginAreaInPw">
								<span class="loginAreaInText">비밀번호</span>
								<span class="loginAreaInput">
									<input type="password" name="pw" class="loginInput loginInputFlex">
								</span>
								<span class="blankArea"></span>
							</div>
							<div class="loginAlertArea">
								<div class="blankArea"></div>
								<div class="loginIdPw"></div>
								<div class="blankArea"></div>
							</div>
							<div class="buttonArea">
								<div class="blankArea"></div>
								<input class="button buttonSub" type="button" value="로그인" onclick="return loginCheck()">
								<div class="blankArea"></div>
							</div>
							<div class="buttonArea">
								<div class="blankArea"></div>
								<input class="button buttonSub" type="button" value="취소" onclick="cancel()">
								<div class="blankArea"></div>
							</div>
						</div>					
					</div>	
				</div>
			</form>
		</div>
		<jsp:include page="./footer.jsp"></jsp:include>
		
		<script>
			var frm = document.login;
			var loginIdPw = document.getElementsByClassName("loginIdPw");
			var loginMsg = document.getElementsByClassName("loginMsg");
			
			for(i=0; i<loginIdPw.length; i++){
				loginIdPw[i].style.display = "none";	
			}
			
			// 로그인 유효성 검사
			function loginCheck(){			
				for(i=0; i<loginIdPw.length; i++){
					loginIdPw[i].style.display = "none";	
				}
				
				var result = true;
				if(result){
					if(frm.id.value == ""){
						loginIdPw[0].innerHTML = "아이디를 입력해주세요";	
						loginIdPw[0].style.display = "block";	
						frm.id.focus();
						result = false;
					}
					
					if(frm.pw.value == ""){
						loginIdPw[1].innerHTML = "비밀번호를 입력해주세요";	
						loginIdPw[1].style.display = "block";	
						frm.pw.focus();
						result = false;
					}
					
					if(result == true){
						frm.submit();
					}
				}
				return result;
			}
			
			function cancel(){
				location.href="./index.jsp";
			}
		</script>
	</body>
</html>