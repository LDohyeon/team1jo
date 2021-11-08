<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ page import="DAO.MemberDAO" %>
<%@ page import="DTO.MemberDTO" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.annotation.*" %>
<%@ page import="javax.servlet.http.*" %>

   
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="UTF-8">
		<title>회원 리스트 관리자 페이지</title>
		<link rel="stylesheet" href="style.css">
		<style>
			.wrap{
				margin:30px 0px 100px 0px;
				align-items:center;
				display:flex;
				justify-content:center;
			}
			.memberListWrap{
				border: 1px solid black;
				padding: 15px 35px;
			}
			.memberListH1{
				line-height:71px;
			}
			.memberListForm{
				margin-bottom: 15px;
			}
			.memberListselectBox{
				height:42px; 
				font-size:14px; 
				border:1px solid #dbdadf;
			}
			.memberListInputBox{
				padding:0 10px; 
				line-height:40px; 
				font-size:14px; 
				border:1px solid #dbdadf; 
			}
			.btnSerch{
				height:41px; 
				color:#fff; 
				background:#064998; 
				border:0; 
				padding:1px 20px 5px 20px; 
				font-size:14px; 
			}
			.memberListTableDiv{
				width:100%;
				min-width:700px;
			}
			.memberListDiv .memberListTable{
				border-spacing:0; 
				width:700px; 
				border-top:1px solid #272324;
			}
			.memberListDiv .memberListTable th{
				background:#f1f1f1; 
				border-bottom:1px solid #dbdadf; 
				border-right:1px solid #dbdadf; 
				height:40px; 
				font-size:14px; 
			}
			.memberListDiv .memberListTable th:last-child{
				border-right:0
			}
			.memberListDiv .memberListTable th{
				padding:0 10px;
			}
			.memberListDiv .memberListTable td{
				font-size:14px; 
				border-bottom:1px solid #dbdadf; 
				border-right:1px solid #dbdadf; 
				text-align:center; 
				padding:10px 10px; 
			}
			.authorityUpdate{
				height:25px; 
				background:#f1f1f1;
				border: 0; 
				font-size:13px;
			}
			.btnRegisterAdd{
				height:35px; 
				background:#f1f1f1;
				border:0; 
				padding:0px 20px; 
				font-size:14px; 
				margin-top:15px;
			}			
			.btnChart{
				height:41px; 
				background:#f1f1f1; 
				border:0; 
				padding:1px 20px 5px 20px; 
				font-size:14px;
				margin-left:165px;
			}		
			.memberListPaging{
				text-align:center; 
				margin-top:30px;
			}
			.memberListPaging a{ 
				display:inline-block;
				width:35px; 
				line-height:35px; 
				font-size: 12px;
			}		
			.memberListPaging .on{
				font-weight:bold;
			}
		</style>
	</head>
	<body>
		<%
			List<MemberDTO> list = (List<MemberDTO>)request.getAttribute("memberList");
			List<MemberDTO> list1 = (List<MemberDTO>)request.getAttribute("list1");
						
			if(list1 != null){
				list = list1;
			}
		%>
		<jsp:include page="./header.jsp"></jsp:include>
		<div class="wrap">
			<div class="memberListWrap">
				<h1 class="memberListH1">회원 리스트</h1>
				<div>
					<form name="frm" class="memberListForm" method="post" action="memberList.do?startPage=1">
						<select name="selSerch1" class="memberListselectBox">
							<option value="">-- 선택 --</option>
							<option value="id">아이디</option>
							<option value="name">이름</option>
						</select>
						<select name="selSerch2" class="memberListselectBox">
							<option value="0">-- 전체 --</option>
							<option value="1">관리자(1)</option>
							<option value="2">일반 회원(2)</option>
							<option value="3">신고 당한 사람(3)</option>
							<option value="4">정지 권한(4)</option>
						</select>
						<input type="text" class="memberListInputBox" name="selValue"  placeholder="검색어를 입력해주세요">
						<input type="submit" class="btnSerch" value="검색" onclick="return serchCheck()">
						<input type="button" class="btnChart" value="차트보기" onclick="chart()">
					</form>
				</div>
				<div class="memberListTableDiv">
					<div class="memberListDiv">
						<table class="memberListTable">
							<tr>
								<th>번호</th>
								<th>아이디</th>
								<th>이름</th>
								<th>이메일</th>
								<th>삭제</th>
								<th>권한</th>
								<th>권한 수정</th>
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
											<td><a href="ListLeaveldServlet.do?getId=<%=list.get(i).getId() %>&startPage=${startPage}">삭제</a></td>
											<td><%=list.get(i).getAuthority() %></td>
											<td><input type="button" class="authorityUpdate" name="popUp" value="수정" onclick="authorityPopUp('<%=list.get(i).getId() %>','<%=list.get(i).getAuthority() %>')"></td>
										</tr>			
							<% 
									}
								} catch(Exception e) {
									System.out.println("member 리스트 조회 오류 발생 : " + e);
								} 
							%>					
						</table>
					</div>
					<div>
						<input type="button" class="btnRegisterAdd" value="회원추가" onclick="register_add()">
					</div>
				</div>
				<div class="memberListPaging">
					<c:if test="${startPage != 1}">
						<a href="memberList.do?startPage=${startPage-1}&lastPage=${lastPage}">이전</a>
					</c:if>
					<c:forEach begin="1" end="${totalPage}" var="i">
						<c:choose>
							<c:when test="${startPage eq i}">
								<a href="#" class="on">${i}</a>
							</c:when>
							<c:otherwise>
								<a href="memberList.do?startPage=${i}&lastPage=${lastPage}">${i}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${startPage lt totalPage}">
						<a href="memberList.do?startPage=${startPage+1}&lastPage=${lastPage}">다음</a>
					</c:if>
				</div>
			</div>
		</div>
		<jsp:include page="./footer.jsp"></jsp:include>
		<script>		
			var selSerch1 = document.frm.selSerch1;		
			var selValue = document.frm.selValue;		
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
			
			function chart(){
				location.href="chartServlet.do";
			}
			
			function authorityPopUp(selAuIdValue,selAuValue){
			    var _width = '500';
			    var _height = '280';
			    var _left = Math.ceil(( window.screen.width - _width )/2);
			    var _top = Math.ceil(( window.screen.height - _height )/2); 
				window.open("auUpdatePopUp.jsp?selAuIdValue="+selAuIdValue+"&selAuValue="+selAuValue, "update", 'width='+ _width +', height='+ _height +', left=' + _left + ', top='+ _top);
			}
			
			function register_add(){
				location.href="register.do";
			}
		</script>
	</body>
</html>