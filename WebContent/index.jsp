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
		<a href="changePw.do">비밀번호 수정</a>
		<a href="userInfo.do">회원정보 수정</a>
		<a href="leaveId.do">회원 탈퇴</a>
		<a href="memberList.do?startPage=1">회원 관리(관리자)</a>
		<a href="paragraphEditorWrite.do">에디터 작성</a>

		${loginUser.getId()}<!-- 로그인 잘 되는지 확인용 헤더가 없어서.. -->
		${loginUser.getPw()}
		${loginUser.getName()}
		${loginUser.getEmail()}
		
	</body>
</html>