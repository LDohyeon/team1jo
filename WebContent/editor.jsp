<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>에디터</title>
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
            .codeWrite
           	{
           		float: right;
           	}
			.checkRed
			{
				color:red;
			}
			
			
			#wrapPonup
			{
				background-color:#0000002b;
				position: absolute;
    			left: 0;
    			top: 0;
    			display:none;
			}
			#ponup
			{
				border:1px solid black;
				
				/*width:800px;height:300px;*/
				position:absolute;
				background-color:white;
				padding:1%;
			}
			#red
			{
				color:red;
				margin-top:2%;
			}
			.ment
			{
				padding-left:2%;
				
			}
			.inputment
			{
				float:right;
				margin-left:2%;
			}
			#imgInput
			{
				display:none;
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
	                            <button class="divColor" type="button" onclick="imgInsert()">사진</button>
	                        </div>
	                        
	                        <div class="codeWrite">   
	                        	<select id="language" onchange="langs()">
	                        		<option value="none">질문할 언어를 선택하세요</option>
	                        		<option value="text/xml">html/xml</option>
	                            	<option value="text/x-python">python</option>
	                            	<option value="text/x-java">java</option>
	                            	<option value="text/x-sql">sql</option>
	                            	<option value="text/javascript">javascript</option>
	                        	</select>
	                        	
	                        	<input class="divColor" type="button" onclick="code()" value="코드 작성 하러 가기">  
	                        	<input class="divColor" type="button" onclick="codeUpdate()" value="코드 수정하러 가기">
	                        </div>

	                    </div>
	                    <div>
	                    	<br>
	                    </div>
	                    
	                    
	                   
	                    <div id="writeContent" class="writeContent" contenteditable="true" placeholder="내용을 입력해주세요.">
	                    </div>
	                    
	                    <input id="content" type="hidden" value="" name="content">
	                    
	       				
	       				

	            	 </div>
				 	<input type="submit" value="글쓰기" onclick="return writeCheck();">

	            </div>
	            
	            <!-- 이미지 -->
	            <input type="file" name="imgInput" id="imgInput" onchange="imgChange()">
	            <!-- 이미지 -->
	            
        	</form>
 
        </div>
        <!--컨텐츠 종료-->
        
        <!--푸터 시작-->
        <div class="footer">
            footer
        </div>

        <!--푸터 종료-->
        <!-- 코드를 수정한 다음 기존 코드를 삭제할 때 필요한 버튼 -->
	

			<!-- 결제 창 판업 띄우기 -->
			<div id="wrapPonup">
				<div id="ponup">
					<textarea id="writeContentLib"></textarea>
					<button onclick="cansle()">취소</button>
					<button onclick="realGo()">저장</button>
				</div>
			</div>
			<input id="hid" type="hidden">
	</body>
	

	<script>

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
				document.getElementById('content').value=text;

				return true;
		}
	
	
	
		//도현
		
		function imgInsert()
		{
			var imgInput = document.getElementById("imgInput");
			
			imgInput.click();
			
			imgChange();
			
		}
		function imgChange()
		{
			var imgInput = document.getElementById("imgInput");
			//이렇게 안 하고 span 태그 밑에 img 태그를 만들어서 넣고 삭제할 듯
			
			
			//var sel = document.getSelection();
			//var range = sel.getRangeAt(0);
			
			//var insertNodeImg=document.createElement("img");
			//insertNodeImg.setAttribute("src", imgInput);
			
			//range.insertNode(insertNodeImg);
			//range.setStartAfter(insertNodeImg);
			
			//docoment.getElementById("writeContent").focus();
			
			
			if(imgInput.files.length>0)
			{
				if(imgInput.files)
				{
					//console.log(imgInput.name);
					//console.log(imgInput.files[0]);
					//console.log(imgInput.files[0].name);
					//console.log(imgInput.files[0].type);
		  				
					request_doPost(imgInput);
				}	
			}
		}


		

		
		
 		function langs()
		{
			language=document.getElementById("language").value;
		}

 		var writeContentLib=null;
 		
 		function Lib(language)
 		{
 			writeContentLib= document.getElementById("writeContentLib");
			writeContentLib = CodeMirror.fromTextArea(writeContentLib, {
				//lineNumbers: true,
				theme: "darcula",
				mode: language,
				//mode:"text/x-python",
				spellcheck: true,
				autocorrect: true,
				autocapitalize: true,
				//readOnly: true,
				autoCloseTags: true
			});
			writeContentLib.setSize("800", "400");
			
 		}
 		
		var wrapPonup=document.getElementById("wrapPonup");
		var btn = document.getElementById("btn");
		var hid = document.getElementById.value;

		
		function code()
		{
			
			langs();//온체인지
			
			if(language == "none")
			{
				alert("언어를 선택해주세요");
				return;
			}
			
			document.getElementById("writeContent").focus({preventScroll:true});
			
			insertSpan();
			
			hid=language;
			
			var ponup=document.getElementById("ponup");
			
			while(ponup.hasChildNodes())//라이브러리가 복사되서 이 방법 밖에 없었다.
			{
				ponup.removeChild(ponup.firstChild);
			}
			
			var textarea=document.createElement("textarea");
			var cansleButton=document.createElement("button");
			var realgoButton=document.createElement("button");
			
			ponup.appendChild(textarea);
			ponup.appendChild(realgoButton);
			ponup.appendChild(cansleButton);
	
			textarea.setAttribute("id", "writeContentLib");
			cansleButton.setAttribute("onclick", "cansle()");
			cansleButton.innerText="취소";
			wrapPonup.style.display="block";
			
			realgoButton.setAttribute("onclick", "realGo()");
			realgoButton.innerText="저장";
			
			Lib(hid);
			
		}
		
		
		var getSels="";
		function codeUpdate()
		{
			if(document.getSelection().isCollapsed==true)
			{
				alert("수정하고 싶은 코드를 드래그 해주세요");
			}
			else if(document.getSelection().isCollapsed==false)
			{
				
				insertSpan();
				
				var selectedObj = window.getSelection();
				var selected = selectedObj.getRangeAt(0).toString();

				
				document.getElementById("focusValue").innerText=selected;
				selectedObj.deleteFromDocument();
				
				
				getSels=selected.split("※");
				                   
				//getSels[1]; 언어
				//getSels[2]; value

				var ponup=document.getElementById("ponup");
				
				while(ponup.hasChildNodes())//라이브러리가 복사되서 이 방법 밖에 없었다.
				{
					ponup.removeChild(ponup.firstChild);
				}
				
				var textarea=document.createElement("textarea");
				var cansleButton=document.createElement("button");
				var realgoButton=document.createElement("button");
				
				ponup.appendChild(textarea);
				ponup.appendChild(realgoButton);
				ponup.appendChild(cansleButton);
		
				textarea.setAttribute("id", "writeContentLib");
				
				textarea.innerText=getSels[2];
				
				
				cansleButton.setAttribute("onclick", "cansleUpdate()");
				cansleButton.innerText="취소";
				wrapPonup.style.display="block";
				
				realgoButton.setAttribute("onclick", "realGoUpdate()");
				realgoButton.innerText="저장";
				
				Lib(getSels[1]);

			}	
		}

		function insertSpan()
		{
			var sel = document.getSelection();

            var range = sel.getRangeAt(0);

			var insertNodeSpan=document.createElement("span");
			insertNodeSpan.setAttribute("id", "focusValue");
			range.insertNode(insertNodeSpan);
			range.setStartAfter(insertNodeSpan);
			
			document.getElementById("writeContent").focus();
		}
		
		function realGo()
		{
			var val="※"+hid+"※"+writeContentLib.getValue()+"※";
			document.getElementById("focusValue").insertAdjacentText("afterend", val);
			
			cansle();
		}
		function realGoUpdate()
		{
			var val="※"+getSels[1]+"※"+writeContentLib.getValue()+"※";
			document.getElementById("focusValue").insertAdjacentText("afterend", val);
			
			cansle();
		}
			
		function cansleUpdate()
		{
			document.getElementById("focusValue").insertAdjacentHTML("afterend", document.getElementById("focusValue").innerText);
			
			cansle();
		}

		function cansle()
		{
			document.getElementById("focusValue").remove();
			
			var wrapPonup=document.getElementById("wrapPonup");
			wrapPonup.style.display="none";
		}
		window.onload =function()
		{
			//판업창 디자인
			//판업창
			var ponup=document.getElementById("ponup");
			
			var scrollHeight = Math.max(
					  document.body.scrollHeight, document.documentElement.scrollHeight,
					  document.body.offsetHeight, document.documentElement.offsetHeight,
					  document.body.clientHeight, document.documentElement.clientHeight
					);
			
			var width=(window.screen.width/2)-(800/2);
			var height=(window.screen.height/2)-(600/2);
			
			var fullWidth=window.screen.width;
			var fullHeight=scrollHeight;
			function pon()
			{
				ponup.style.left=width+"px";	
				ponup.style.top=height+"px";	
				wrapPonup.style.width=fullWidth+"px";
				wrapPonup.style.height=fullHeight+"px";
			}
			pon();
			var ponupFrm = document.getElementById("ponupFrm");

		}

		
		

	</script>
</html>
