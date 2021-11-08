<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="UTF-8">
		<title>권한 설정 페이지</title>
		<style>
			.auForm{
				margin:0 auto;
		    	width:300px;
		    	height: 230px;
		    	text-align: center;
				border: 1px solid black;
				padding: 15px 0px;
				background-color:#F8F8F9;
	 		}
			.authorityUpdate {height:25px; line-height:25px; background:#f1f1f1; border:0; border: 1px solid #dbdadf; padding:0px 20px; font-size:13px;}
			.Name{font-size:17px;}
			.selectBox {margin:0 0 10px 0; height:30px; line-height:30px; font-size:13px; border:1px solid #dbdadf; vertical-align:middle; border-radius:0; background-color:#fff;}
			.authorityInput {margin:0 0 0 0; margin-top:1px; padding:0 10px; width:55px; height:25px; line-height:25px; font-size:13px; border:1px solid #dbdadf; vertical-align:middle; border-radius:0; background-color:#fff; -webkit-box-shadow:0; box-shadow:0;}
			.authorityUpdate2 {
				font-size:24px;
			}
		</style>
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
		<form name="frm" class="auForm" method="post" action="AuthorityUpdate.do">
			<input type="hidden" name="selAuIdValue" value="<%=selAuIdValue %>"><br>
			<h1 class="authorityUpdate2">권한 수정</h1>
			<span class="Name">권한 : </span> 
				<select name="selAuValue" class="selectBox" onchange="selAuChange(this)">
					<option value="1"<% if(selAuValue.equals("1")){%>selected<%}%>>1(관리자)</option>
					<option value="2"<% if(selAuValue.equals("2")){%>selected<%}%>>2(일반회원)</option>
					<option value="3"<% if(selAuValue.equals("3")){%>selected<%}%>>3(신고당한사람)</option>
					<option value="4"<% if(selAuValue.equals("4")){%>selected<%}%>>4(정지당한사람)</option>
				</select>
			<br>
			<% String selAuValStart = selAuValue; %>
			<span  class="stopDay Name" <% if(selAuValStart.equals("4")){ %> <%}else{%> style="display:none;"<%} %>>정지 일수 : 
				<input type="number" class="stopDay authorityInput" name="selAuDay" value="1" min="1"<% if(selAuValStart.equals("4")){ %> <%}else{%> style="display:none;"<%} %>>
			</span>
			<br>
			<br>
			<input type="submit" class="authorityUpdate" value="수정">
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
					document.getElementsByClassName("stopDay")[0].style.display = "inline-block";
					document.getElementsByClassName("stopDay")[1].style.display = "inline-block";
				}else{
					document.getElementsByClassName("stopDay")[0].style.display = "none";
					document.getElementsByClassName("stopDay")[1].style.display = "none";
				}
			}
		</script>
	</body>
</html>