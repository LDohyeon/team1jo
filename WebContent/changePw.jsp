<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>비밀번호 수정 페이지</title>
	</head>
	<body>
		<!-- 추정 원인 :: bracket에서 가져오면서 tab과 space 간격 문제 발생 -->
		<div id="wrap">
			<form method="post" action="">
				<div>
					<span><input type="password" name="id" placeholder="현재 비밀번호"></span>
					<span><input type="password" name="pw" placeholder="새로운 비밀번호"></span>
					<span><input type="password" placeholder="새로운 비밀번호 확인"></span>
					<span onclick=""><b>수정</b></span>
					<span><a href="userInfo.html"><b>취소</b></a></span>
				</div>
			</form>
		</div>
		<script>
			/*
				비밀번호 서로 동일한지 체크
				현재 비밀번호 잘못 기입 시 :: alert로 현재 비밀번호를 올바르게 입력해주세요.
				모두 참일 때, 비밀번호 변경 -> 회원정보 수정 페이지로 이동
			*/
		</script>
	</body>
</html>