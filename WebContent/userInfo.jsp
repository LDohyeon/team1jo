<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원정보 수정 페이지</title>
	</head>
	<body>
		<!-- 이유는 모르겠으나, 들여쓰기가 제 컴퓨터랑 깃허브랑 다릅니다. -->
		<!-- 원인은 찾고있습니다. -->
		<div id="wrap">
			<form name="update" method="post" action="index.jsp">
				<div id="wrap2">
                    <div>
                        <h2>회원 정보 수정</h2>
                        <p>별명과 이메일을 수정할 수 있습니다.</p>
                        <p>비밀번호를 수정하려면 수정 버튼을 눌러주세요. 페이지가 이동됩니다.</p>
                    </div>
					<div>아이디</div>
                    <div>
                        <p>${user.getId()}</p>
                    </div>
					<div>비밀번호</div>
					<div>
                        <!--비밀번호 servlet에서 암호화 처리해서 가져올 것-->
                        <span>"${user.getPw()}"</span>
                        <span><input type="button" value="수정" onclick="location.href='changePw.html'"></span>
                    </div>
				    <div>별명</div>
				    <div>
                        <span><input onchange="return check()" type="text" value="seven" name="name"></span>
                        <span id="underInfo1" style="visibility:hidden;">별명을 입력해주세요.</span>
                    </div>
                    <div>이메일</div>
                    <div>
                        <span><input onchange="return check()" type="email" name="email" value="7777@a.com"></span>
                        <span id="underInfo2" style="visibility:hidden;">이메일 주소를 입력해주세요.</span>
                    </div>
                    <div>
                        <input type="hidden" value="${member.getNum()}" name="num">
                        <input id="submit" type="submit" value="적용" onclick="return returnFlag()" style="color:lightgray;">
                        <input type="button" value="취소" onclick="location.href='main.jsp'">
                    </div>
                </div>
			</form>
		</div>
		<script>
        //parameter
        var flag="false";
        //fucntion1
        function check(){
            var underInfo1=document.getElementById("underInfo1");
            var underInfo2=document.getElementById("underInfo2");
            var submit=document.getElementById("submit");
            var flag1=false;
            var flag2=false;
            
            if(document.update.name.value==0){
                underInfo1.attributes.style.value="color:red;";
            }else if(document.update.name.value!=0){
                underInfo1.attributes.style.value="visibility:hidden;";
                flag1=true;
            }
            
            if(document.update.email.value==0){
                underInfo2.attributes.style.value="color:red;";
            }else if(document.update.email.value!=0){
                underInfo2.attributes.style.value="visibility:hidden;";
                flag2=true;
            }
            
            flag=(flag1&&flag2);
            if(flag1&&flag2){
                submit.attributes.style.value="color:black;";
            }
        }
        //function2
        function returnFlag(){
            if(flag==true){
                return true;
            }
            return false;
        }
	</script>
	</body>
</html>