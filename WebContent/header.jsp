<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>Insert title here</title>
		<style>
			body{
                margin: 0;
                padding: 0;
                font-size: 1.2em;
            }
			header{
                padding: 20px;
            }
			.ulist{
                margin: 0;
                padding: 0;
                list-style-type: none;
                float: right;
            }
            .list{
                display: inline;
                margin: 0 20px 0 0 ;
            }
            section {
                padding: 20px;
                display: flex;
                background-color: #222;;
            }
            section > div {
                margin: auto;
                width: 150px;
                height: 25px;
                
            }
            .title{
				text-align:center;
			}
			.linkBlack{
				color: black;
				text-decoration:none;
			}
			.linkWhite{
				color: #BEBEBE;
				text-decoration:none;
			}
		</style>
	</head>
	<body>
		<header>
			<div class="ulist">
	        	<c:choose>
					<c:when test="${loginUser.getId()==null}">
						<div class="list"><a class="linkBlack" href="login.do">로그인</a></div>
			            <div class="list"><a class="linkBlack" href="register.do">회원가입</a></div>
					</c:when>
					<c:when test="${loginUser.getId()!=null && loginUser.getAuthority()=='1'}">
						<div class="list">안녕하세요, ${loginUser.getId()}님!</div>
						<div class="list"><a class="linkBlack" href="logout.jsp">로그아웃</a></div>
			            <div class="list"><a class="linkBlack" href="#">마이페이지</a></div>
			            <div class="list"><a class="linkBlack" href="#">관리페이지</a></div>
					</c:when>
					<c:otherwise>
						<div class="list">안녕하세요, ${loginUser.getId()}님!</div>
				        <div class="list"><a class="linkBlack" href="logout.jsp">로그아웃</a></div>
				        <div class="list"><a class="linkBlack" href="#">마이페이지</a></div>
					</c:otherwise>
				</c:choose>
	        </div>
			<div class=title><h1>STATUS 200</h1></div>
			<section>
		        <div><a class="linkWhite" href="paragraphList.do?startPage=1">게시판</a></div>
		        <div><a class="linkWhite" href="#">캘린더</a></div>
	  	 	</section>
	  	 	<span class="search">
				<form method="get" action="search.do" name="frm">
					<input type="text" name="searchValue" id="searchValue">
					<input type="hidden" name="startPage" value="1">
					<input type="submit" value="검색" onclick="writeCheck()">
				</form>
			</span>
		</header>
	</body>
</html>