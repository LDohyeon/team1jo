<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원 추가 페이지</title>
		<style>
			.registerWrap{
				width:700px;
				margin:140px auto;
			}
			.registerWrap h2{
				padding-left:8px;
				font-size:30px;
			}
			.registerDiv table{
				width:700px;
				border-top:1px solid black;
				height:500px;
				border-spacing:0; 
			}
			.registerDiv table th {
				background:#f1f1f1; 
				border-bottom:1px solid #dbdadf; 
				border-right:1px solid #dbdadf; 
				font-size:16px;  
				padding:0 10px; 
				text-align:left;
				height: 115px;
			}
			.registerDiv table td {
				border-bottom:1px solid #dbdadf; 
				border-right:1px solid #dbdadf; 
				padding:10px 10px;
				height: 115px;
			}
			.registerDiv table td:last-child {
				border-right:0;
			}
			
			.registerInput {
				line-height:40px; 
				font-size:15px; 
				border:1px solid #dbdadf;
				padding:0 10px; 
			}
			.registerSelect {
				height:42px; 
				border:1px solid #dbdadf; 
				font-size:15px; 
			}
			.grayButton { 
				height:40px; 
				color:#fff; 
				background:#5f5f61;
				padding:10px 20px; 
				font-size:15px; 
				display:block; 
				width:700px;
			}
			.blueButton { 
				height:40px; 
				color:#fff; 
				background:#152aa1; 
				font-size:15px; 
				display:block; 
				width:700px;
			}
			.registerIdCheck{
				padding:5px; 
				margin-left:10px;
				color:#fff; 
				background:#152aa1;
			}
			.registerMsg{
				color:#152aa1;
				margin-top:20px;
				width: 350px;
			}
		</style>
	</head>
	<body>
		<% String au = (String)session.getAttribute("Authority"); %>
		<div class="registerWrap">
			<h2>회원추가</h2>
			<div class="registerDiv">
				<form name="register" method="post" action="register.do?au=<%=au%>">
				<table>
						<tr>
							<th>아이디</th>
							<td>
								<input class="registerInput" id="id" type="text" name="id">
								<input type="button" class="registerIdCheck" value="아이디 중복 확인" onclick="request_doPost()">
								<span class="registerMsg">아이디를 입력해주세요</span>
							</td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td>
								<input class="registerInput" type="password" name="pw">
								<span class="registerMsg">비밀번호를 입력해주세요</span>
							</td>
						</tr>
						<tr>
							<th>이름</th>
							<td>
								<input class="registerInput" type="password" name="name">
								<span class="registerMsg">이름을 입력해주세요</span>
							</td>
							
						</tr>
						<tr>
							<th>이메일</th>
							<td>
								<input class="registerInput" type="email" name="email">
								<span class="registerMsg">이름을 입력해주세요</span>
							</td>
						</tr>
						<tr>
							<th>권한</th>
							<td>
								<select name="selAuValue" class="registerSelect">
									<option value="1">관리자(1)</option>
									<option value="2">일반 회원(2)</option>
									<option value="3">신고 당한 사람(3)</option>
									<option value="4">정지 권한(4)</option>
								</select>
							</td>
						</tr>
					</table>
					<span><input class="blueButton" type="submit" value="회원추가" onclick="return registerCheck()"></span>
					<span><input class="grayButton" type="button" value="취소" onclick="locationHref()"></span>
				</form>
			</div>
		</div>
		<script>
			var frm = document.register;
			var regMsg = document.getElementsByClassName("registerMsg");
			var overlapStatus = 'N';
			var currentId = "";
			
			for(i=0; i<regMsg.length; i++){
				regMsg[i].style.display = "none";	
			}
			
			// 회원가입 유효성 검사
			function registerCheck(){
				
				for(i=0; i<regMsg.length; i++){
					regMsg[i].style.display = "none";	
				}
				
				var registerResult = true;
				if(registerResult){
					if(frm.id.value == ""){
						regMsg[0].innerHTML = "아이디를 입력해주세요";	
						regMsg[0].style.display = "block";	
						frm.id.focus();
						registerResult = false;
					} else if(frm.id.value.length < 4 || frm.id.value.length > 16){ 
						regMsg[0].innerHTML = "아이디는 4자리 ~ 15자리 이하로 입력해주세요";
						regMsg[0].style.display = "block";
						frm.id.focus();
						registerResult = false;
					} else if (overlapStatus == "N") {
						regMsg[0].innerHTML = "아이디 중복 확인을 눌러주세요";	
						regMsg[0].style.display = "block";
						frm.id.focus();
						registerResult = false;
				   	}	
					
					if(frm.pw.value == ""){
						regMsg[1].innerHTML = "비밀번호를 입력해주세요";	
						regMsg[1].style.display = "block";	
						registerResult = false;
					}else if(frm.pw.value.length < 4 || frm.pw.value.length > 8){
						regMsg[1].innerHTML = "비밀번호는 4자리 ~ 8자리 이하로 입력해주세요";
						regMsg[1].style.display = "block";
						registerResult = false;
					}
					
					if(frm.name.value == ""){
						regMsg[2].innerHTML = "이름을 입력해주세요";
						regMsg[2].style.display = "block";
						registerResult = false;
					}
					
					if(frm.email.value == ""){
						regMsg[3].innerHTML = "이메일을 입력해주세요";
						regMsg[3].style.display = "block";
						registerResult = false;
					}					

					if (overlapStatus == 'O') {
				   		regMsg[0].innerHTML = "중복된 아이디 입니다.";	
				   		regMsg[0].style.display = "block";
						frm.id.focus();
				      	registerResult = false;
				   	}
					
				   	if(currentId != ""){
					   	if (frm.id.value != currentId ){
					   		regMsg[0].innerHTML = "아이디 중복 확인을 눌러주세요";	
					   		regMsg[0].style.display = "block";
							frm.id.focus();
					      	registerResult = false;
					   	}
				   	}
				}
				return registerResult;
			}
			
			//아이디 중복 체크를 위한 ajax 시작
			var XHR;
			var idOverlap;
			function createXHRHttpRequest()
			{
				if(window.ActiveXObject)
				{
					XHR= new ActiveXObejct("Microsoft.XMLHTTP");
				}
				else if(window.XMLHttpRequest)
				{
					XHR= new XMLHttpRequest();
				}
			}
			
			function idCheck()
			{
				var id =document.getElementById("id").value;
				var check="idCheck="+id;
				
				return check;
			}
			
			function request_doPost()
			{
				if(frm.id.value == ""){
					regMsg[0].innerHTML = "아이디 입력 후 아이디 중복 확인을 눌러주세요";	
					regMsg[0].style.display = "block";	
					frm.id.focus();
					return false;
				} else if(frm.id.value.length < 4 || frm.id.value.length > 16){
					regMsg[0].innerHTML = "아이디는 4자리 ~ 15자리 이하로 입력해주세요";
					regMsg[0].style.display = "block";
					frm.id.focus();
					return false;
				}
				
				createXHRHttpRequest();
				var url="idCheck.do";
				var check=idCheck();
				XHR.onreadystatechange=handleStateChange;
				
				XHR.open("POST", url, true);
				
				XHR.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
				
				XHR.send(check);
			}
			
			function handleStateChange()
			{
				if(XHR.readyState==4)
				{
					if(XHR.status==200)
					{
						idOverlap=XHR.responseText;
						overlapCheck(idOverlap);
					}
				}
			}
			//아이디 중복 체크를 위한 ajax 끝
			
			//아이디 중복체크를 눌렀을 때 실행되는 function 
			function overlapCheck(idOverlap)
			{
				overlapStatus = 'O';

				if(idOverlap == -1){
					regMsg[0].innerHTML = "중복된 아이디 입니다.";	
					regMsg[0].style.display = "block";
					frm.id.focus(); 
				} else {
					regMsg[0].style.color = "green";
					regMsg[0].innerHTML = "사용 가능한 아이디 입니다.";	
					regMsg[0].style.display = "block";
					frm.id.focus();
					overlapStatus = "Y";
					currentId = frm.id.value;
				}
			}
			
			function locationHref(){
				location.href="index.jsp";
			}
		</script>
	</body>
</html>