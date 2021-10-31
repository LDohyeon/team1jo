<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>로그인 페이지</title>
		<style>
			.loginWrap{
				width:660px;
				margin:0px auto;
				border:1px solid black;
				margin-top:260px;
			}
			.loginForm{ 
				width:600px; 
				background:#f1f1f1;
			}
			.loginForm div{
				padding: 20px 30px;
			}
			.loginForm h1{
				margin-left:92px; 
				margin-bottom:10px; 
				font-size: 40px;
				padding-top: 10px;
			}
			.loginForm div span{
				display:inline-block; 
				width:200px; 
				text-align:center; 
				font-size: 17px;
			}
			.loginInput{
				margin:0; 
				padding:0 10px; 
				line-height:40px; 
				font-size:15px; 
				border:1px solid #dbdadf;
			}	
			.blueButton{ 
				display:block;
				width:660px;
				height:50px; 
				color:#fff; 
				background:#152aa1; 
				font-size:16px;		
			}
			.grayButton { 
				display:block;
				width:660px;
				height:50px; 
				color:#fff; 
				background:#5f5f61; 
				font-size:16px;	
			}
			.loginIdPw{
				display:inline-block;
				width:200px;
				color:#152aa1;
				padding-top:10px;
				padding-left:210px;
			}
			.loginMsg{
				width: 320px;
				color:#152aa1;
				margin-left:65px;
			}	
		</style>
	</head>
	<body>
		<%
			String loginMsg = (String)request.getAttribute("loginMsg");
		%>
		
		<div class="loginWrap">
			<form name="login" method="post" action="login.do" class="loginForm">
				<div class="loginForm">
					<h1>로그인</h1>
					<%
						if(loginMsg != null){
					%>
							<div class="loginMsg"><%=loginMsg %>
							</div>
					<%
						}
					%>
					<div>
						<span>아이디</span>
						<span>
							<input type="text" name="id" class="loginInput">
						</span>
						<span class="loginIdPw"></span>
					</div>
					<div>
						<span>비밀번호</span>
						<span>
							<input type="password" name="pw" class="loginInput">
						</span>
						<span class="loginIdPw"></span>
					</div>
				</div>
					<span><input class="blueButton" type="button" value="로그인" onclick="return loginCheck()"></span>
					<span><input class="grayButton" type="button" value="취소" onclick="cancel()"></span>
			</form>
		</div>
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