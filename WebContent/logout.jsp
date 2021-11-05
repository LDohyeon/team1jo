<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>로그아웃 페이지</title>
	</head>
	<body>
		<%
			session.invalidate(); 
		%>
		<script>
			alert("로그아웃 되었습니다");
			location="index.jsp";
		</script>
	</body>
</html>