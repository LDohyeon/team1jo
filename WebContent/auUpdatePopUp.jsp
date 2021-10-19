<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>권한 설정 페이지</title>
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
		<form method="post" action="AuthorityUpdate.do">
			<input type="hidden" name="selAuIdValue" value="<%=selAuIdValue %>"><br>
			<h1>권한 설정</h1>
			권한 : 
				<select name="selAuValue">
					<option value="2"<% if(selAuValue.equals("2")){%>selected<%}%>>2</option>
					<option value="3"<% if(selAuValue.equals("3")){%>selected<%}%>>3</option>
					<option value="4"<% if(selAuValue.equals("4")){%>selected<%}%>>4</option>
				</select>
			<br>
			정지 기간 :
				<input type="number" name="selAuDay" min="1">일
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
		</script>
	</body>
</html>