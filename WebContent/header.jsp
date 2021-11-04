<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class=headerArea>
	<div id=headerBasicArea>
		<div id=headerLogo></div>
		<div id=headerMenu>
			<div class="headerMenuElement"><a class="linkWhite" href="paragraphList.do?startPage=1">게시판</a></div>
	      	<div class="headerMenuElement"><a class="linkWhite" href="#">캘린더</a></div>
		</div>
		<div id="headerIcon">
			<div id="headerSearchIcon"></div>
			<div id="headerProfileIcon"></div>
		</div>
	</div>
	<div id=headerSearchArea>
		<div id="headerSearch">
			<form method="get" action="search.do" name="frm" id="headerForm">
				<input type="text" name="searchValue" id="searchValue">
				<input type="hidden" name="startPage" value="1">
				<input type="submit" value="" onclick="writeCheck()" id="searchValueBtn">
				<input type="button" value="X" id="searchXBtn">
			</form>
		</div>
	</div>
	<div id="headerProfileArea">
		<div id="headerBlackArea"></div>
		<div class="headerUlist">
		<c:choose>
			<c:when test="${loginUser.getId()==null}">
				<div class="headerlist"><a class="linkBlack" href="login.do">로그인</a></div>
		        <div class="headerlist"><a class="linkBlack" href="register.do">회원가입</a></div>
			</c:when>
			<c:when test="${loginUser.getId()!=null && loginUser.getAuthority()=='1'}">
				<div class="headerlist">안녕하세요, ${loginUser.getId()}님!</div>
				<div class="headerlist"><a class="linkBlack" href="logout.jsp">로그아웃</a></div>
		        <div class="headerlist"><a class="linkBlack" href="#">마이페이지</a></div>
		        <div class="headerlist"><a class="linkBlack" href="#">관리페이지</a></div>
			</c:when>
			<c:otherwise>
				<div class="headerlist">안녕하세요, ${loginUser.getId()}님!</div>
		        <div class="headerlist"><a class="linkBlack" href="logout.jsp">로그아웃</a></div>
		        <div class="headerlist"><a class="linkBlack" href="#">마이페이지</a></div>
			</c:otherwise>
		</c:choose>
	</div>
	</div>
</div>
<script>	
	let headerSearchBarStmt = false;
	
	// 헤더 서치 기능 동작 
	let headerSearchIcon = document.getElementById("headerSearchIcon");
	headerSearchIcon.addEventListener("click", function(){
		let headerBasicArea = document.getElementById("headerBasicArea");
		headerBasicArea.setAttribute("style", "display:none");
		
		let headerSearchArea = document.getElementById("headerSearchArea");
		headerSearchArea.setAttribute("style", "display:block");
		headerSearchBarStmt = true;
	});
	
	let searchXBtn = document.getElementById("searchXBtn");
	searchXBtn.addEventListener("click", function(){
		let headerBasicArea = document.getElementById("headerBasicArea");
		headerBasicArea.setAttribute("style", "display:block");
		
		let headerSearchArea = document.getElementById("headerSearchArea");
		headerSearchArea.setAttribute("style", "display:none");
		headerSearchBarStmt = false;
	});
	
	let headerProfileIcon = document.getElementById("headerProfileIcon");
	let headerUlist = document.getElementsByClassName("headerUlist")[0];
	
	function mouseoverUlist(){
		headerUlist.setAttribute("style", "display:block");
	}
	
	function mouseoutUlist(){
		sleep(200);
		headerUlist.setAttribute("style", "display:none");
		
	}
	function sleep(second) {
		const wakeUpTime = Date.now() + second;
		while (Date.now()<wakeUpTime) {
			
		}
	}
	headerProfileIcon.addEventListener("mouseover", mouseoverUlist);
	headerUlist.addEventListener("mouseover", mouseoverUlist);
	headerProfileIcon.addEventListener("mouseout", mouseoutUlist);
	headerUlist.addEventListener("mouseout", mouseoutUlist);
	
</script>