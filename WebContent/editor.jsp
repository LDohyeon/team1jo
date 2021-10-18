<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>에디터</title>
		<style>
			@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&family=Nanum+Myeongjo&display=swap');
			
            .writeContent{ 
                width: 800px;
                height: 500px;
                border: 1px solid #ccc;
            }
            .editorTool{
                width: 800px;
                height: 30px;
            }
            .title{
                padding-bottom: 10px;
            }
            .writeTitle{
                width: 796px;
                height: 30px;
                border: 1px solid #ccc;
            }
            .writeContent:empty:before {
                content: attr(placeholder);
                color: gray;
            }
            .content{
                width: 800px;
                margin: 0 auto;
            }
            .fontType , .fontSize, .fontStyle, .fontAlign, .img{
                margin: 0px 5px 0px 0px;
                float: left;
            }
        </style>
	</head>
	<body>
		<!--헤더 시작-->
        <div class="header">
            header
        </div>
        <!--헤더 종료-->
        
        <!--컨텐츠 시작-->
        <div class="content">
        	<form method="post" action="paragraphEditorWrite.do" name="frm">
				<div class="title">
	                <input id="writeTitle" class="writeTitle" type="text" placeholder="제목을 입력해주세요." name="title">
	            </div>
	            <div>
	                <div class="editor">
	                    <div class="editorTool">
	                        <div class="fontType">
	                            <select id="fontType" onchange="selectFont()">
	                            	<option value="고딕">고딕</option>
	                            	<option value="굴림">굴림</option>
	                            	<option value="궁서">궁서</option>
	                            	<option value="돋움">돋움</option>
	                            	<option value="바탕">바탕</option>
	                            </select>
	                        </div>
	                        <div class="fontStyle">
	                            <button class="divColor" type="button" onclick="btnColor(0); document.execCommand('bold');">두껍게</button>
	                            <button class="divColor" type="button" onclick="btnColor(1); document.execCommand('Underline');">밑줄</button>
	                            <button class="divColor" type="button" onclick="btnColor(2); document.execCommand('italic');">기울이기</button>
	                            <input type="color" id="fontColor"><button class="divColor" type="button" onclick="btnColor(3); document.execCommand('foreColor', false, document.getElementById('fontColor').value);">글자색</button>
	                            <input type="color" id="bgColor" value="#ffffff"><button class="divColor" type="button" onclick="btnColor(4); document.execCommand('hiliteColor', false, document.getElementById('bgColor').value);">배경색</button>
	                        </div>
	                        <div class="fontAlign">
	                            <button class="divColor" type="button" onclick="btnColor(5); document.execCommand('justifyleft');">왼쪽</button>
	                            <button class="divColor" type="button" onclick="btnColor(6); document.execCommand('justifycenter');">가운데</button>
	                            <button class="divColor" type="button" onclick="btnColor(7); document.execCommand('justifyRight');">오른쪽</button>
	                            <button class="divColor" type="button" onclick="btnColor(8); document.execCommand('removeFormat');">서식삭제</button>                      
	                        </div>

	                        <div class="img">
	                            <button class="divColor" type="button">사진</button>
	                        </div>
	                        <select id="language">
                        		<option value="none">질문할 언어를 선택하세요</option>
                        		<option value="text/xml">html/xml</option>
                            	<option value="text/x-python">python</option>
                            	<option value="text/x-java">java</option>
                            	<option value="text/x-sql">sql</option>
                            	<option value="text/javascript">javascript</option>
                        	</select>
                        	<input class="divColor" type="button" onclick="code()" value="코드 작성 하러 가기">
	                    </div>
	                    <br>
	                    
	                    <div id="writeContent" class="writeContent" contenteditable="true" placeholder="내용을 입력해주세요."></div>
	                    <input id="content" type="hidden" value="" name="content">
	                     
	            	 </div>
				 	<input type="submit" value="글쓰기" onclick="return writeCheck();">
	                
	            </div>
        	</form>
        </div>
        <!--컨텐츠 종료-->
        
        <!--푸터 시작-->
        <div class="footer">
            footer
        </div>
        <!--푸터 종료-->
	</body>
	<script>
	
		function code()
		{
			var language=document.getElementById("language");
			
			if(language.value == "none")
			{
				alert("언어를 선택해주세요");
				return;
			}

			var url="code.do?language="+language.value;
			
			var popupX=(window.screen.width/2)-(800/2);
			var popupY=(window.screen.height/2)-(600/2);
			
			window.open(url, "_blank_1","toolbar=no, menubar=no, scrollber=yes, resizable=no, width=800, height=600, left="+popupX+", top="+popupY);
		}
	
	
		function selectFont(){
			var select=document.getElementById("fontType");
			var selectValue=select.options[select.selectedIndex].value;
			document.execCommand("fontName", false, selectValue);
		}
		
		var divColor=document.getElementsByClassName("divColor");
		for(var i=0;i<divColor.length;i++){
			divColor[i].style.backgroundColor="white";
		}

		function btnColor(i){
			if(i==8){
				for(var i=0;i<8;i++){
					divColor[i].style.backgroundColor="white";
				}
			}else if(divColor[i].style.backgroundColor=="gray"){
				divColor[i].style.backgroundColor="white";
			}else if(divColor[i].style.backgroundColor=="white"){
				divColor[i].style.backgroundColor="gray";
			}
		}
		//제목이나 내용이 입력되지 않은 채 submit 버튼이 눌렸을 때 alert 띄우는 함수
		function writeCheck(){
 			if(document.frm.writeTitle.value.length==0){
				alert("제목을 입력해주세요.");
				frm.writeTitle.focus();
				return false;
			}
			if(document.getElementById("writeContent").innerHTML==""){
				alert("내용을 입력해주세요.");
				document.getElementById("writeContent").focus();
				return false;
			}
			
			var text;
			text=document.getElementById('writeContent').innerHTML;
			console.log(text);
			document.getElementById('content').value=text;
			return true;
 		}

	</script>
</html>