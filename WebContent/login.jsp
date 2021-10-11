<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원가입</title>
		<link rel="stylesheet" href="style.css">
	</head>
	<body>
		<%
			String loginMsg = (String)request.getAttribute("loginMsg");
		%>
		
		<div class="wrap1">
			<form name="login" method="post" action="login.do">
				<h1>로그인</h1>
				<% 
					// 로그인 실패시 메세지 출력
					if(loginMsg != null){
				%>
						<div>
							<span class="loginMsg"><%=loginMsg %></span>
						</div>
				<%
					} 
				%>
				<div>
					<span>아이디 : </span>
					<span><input type="text" name="id"></span>
					<span class="loginIdPw"></span>
				</div>
				<div>
					<span>비밀번호 : </span>
					<span><input type="password" name="pw"></span>
					<span class="loginIdPw"></span>
				</div>
				<div>
					<span><input type="submit" value="로그인" onclick="return loginCheck()"></span>
				</div>
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
					loginMsg[0].style.display = "none";
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
				}
				return result;
			}
		</script>
	</body>
</html>