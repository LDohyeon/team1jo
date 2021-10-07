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
			<form method="post" action="login.do">
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
					<span><input type="submit" value="로그인"></span>
				</div>
			</form>
		</div>
	</body>
</html>