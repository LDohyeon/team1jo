<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import ="java.util.*"%>
<%@ page import="DAO.ParagraphDAO" %>
<%@ page import="DTO.ParagraphDTO" %>
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
            section {
                padding: 20px;
                display: flex;
                background-color: lightgray;
            }
            footer{
            	text-align: center;
            	font-size: 0.8em;
                padding: 20px;
                color: gray;
            }
 
            section > div {
                margin: auto;
                width: 150px;
                height: 25px;
                
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
            .paragraphListWrap
			{
				width:1200px;
				padding:15px;
				border : 1px solid lightgray;
				margin : 60px auto;			
			}
			.spanWrap
			{
				border : 1px solid lightgray;
			}
			.narrow{
				text-align:center;
				display :inline-block;
				width: 11%;
			}
			.medium{
				text-align:center;
				display :inline-block;
				width: 19%;
			}
			.wide{
				text-align:center;
				display :inline-block;
				width: 45%;
			}
			.tagColor
			{
				color: blue;
			    background-color: lightblue;
			    border-color: blue;
			    margin-right:5px;
			}
			.title{
				text-align:center;
			}
			.linkBlack{
				color: black;
				text-decoration:none;
			}
			

		</style>
	</head>
	<body>
	<% 
		ParagraphDAO pDAO = ParagraphDAO.getInstance();
		List<ParagraphDTO> list = pDAO.paragraphList(1, 10);
	%>
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
		        <div><a class="linkBlack" href="paragraphList.do?startPage=1">게시판</a></div>
		        <div><a class="linkBlack" href="#">캘린더</a></div>
	  	 	</section>
		</header>
		<div class ="paragraphListWrap">
			<h4>최근 게시글</h4>
			<div class="spanWrap">
				<span>
					<span class="narrow">번호</span>
					<span class="wide">제목</span>
					<span class="narrow">글쓴이</span>
					<span class="medium">날짜</span>
					<span class="narrow">조회수</span>
					<br>
				</span>
				<c:forEach items="<%=list %>" var="list">
					<span>
						<span class="narrow">${list.getNum() }</span>
						<span class="wide">
							<a href="paragraphEachSelect.do?num=${list.getNum()}">[${list.getCategory()}]${list.getTitle()}</a>
							<c:set var="tag" value="${fn:split(list.getTag(),'★')}"></c:set>
								
							<c:if test="${fn:length(tag) <= 3}">
								<c:forEach items="${tag }" var="tags">
									<span class="tagColor">${tags }</span>
								</c:forEach>
							</c:if>
							<c:if test="${fn:length(tag) > 3}">
								<c:forEach begin="0" end="2" items="${tag }" var="tags">
									<span class="tagColor">${tags }</span>
								</c:forEach>
							</c:if>
						</span>
						<span class="narrow">${list.getId()}</span>
						<span class="medium">${list.getDatetime()}</span>
						<span class="narrow">${list.getHits()}</span>
						<br>
					</span>				
				</c:forEach>
			</div>
			<c:if test="${loginUser.id!=null}">
				<input class="writebutton" type="button" value="더보기" onclick="location.href='paragraphList.do?startPage=1';">
			</c:if>
		</div>
		<a href="register.do">회원가입</a>
		<a href="login.do">로그인</a>
		<a href="logout.jsp">로그아웃</a>
		<a href="changePw.do">비밀번호 수정</a>
		<a href="userInfo.do">회원정보 수정</a>
		<a href="leaveId.do">회원 탈퇴</a>
		<a href="memberList.do?startPage=1">회원 관리(관리자)</a>
		<a href="registerNumberServlet.do">회원가입자수/게시글 수(차트)</a>
		<a href="paragraphEditorWrite.do">에디터 작성</a>
		<a href="paragraphList.do?startPage=1">게시판 확인</a>
		<a href="suspension.do?">회원정지 날짜 계산하기</a>
		<a href="chart02Servlet.do?">작성한 글 관련 차트</a>
		<a href="chartTag.do">태그 개수(차트)</a>
		
		${loginUser.getId()}<!-- 로그인 잘 되는지 확인용 헤더가 없어서.. -->
		${loginUser.getPw()}
		${loginUser.getName()}
		${loginUser.getEmail()}
		${loginUser.getAuthority()}
		
		<footer>
			서울북부기술교육원 IOT융합프로그래밍과 팀프로젝트 1조<br>
			조장: 이도현 / 조원: 김종현 박정현 석지애 유제민 윤하영
		</footer>
	</body>
</html>