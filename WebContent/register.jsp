<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원가입</title>
		<link rel="stylesheet" href="style.css">
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	</head>
	<body>
		<div class="wrap1">
			<form name="register" method="post" action="register.do">
				<div class="wrap2">
					<h1>회원가입</h1>
					<h4>*은 필수 항목 입니다</h4>
					<span class="registerIdCheckMsg">
						<input type="hidden" name="registerIdCheckHidden" value="">
					</span>
					<div>
						<span>*아이디 : </span>
						<span><input type="text" name="id" id="id"></span>
						<span><input type="button" class="registerIdCheck" value="아이디 중복 확인" onclick="request_doPost()"></span>
						<span class="registerMsg">아이디를 입력해주세요</span>
					</div>
					<div>
						<span>*비밀번호 : </span>
						<span><input type="password" name="pw"></span>
						<span class="registerMsg">비밀번호를 입력해주세요</span>
					</div>
					<div>
						<span>*이름 : </span>
						<span><input type="text" name="name"></span>
						<span class="registerMsg">이름을 입력해주세요</span>
					</div>
					<div>
						<span>*이메일 : </span>
						<span><input type="email" name="email"></span>
						<span class="registerMsg">이메일을 입력해주세요</span>
					</div>
					<div>
						<span><input type="submit" value="회원가입" onclick="return registerCheck()"></span>
					</div>
				</div>
			</form>
		</div>
		<script>
			var frm = document.register;
			var regMsg = document.getElementsByClassName("registerMsg");
			var overlapStatus = 'N';
			
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
					}
					
					if(frm.pw.value == ""){
						regMsg[1].innerHTML = "비밀번호를 입력해주세요";	
						regMsg[1].style.display = "block";	
						frm.pw.focus();
						registerResult = false;
					}else if(frm.pw.value.length < 4 || frm.pw.value.length > 8){
						regMsg[1].innerHTML = "비밀번호는 4자리 ~ 8자리 이하로 입력해주세요";
						regMsg[1].style.display = "block";
						frm.pw.focus();
						registerResult = false;
					}
					if(frm.name.value == ""){
						regMsg[2].style.display = "block";
						frm.name.focus();
						registerResult = false;
					}
					if(frm.email.value == ""){
						regMsg[3].style.display = "block";
						frm.email.focus();
						registerResult = false;
					}
					if (overlapStatus == 'N') {
						registerIdCheckMsg[0].innerHTML = "아이디 중복 확인을 눌러주세요";	
						registerIdCheckMsg[0].style.display = "block";
						frm.id.focus();
						registerResult = false;
				   	}

				   	if (overlapStatus == 'O') {
				   		registerIdCheckMsg[0].innerHTML = "중복된 아이디 입니다.";	
						registerIdCheckMsg[0].style.display = "block";
						frm.id.focus();
				      	overlapStatus = 'N'; // 초기화 (아이디 중복확인 메세지가 뜨도록)
				      	registerResult = false;
				   	}
				}
				return registerResult;
			}
			
			//아이디 중복 체크를 위한 ajax 시작
			//이건 신경 안 써도 됩니다.
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
			//여기까지는 신경 안 써도 됩니다.
			//신경 써야될 건 바로 밑에 function overlapCheck()
			
			var registerIdCheckMsg = document.getElementsByClassName("registerIdCheckMsg");
			var registerIdCheckHidden = document.register.registerIdCheckHidden.value;				
			function overlapCheck(idOverlap) //아이디 중복체크를 눌렀을 때 실행되는 function
			{
				overlapStatus = 'O';
				
				if(idOverlap == "-1"){ // String 타입이라서
					registerIdCheckMsg[0].innerHTML = "중복 된 아이디 입니다.";	
					registerIdCheckMsg[0].style.display = "block";
					frm.id.focus();
				}
				
				if(idOverlap == 1 && frm.id.value == ""){
					registerIdCheckMsg[0].innerHTML = "아이디 작성 후 아이디 중복 확인을 눌러주세요";	
					registerIdCheckMsg[0].style.display = "block";
					frm.id.focus();
				}
				
				if(idOverlap == 1 && frm.id.value != "") {
					if(frm.id.value.length < 4 || frm.id.value.length > 16){
						regMsg[0].innerHTML = "아이디는 4자리 ~ 15자리 이하로 입력해주세요";
						regMsg[0].style.display = "block";
						frm.id.focus();
					}else{
						registerIdCheckMsg[0].innerHTML = "사용 가능한 아이디 입니다.";	
						registerIdCheckMsg[0].style.display = "block";
						frm.id.focus();
						overlapStatus = "Y"; 
					   	registerIdCheckHidden = overlapStatus;
					}
				} 
				//이렇게 idOverlap의 값으로 기능 구현하시면 됩니다.
				//기능은 아이디가 중복일 경우 submit 되면 안 되고
				//또 아이디 중복 체크를 안 했을 때도 submit 되면 안 됩니다.
			}
		</script>
	</body>
</html>