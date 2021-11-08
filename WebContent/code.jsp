<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<!DOCTYPE html>
	<html>
	<head>
	
	
		<meta charset="utf-8">
		<title>코드 미러</title>
		<link rel="stylesheet" href="codeMirror/codemirror.css">
		<script src="codeMirror/codemirror.js"></script>
		<script src="codeMirror/xml.js"></script>
		<link rel="stylesheet" href="codeMirror/darcula.css">
		<link rel="stylesheet" href="codeMirror/eclipse.css">
		<script src="codeMirror/closetag.js"></script>
		<script src="codeMirror/python.js"></script>
		<script src="codeMirror/javascript.js"></script>
		<script src="codeMirror/sql.js"></script>
		<script src="codeMirror/clike.js"></script>
		<style>
			.wrap
			{
				width:600px;
				margin:100px auto;
			}
			.wrap > div
			{
				border:1px solid black;
				height:600px;
			}

		</style>
	</head>
	<body>
		<h2>코드 작성</h2>
		
		<textarea id="writeContent">${write }</textarea>

		<input id="language" type="hidden" value="${language }">
		
		<c:if test="${flag==0 }">
			<input type="button" value="코드 작성 완료" onclick="codeEnd()">
		</c:if>
		<c:if test="${flag==1 }">
			<input type="button" value="코드 수정 완료" onclick="codeEndUpdate()">
		</c:if>
		
		
		<input id="lang" type="hidden">
		<body onbeforeunload="moveCheckYn();">


		
		<script>


			var language =document.getElementById("language").value;
			var writeContent= document.getElementById("writeContent");

			
			var writeContent = CodeMirror.fromTextArea(writeContent, {
				lineNumbers: true,
				theme: "darcula",
				mode: language,
				//mode:"text/x-python",
				spellcheck: true,
				autocorrect: true,
				autocapitalize: true,
				//readOnly: true,
				autoCloseTags: true
			});
			writeContent.setSize("785", "400");

			function codeEnd()
			{
				
				alert(writeContent.getValue());
				
				opener.document.getElementById("writeContent").innerText+="※"+language+"※";
				opener.document.getElementById("writeContent").innerText+=writeContent.getValue()+"※";
				
				opener.document.getElementById("writeContent").innerHTML+="<div><br></div>";
				
				if(opener.document.getSelection().isCollapsed==false)
				{
					self.close();
				}
				else
				{
					self.close();
				}

			}
			function codeEndUpdate()
			{
				
				opener.document.getElementById("writeContent").innerText+="※"+language+"※";
				opener.document.getElementById("writeContent").innerText+=writeContent.getValue()+"※";
				
				opener.document.getElementById("writeContent").innerHTML+="<div><br></div>";
				
				

				
				if(opener.document.getSelection().isCollapsed==false)
				{
					self.close();
				}
				else
				{
					self.close();
				}
			}
		</script>
	</body>
</html>





