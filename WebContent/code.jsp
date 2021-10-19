<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
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
		
		<textarea id="writeContent"></textarea>

		<input id="language" type="hidden" value="${language }">
		
		<input type="button" value="코드 작성 완료" onclick="codeEnd()">
		
		<input id="lang" type="hidden">
		
		<p></p>
		
		<script>

			var language =document.getElementById("language").value;
			var writeContent= document.getElementById("writeContent");

			
			var writeContent = CodeMirror.fromTextArea(writeContent, {
				lineNumbers: true,
				theme: "darcula",
				mode: language,
				spellcheck: true,
				autocorrect: true,
				autocapitalize: true,
				//readOnly: true,
				autoCloseTags: true
			});
			writeContent.setSize("785", "400");

			function codeEnd()
			{
				writeContent.getValue();
				console.log(writeContent.getValue());
				
				opener.document.getElementById("writeContent").innerHTML+="※"+language+"※";
				opener.document.getElementById("writeContent").innerHTML+=writeContent.getValue()+"※";
					
				opener.document.getElementById("writeContent").innerHTML+="<div><br></div>";
				self.close();

			}
		</script>
	</body>
</html>





