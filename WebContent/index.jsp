<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import ="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
	<html>
	<head>
		<meta charset="utf-8">
		<title>Insert title here</title>
	</head>
	<body>
		<a href="register.do">회원가입</a>
		<a href="login.do">로그인</a>
		${loginUser.getId()}<!-- 로그인 잘 되는지 확인용 헤더가 없어서.. -->
		${loginUser.getPw()}
		
	</body>
</html>