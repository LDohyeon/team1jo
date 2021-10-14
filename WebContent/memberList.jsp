
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ page import="DAO.MemberDAO" %>
<%@ page import="DTO.MemberDTO" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
   
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원 리스트 페이지</title>
		<link rel="stylesheet" href="style.css">
	</head>
	<body>
		<%
			List<MemberDTO> list = (List<MemberDTO>)request.getAttribute("memberList");
			List<MemberDTO> list1 = (List<MemberDTO>)request.getAttribute("list1");
			
			if(list1 != null){
				list = list1;
			}
		%>
			
		<div class="wrap1">
			<div>
				<h1>회원 리스트</h1>
				<form name="frm" method="post" action="memberList.do">
					<select name="selSerch1">
						<option value="">==선택==</option>
						<option value="id">아이디</option>
						<option value="name">이름</option>
					</select>
					<select name="selSerch2">
						<option value="0">전체 보기</option>
						<option value="3">정지 권한(3)</option>
					</select>
					<input type="text" name="selValue" placeholder="검색어를 입력해주세요">
					<input type="submit" value="검색" onclick="return serchCheck()">
				</form>
			</div>
			<div class="wrap2">
				<table class="memberList">
					<tr>
						<td>번호</td>
						<td>아이디</td>
						<td>이름</td>
						<td>이메일</td>
						<td>권한</td>
						<td>수정</td>
						<td>삭제</td>
					</tr>
					<%
						try{				
							for(int i=0; i<list.size(); i++){					
					%>			
								<tr>
									<td><%=list.get(i).getNum() %></td>
									<td><%=list.get(i).getId() %></td>
									<td><%=list.get(i).getName() %></td>
									<td><%=list.get(i).getEmail() %></td>
									<td><%=list.get(i).getAuthority() %></td>
									<td><a href="">수정</a></td>
									<td><a href="ListLeaveldServlet.do?getId=<%=list.get(i).getId() %>">삭제</a></td>
								</tr>			
					<% 
							}
						} catch(Exception e) {
							System.out.println("member 리스트 조회 오류 발생 : " + e);
						} 
					%>					
				</table>
			</div>
			<ul class="mListPage">
				<c:if test="${startPage != 1}">
					<li><a href="memberList.do?startPage=${startPage-1}&lastPage=${lastPage}">이전</a></li>
				</c:if>
				<c:forEach begin="1" end="${totalPage}" var="i">
					<c:choose>
						<c:when test="${startPage eq i}">
							<li>${i}</li>
						</c:when>
						<c:otherwise>
							<li><a href="memberList.do?startPage=${i}&lastPage=${lastPage}">${i}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${startPage lt totalPage}">
					<li><a href="memberList.do?startPage=${startPage+1}&lastPage=${lastPage}">다음</a></li>
				</c:if>
			</ul>
		</div>
		<script>
			var selSerch1 = frm.selSerch1;		
			var selValue = frm.selValue;		
			function serchCheck(){
				if(selSerch1.value == ""){
					alert("선택을 변경해주세요");
					return false;
				}
				
				if(selValue.value == "" || selValue.value.length < 1){
					alert("검색어를 입력해주세요");
					return false;
				}
				return true;
			}
		</script>
	</body>
</html>