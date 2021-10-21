<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>권한 설정 페이지</title>
		<link rel="stylesheet" href="style.css">
	</head>
	<body>
		<%
			String selAuIdValue = request.getParameter("selAuIdValue");
			String selAuValue = request.getParameter("selAuValue");			
			String val = (String)request.getAttribute("val");		
			if(val == null){
				val = "N";
			}
		%>
		<form name="frm" method="post" action="AuthorityUpdate.do">
			<input type="hidden" name="selAuIdValue" value="<%=selAuIdValue %>"><br>
			<h1>권한 설정</h1>
			<span>권한 : </span> 
				<select name="selAuValue" onchange="selAuChange(this)">
					<option value="1"<% if(selAuValue.equals("1")){%>selected<%}%>>1(관리자)</option>
					<option value="2"<% if(selAuValue.equals("2")){%>selected<%}%>>2(일반회원)</option>
					<option value="3"<% if(selAuValue.equals("3")){%>selected<%}%>>3(신고당한사람)</option>
					<option value="4"<% if(selAuValue.equals("4")){%>selected<%}%>>4(정지당한사람)</option>
				</select>
			<br>
			<% String selAuValStart = selAuValue; %>
			<span  class="stopDay" <% if(selAuValStart.equals("4")){ %> style="display:block;"<%}else{%> style="display:none;"<%} %>>정지 기간 : 
				<input type="number" class="stopDay" name="selAuDay" value="1" min="1"<% if(selAuValStart.equals("4")){ %> style="display:block;"<%}else{%> style="display:none;"<%} %>>
			</span>
			<br>
			<br>
			<input type="submit" value="수정">
		</form>
		<script>
			<%
				if(val.equals("T")){
			%>
					alert("권한 설정이 변경되었습니다.");
					opener.location.reload();
					self.close();
			<%
				}
			%>
			function selAuChange(selAuVal){
				var val= selAuVal.value;
				if(val == "4"){
					document.getElementsByClassName("stopDay")[0].style.display = "block";
					document.getElementsByClassName("stopDay")[1].style.display = "block";
				}else{
					document.getElementsByClassName("stopDay")[0].style.display = "none";
					document.getElementsByClassName("stopDay")[1].style.display = "none";
				}
			}
		</script>
	</body>
</html>