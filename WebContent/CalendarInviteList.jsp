<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<% 
	// 유저키를 세션에서 가져옴
	String userKey = null;

	try{
		userKey = "'"+session.getAttribute("loginUserId").toString()+"'"; 
	}
	catch(Exception e){
		System.out.println("Session get Error: calendarMain.jsp: line 10: >>" +e);
	}
%>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>초대보기</title>
        <link rel="stylesheet" href="CalendarCss.css">
        <link rel="stylesheet" href="style.css">
		<style>
			*
			{
				margin: 0;
				padding: 0;
			}
			
			.titleArea
			{
				margin: 0 0 10px 0;
			}
			
			.paragraphListWrap
			{
				width: 850px;
				padding: 35px;
				border : 1px solid #dbdadf;
				margin : 60px auto;		
			}
			
			.search
			{
				background-color: #f1f1f1;
				padding: 15px;
				margin: 15px 0;
			}
			
			#searchValue
			{
				width: 487px;
				height: 28px;
				padding: 5px;
			}
			
			.button
			{
				background-color: #064998;
				color: #fff;
				text-align: center;
				font-size: 14px;
				
				margin: 0;
				width: 60px;
				height: 42px;
				line-height: 42px;
				display: inline-block;
			}
			
			.writebutton
			{
    			background-color: #222;
    			color: #fff;
    			border: 1px solid #000;
    			line-height: 40px;
				text-align: center;
				font-size: 14px;
				
				margin: 0 0 0 190px;
				width: 60px;
				height: 42px;
				display: inline-block;
			}
			
			.nonInputSub
			{
				padding: 0;
			    border-width: 0;
			    border-style: none;
			    border-color: #fff;
			    font-family: inherit;
			}
			
			.spanWrap::after
			{
				content: "";
				display: block;
				clear: both;
			}
			
			.th
			{
				font-weight: bold;
				background-color: #f1f1f1;
				border-top: 1.5px solid #222;
				
			}
			
			.borderRight
			{
				border-right: 1px solid #dbdadf;
			}
			
			.narrow
			{
				text-align: center;
				display: inline-block;
				width: 70px;
				padding: 10px;
				float: left;
				border-bottom: 1px solid #dbdadf;
			}
			
			.medium
			{
				text-align: center;
				display: inline-block;
				width: 165px;
				padding: 10px;
				float: left;
				border-bottom: 1px solid #dbdadf;
			}
			
			.wide
			{
				text-align: center;
				display: inline-block;
				width: 371px;
				padding: 10px;
				float: left;
				border-bottom: 1px solid #dbdadf;
			}
			
			.pageNum
			{
				text-align: center;
			}
			
			.tagColor
			{
				color: blue;
			    background-color: lightblue;
			    border-color: blue;
			    margin-right: 5px;
				line-height:36px;
			}
			
			.medium
			{
				text-align: center;
				display: inline-block;
				width: 165px;
				padding: 10px;
				float: left;
				border-bottom: 1px solid #dbdadf;
				line-height:36px;
			}
			
			.wide
			{
				text-align: left;
				display: inline-block;
				width: 371px;
				padding: 10px;
				float: left;
				border-bottom: 1px solid #dbdadf;
				height:36px;
			}
			
			.pageNum
			{
				text-align: center;
			}
			.tagColor
			{
				border-radius: 15px;
				font-size:10.5px;
				padding:3px;
				color: black;
			    background-color: cornsilk;
			    border:1px solid #989898;
			    margin-right: 5px;
			}
			.titleLength
			{
				/*display:inline-block;*/
				width:50px;
			    overflow:hidden;
			    text-overflow:ellipsis;
			    /*white-space:nowrap;*/
			}
			
			.txt_line {
				width:370px;
		      	overflow:hidden;
		      	text-overflow:ellipsis;
		      	white-space:nowrap;
		      	overflow: hidden;
		      	
		 	}
		</style>
	</head>
	<body style="margin:0;">
		<jsp:include page="header.jsp"/>
		<div class ="paragraphListWrap">
			<h2 class="titleArea">게시판</h2>
			<div class="search">
				<form method="get" action="search.do" name="frm">
					<input type="text" name="searchValue" id="searchValue">
					<input type="hidden" name="startPage" value="1">
					<input class="button nonInputSub" type="submit" value="검색" onclick="writeCheck()">
						<input class="writebutton" type="button" value="글쓰기" onclick="location.href='paragraphEditorWrite.do';">

				</form>
			</div>
			<div class="spanWrap">
				<span>
					<span class="narrow th borderRight">번호</span>
					<span class="wide th borderRight">제목</span>
					<span class="narrow th borderRight">글쓴이</span>
					<span class="medium th borderRight">날짜</span>
					<span class="narrow th">조회수</span>
				</span>
					<span>
					<span class="narrow">${list.getNum() }</span>
					<span class="wide">
						<a href="paragraphEachSelect.do?num=${list.getNum()}&&flag=0">[${list.getCategory()}]${list.getTitle()}</a>

						<span class="narrow borderRight">${list.getNum() }</span>
						<span class="wide borderRight">
						</span>
						<span class="narrow borderRight">${list.getId()}</span>
						<span class="medium borderRight">${list.getDatetime()}</span>
						<span class="narrow">${list.getHits()}</span>
					</span>	
				</span>			
					<span class="narrow borderRight">${list.getNum() }</span>
					<span class="wide borderRight"></span>
					<span class="narrow borderRight">${list.getId()}</span>
					<span class="medium borderRight">${list.getDatetime()}</span>
					<span class="narrow">${list.getHits()}</span>
				
			</div>
			<div class="pageNum">
				
			</div>
		</div>
	</body>
	<script>
		function writeCheck(){
			if(document.frm.searchValue.value.length==0){
				alert("검색어를 입력해주세요.");
				frm.searchValue.focus();
				return false;
			}
		}
		
		function getTag(ths){
			var text=$(ths).text();
			location.href="search.do?searchValue="+text.replace('#','')+"&startPage=1";
		}
	</script>
	<script type="text/javascript">
		// 소켓 통신으로 알림 구현을 해보려는 블럭 
		// 세션 데이터를 전역 변수로 할당하여 사용함 
		let userKey = <%=userKey%>;
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
		            	console.log(XHRInvite);
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
		
		webSocket.onopen=function(changeUser){
			
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
</html>