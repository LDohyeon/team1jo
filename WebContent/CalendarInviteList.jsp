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
		<title>Calendar</title>
        <link rel="stylesheet" href="CalendarCss.css">
        <link rel="stylesheet" href="style.css">
	</head>
	<body style="margin:0;">
		<jsp:include page="header.jsp"/>
		
		
	</body>
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