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
		<div class="wrap1">
			<form name="login" method="post" action="login.do">
				<h1>로그인</h1>
				<div>
					<span>아이디 : </span>
					<span><input type="text" name="id"></span>
				</div>
				<div>
					<span>비밀번호 : </span>
					<span><input type="password" name="pw"></span>
				</div>
				<div>
					<span><input type="submit" value="로그인" onclick="return loginCheck()"></span>
				</div>
			</form>
		</div>
		<script>
		function loginCheck(){
			if(document.login.id.value == ""){
				alert("아이디를 입력해주세요");
				document.login.id.focus();
				return false;
			}
			if(document.login.pw.value == ""){
				alert("비밀번호를 입력해주세요");
				document.login.pw.focus();
				return false;
			}
			return false;
		}
		</script>
	</body>
</html>