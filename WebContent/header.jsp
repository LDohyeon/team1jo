<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div class=headerArea>
	<div id=headerBasicArea>
		<div id="headerLogo" onclick="location.href='index.jsp'"></div>
		<div id="headerMenu">
			<div class="headerMenuElement"><a class="linkWhite" href="paragraphList.do?startPage=1">게시판</a></div>
	      	<div class="headerMenuElement"><a class="linkWhite" href="Calendar">캘린더</a></div>
		</div>
		<div id="headerIcon">
			<div id="headerSearchIcon"></div>
			<div id="headerProfileIcon"></div>
		</div>
	</div>
	<div id=headerSearchArea >
		<div id="headerSearch">
			<form method="get" action="search.do" id="headerForm">
				<input type="text" name="searchValue" id="searchValue" onKeyup="autoSearch()" onKeydown="autoSearch()">
				<input type="hidden" name="startPage" value="1">
				<input type="submit" value="" onclick="writeCheck()" id="searchValueBtn">
				<input type="button" value="X" id="searchXBtn">		
				<div id="divTable"></div>
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
		        <div class="headerlist"><a class="linkBlack" href="userInfo.do">마이페이지</a></div>
		        <div class="headerlist"><a class="linkBlack" href="memberList.do?startPage=1">관리페이지</a></div>
			</c:when>
			<c:otherwise>
				<div class="headerlist">안녕하세요, ${loginUser.getId()}님!</div>
				<div class="headerlist"><a class="linkBlack" id="inviteGo" href="InviteList">초대보기</a></div>
		        <div class="headerlist"><a class="linkBlack" href="logout.jsp">로그아웃</a></div>
		        <div class="headerlist"><a class="linkBlack" href="userInfo.do">마이페이지</a></div>
		        <div class="headerlist"><a class="linkBlack" href="myWrite.do?startPage=1">내가 쓴 글</a></div>
			</c:otherwise>
		</c:choose>
	</div>
	</div>
	<div style="display: none;">
		<form method="post" action="InviteList" id="headHiddenForm">
			<input type="hidden" name="userKey" value="${loginUser.getId()}">
		</form>
	</div>
</div>
<script>	
	let hiddenFormInvite = document.getElementById("headHiddenForm");

	function inviteSubmit(){
		hiddenFormInvite.submit();
	}
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
<script>
	// 소켓 통신으로 알림 구현을 해보려는 블럭 
	// 세션 데이터를 전역 변수로 할당하여 사용함 
	let userKey = "${loginUser.getId()}+";
	let alertHave = false; 
	
/* ====================================================================
 * ==== 알림 ===========================================================
 * ====================================================================*/  	
 		
	//Invite XHR 
	var XHRInvite;
	
	function createXHRInvite(){
		if(window.ActiveXObject){ 
			XHRInvite=new ActiveXObject("Microsoft.XMLHTTP");
		}
		else if(window.XMLHttpRequest){
			XHRInvite=new XMLHttpRequest();
		}
	}
	
	function checkInvite(){
		createXHRInvite();
		
		XHRInvite.onreadystatechange=function(){
			if(XHRInvite.readyState==4){
	            if(XHRInvite.status==200){
	            	let jsons = JSON.parse(XHRInvite.responseText, "text/json");
	            	
	            	if(jsons.alert==true){
	            		alertHave = true;
	            	}
	            	else{
	            		alertHave = false;
	            	}
	            	youHaveAlert();
	            }
			}
		}
		XHRInvite.open("POST", "checkInvite", true);
		XHRInvite.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
		XHRInvite.send("userKey="+userKey);
	}
	
	// 소켓 사용을 위한 자바스크립트
	// 추후에 jsp include에 사용되어 모든 페이지에 적용할 수도 있음
	
	let webSocket = new WebSocket("ws://localhost:8080/team1jo/socketAlert");
	
	webSocket.onopen=function(){
		
	};
	
	webSocket.onclose=function(){
		
	};
	
	webSocket.onmessage = function inviteAlert(message){
		let data = message.data; 
		console.log(message);
		if(data==userKey){
			alertHave = true;
		}
		youHaveAlert();
	};
	checkInvite();
	function youHaveAlert(){
		let profile = document.getElementById("headerProfileIcon");
		if(alertHave==true){
			profile.setAttribute("style", "background-image: url(./imgSource/profileIconAlert.png);")
		}
		else{
			profile.removeAttribute("style");
		}
	}
</script>


<script>
	var XHR;
	
	function createXMLHttpRequest()
	{
		if(window.ActiveXObject)
		{
			XHR=new ActiveXObject("Microsoft.XMLHTTP");
		}
		else if(window.XMLHttpRequest)
		{
			XHR=new XMLHttpRequest();
		}
	}
	
	function autoSearch()
	{
		var searchValue = document.getElementById("searchValue").value;
		if(searchValue.length>0)
		{
			createXMLHttpRequest();
			console.log(XHR);
			var url="paragraphAutoSearch.do";
			XHR.open("POST", url, true);
			XHR.onreadystatechange=handleStateChange;
			XHR.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			
			XHR.send("searchAuto="+searchValue);
	
		}		
	}
	
	function handleStateChange()
	{
		if(XHR.readyState==4)
		{
			if(XHR.status==200)
			{
				//console.log(XHR.responseText);
				
				var json = JSON.parse(XHR.responseText);

				searchDiv(json);
			}
		}
		else if(XHR.status==204)
		{
			alert("204");
		}
	}
	
	

	
	
	function searchDiv(json)
	{
		var divTable = document.getElementById("divTable");
		var searchValue = document.getElementById("searchValue");
		
		while(divTable.hasChildNodes())
		{
			divTable.removeChild(divTable.firstChild);	
		}
		
		if(searchValue.value.length!=0){
			divTable.setAttribute("style", "display: block;");
		
			console.log(searchValue.value.length);
		}
		else{
			divTable.setAttribute("style", "display: none;");
		}
		
		var divTr = document.createElement("div");
		
		divTr.setAttribute("id", "divTr");
		
		
		
		for(var i=0; i<json.length; i++)
		{
			var divTd = document.createElement("div");

			var aTag = document.createElement("a");
			
			aTag.setAttribute("href", "search.do?searchValue="+json[i].auto+"&startPage=1");
	
			
			divTd.innerText=json[i].auto;
			
			aTag.appendChild(divTd);
			
			divTd.setAttribute("class", "divTd");

			
			divTr.appendChild(aTag);
			
		}
		
		divTable.appendChild(divTr);
			
	}
	
	

	

</script>
