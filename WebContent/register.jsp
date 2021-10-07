<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원가입</title>
		<link rel="stylesheet" href="style.css">
	</head>
	<body>
		<div class="wrap1">
			<form name="register" method="post" action="register.do">
				<div class="wrap2">
					<h1>회원가입</h1>
					<h4>*은 필수 항목 입니다</h4>
					<div>
						<span>*아이디 : </span>
						<span><input type="text" name="id" id="id"></span>
						<span><input type="button" value="아이디 중복 확인" onclick="request_doPost()"></span>
					</div>
					<div>
						<span>*비밀번호 : </span>
						<span><input type="password" name="pw"></span>
					</div>
					<div>
						<span>*이름 : </span>
						<span><input type="text" name="name"></span>
					</div>
					<div>
						<span>*이메일 : </span>
						<span><input type="email" name="email"></span>
					</div>
					<div>
						<span><input type="submit" value="회원가입" onclick="return registerCheck()"></span>
					</div>
				</div>
			</form>
		</div>
		<script>
		
			function registerCheck(){
				if(document.register.id.value == ""){
					alert("아이디를 입력해주세요");
					document.register.id.focus();
					return false;
				}
				if(document.register.id.value.length < 4 || document.register.id.value.length > 16){ 
					alert("아이디는 4자리 ~ 15자리 이하로 입력해주세요");
					return false;
				}
				if(document.register.pw.value == ""){
					alert("비밀번호를 입력해주세요");
					document.register.pw.focus();
					return false;
				}
				if(document.register.pw.value.length < 4 || document.register.pw.value.length > 8){
					alert("비밀번호는 4자리 ~ 8자리 사이로 입력해주세요");
					document.register.pw.focus();
					return false;
				}
				if(document.register.name.value == ""){
					alert("이름을 입력해주세요");
					document.register.name.focus();
					return false;
				}
				if(document.register.email.value == ""){
					alert("이메일을 입력해주세요");
					document.register.email.focus();
					return false;
				}
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
			
			function overlapCheck()//아이디 중복체크를 눌렀을 때 실행되는 function
			{
				if(idOverlap == -1)
				{
					alert("중복된 아이디 입니다.");
				}
				else if(idOverlap == 1)
				{
					alert("사용 가능한 아이디 입니다.");
				}
				//이렇게 idOverlap의 값으로 기능 구현하시면 됩니다.
				//기능은 아이디가 중복일 경우 submit 되면 안 되고
				//또 아이디 중복 체크를 안 했을 때도 submit 되면 안 됩니다.
			}
		</script>
	</body>
</html>








