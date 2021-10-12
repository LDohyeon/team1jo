<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원정보 수정 페이지</title>
	</head>
	<body>
		<div id="wrap">
			<form name="update" method="post" action="UserInfo.do">
				<div id="wrap2">
				
					<div>
						<h2>회원 정보 수정</h2>
						<p>별명과 이메일을 수정할 수 있습니다.</p>
						<p>비밀번호를 수정하려면 수정 버튼을 눌러주세요. 페이지가 이동됩니다.</p>
					</div>
					
					<div>아이디</div>
					<div>
						<p>${loginUser.getId()}</p>
                    </div>
                    
					<div>비밀번호</div>
					<div>
						<span>${loginUser.getPw()}</span>
						<span><input type="button" value="수정" onclick="location.href='changePw.jsp'"></span>
					</div>
					
					<div>이름</div>
					<div>
						<span><input onchange="return checkName()" type="text" name="name" value="${loginUser.getName()}"></span>
						<span id="underInfo1" style="display:none;">이름을 입력해주세요.</span>
					</div>
					
					<div>이메일</div>
					<div>
						<span><input onchange="return checkEmail()" type="email" name="email" value="${loginUser.getEmail()}"></span>
						<span id="underInfo2" style="display:none;">이메일 주소를 입력해주세요.</span>
					</div>
					
					<div>
						<input type="hidden" value="${loginUser.getId()}" name="id">
						<input name="submit" type="submit" value="적용" onclick="return check()">
						<input type="button" value="취소" onclick="location.href='index.jsp'">
					</div>
				</div>
			</form>
		</div>
		<script>
			//fucntion1
			function checkName()
			{
				var fl="false";
				if(document.update.name.value==0)
				{
					document.getElementById("underInfo1").attributes.style.value="color:red;";
				}
				else if(document.update.name.value!=0)
				{
					document.getElementById("underInfo1").attributes.style.value="display:none;";
					fl=true;
				}
				return fl;
			}
			//fucntion2   
			function checkEmail()
			{    
				var fl="false";
				if(document.update.email.value==0)
				{
					document.getElementById("underInfo2").attributes.style.value="color:red;";
				}
				else if(document.update.email.value!=0)
				{
					document.getElementById("underInfo2").attributes.style.value="display:none;";
					fl=true;
				}
				return fl;
			}
			/*fucntion3
			function changeBtnColor()
			{
			    var flag1=checkName();
			    var flag2=checkEmail();
			    console.log(flag1);
			    console.log(flag2);
			    console.log((flag1==false)||(flag2==false));
			    console.log(document.update.submit.attributes);
			    if((flag1==false)||(flag2==false))
			    {
			        document.update.submit.setAttributes("color",red);
			    }
			}*/
			//function4
			function check()
			{
				var flag1=checkName();
				var flag2=checkEmail();
				if((flag1==true)&&(flag2==true))
				{
					return true;
				}
				return false;
			}
	</script>
	</body>
</html>