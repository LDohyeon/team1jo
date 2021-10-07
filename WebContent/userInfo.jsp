<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원정보 수정 페이지</title>
	</head>
	<body>
		<div id="wrap">
			<form method="post" action="">
				<div id="table">
					<div>아이디</div>
                    <div>
                        <p>${user.getId()}</p>
                    </div>
                    
					<div>비밀번호</div>
					<div>
                        <!--비밀번호 servlet에서 암호화 처리해서 가져올 것-->
                        <p>${user.getPw()}</p>
                        <p><a href="changePw.jsp"><b>수정</b></a></p>
                    </div>
                    
				    <div>별명</div>
				    <div><input type="text" value="${user.getName()}" name="name"></div>
					
                    <div>이메일</div>
                    <div><input type="text"value="${user.getEmail()}"></div>
					
                    <input type="hidden" value="${member.getNum()}" name="num">
                    <input type="submit" value="적용" onclick="return check()">
                    <input type="button" value="취소" onclick="location.href='main.jsp'">
                </div>
			</form>
		</div>
	</body>
	<script>
        /*
            
            <<alter 사용해서 check()만들기>>
            별명 체크 :: 별명 중복처리가 필요한가? X
            이메일 모양 체크 :: 이메일 검증 정규식 사용하기
            
        */
	</script>
</html>