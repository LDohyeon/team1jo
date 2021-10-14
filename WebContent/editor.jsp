<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>Insert title here</title>
		<style>
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
	                            <input type="color" id="fontColor"><button class="divColor" type="button" onclick="document.execCommand('foreColor', false, document.getElementById('fontColor').value);">글자색</button>
	                            <input type="color" id="bgColor" value="#ffffff"><button class="divColor" type="button" onclick="document.execCommand('hiliteColor', false, document.getElementById('bgColor').value);">배경색</button>
	                        </div>
	                        <div class="fontAlign">
	                            <button class="divColor" type="button" onclick="btnColor(3); document.execCommand('justifyleft');">왼쪽</button>
	                            <button class="divColor" type="button" onclick="btnColor(4); document.execCommand('justifycenter');">가운데</button>
	                            <button class="divColor" type="button" onclick="btnColor(5); document.execCommand('justifyRight');">오른쪽</button>
	                            <button class="divColor" type="button" onclick="btnColor(6); document.execCommand('removeFormat');">서식삭제</button>
	                        </div>
	                        <div class="img">
	                            <button class="divColor" type="button">사진</button>
	                        </div>
	                    </div>
	                    <div id="writeContent" class="writeContent" contenteditable="true" placeholder="내용을 입력해주세요."></div>
	                    <input id="hiddenContent" type="hidden" value="" name="content">
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
		//선택한 폰트로 바꿔주는 함수
		function selectFont(){
			var select=document.getElementById("fontType");
			var selectValue=select.options[select.selectedIndex].value;
			document.execCommand("fontName", false, selectValue);
		}
		
		//버튼 기본배경색 white로 통일
		var divColor=document.getElementsByClassName("divColor");
		for(var i=0;i<divColor.length;i++){
			divColor[i].style.backgroundColor="white";
		}
		
		//버튼 클릭되면 색 바꿔주는 함수
		function btnColor(i){
			if(i==6){ //6번은 서식 초기화버튼이므로 누를 경우 모든 버튼 다시 white로 바꿈
				for(var i=0;i<6;i++){
					divColor[i].style.backgroundColor="white";
				}
			}else if(divColor[i].style.backgroundColor=="gray"){
				divColor[i].style.backgroundColor="white";
			}else if(divColor[i].style.backgroundColor=="white"){
				divColor[i].style.backgroundColor="gray";
			}
		}
		var text;
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
			//submit 버튼이 눌리면 작성된 내용의 innerHTML 값을 input type hidden value에 넣어줘서 servlet 전송
			text=document.getElementById("writeContent").innerHTML;
			console.log(text);
			document.getElementById("hiddenContent").value=text;
			console.log(document.getElementById("content").value);
			return true;
 		}

	</script>
</html>