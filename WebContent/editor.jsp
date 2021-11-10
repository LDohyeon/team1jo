<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<!DOCTYPE html>
<html lang="ko">
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
		<link rel="stylesheet" href="style.css">
		<style>
			@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&family=Nanum+Myeongjo&display=swap');
			
            .writeContent{ 
                width: 800px;
                height: 500px;
                border: 1px solid #ccc;
                overflow-y: auto;/*스크롤 기능*/
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
                margin: 30px auto;
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
			.divColor2
			{
				background-color:white;
				border:1px solid lightgray;
			}
			.divColor3
			{
				background-color:white;
				border:1px solid lightgray;
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
			.fontType{
				line-height:20px;
			}
			#fontColor, #bgColor{
				height:23px;
				width:23px;
			}
			.divColor{
				border: 1px solid lightgray;				
			}
			.divColor:hover{
				background-color: lightgray;
			}
			.buttonsArea
			{
				padding-top: 20px;
				text-align: center;
			}
			
			.button
			{
				background-color: #064998;
				color: #fff;
				height: 40px;
				line-height: 40px;
				text-align: center;
				margin: 5px 0;
				font-size: 14px;
				
				width: 80px;
				display: inline-block;
				border:0;
			}
			.button:hover
			{
				background-color: #005cc3;
			}
			.button2
			{
			    height: 25px;
			    line-height: 25px;
			    text-align: center;
			    margin: 5px;
			    font-size: 10px;
			    width: 44px;
    			border: 1px solid #dbdadf;
    			background-color: #f1f1f1;
    			color: #000;
    			
    			display: inline-block;
    			float: right;
			}
			.button2:hover
			{
				background-color: #fff;
			}
			[contenteditable=true]:empty:before {
			  content: attr(aria-placeholder);
			  display: block; /* For Firefox */
			}
			footer
			{
				margin-top: 87px;
			}
			/*.CodeMirror-scroll
			{
				overflow:none;
			}*/
			
			
        </style>
	</head>
	<jsp:include page="./header.jsp"/>
	<body>
        <!--컨텐츠 시작-->
        <div class="content">
        	<form method="post" action="paragraphEditorWrite.do" id="frm" name="frm">
				<div class="title">  
	            	<c:if test="${imgTitle == null }">
	            		<input id="writeTitle" class="writeTitle" value="${pDTO.getTitle() }" type="text" placeholder="제목을 입력해주세요." name="title">
	            	</c:if>
	            	<c:if test="${imgTitle != null }">
	            		<input id="writeTitle" class="writeTitle" value="${imgTitle }" type="text" placeholder="제목을 입력해주세요." name="title">
	            	</c:if>
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
	                            <button class="divColor" type="button" onclick="document.execCommand('bold');">두껍게</button>
	                            <button class="divColor" type="button" onclick="document.execCommand('Underline');">밑줄</button>
	                            <button class="divColor" type="button" onclick="document.execCommand('italic');">기울이기</button>
	                            <input type="color" id="fontColor"><button class="divColor2" type="button" onclick="document.execCommand('foreColor', false, document.getElementById('fontColor').value);">글자색</button>
	                            <input type="color" id="bgColor" value="#ffffff"><button class="divColor2" type="button" onclick="document.execCommand('hiliteColor', false, document.getElementById('bgColor').value);">배경색</button>
	                           
								<button class="divColor" type="button" onclick="justify('justifyleft')">왼쪽</button>
	                            <button class="divColor" type="button" onclick="justify('justifycenter')">가운데</button>
	                            <button class="divColor" type="button" onclick="justify('justifyRight')">오른쪽</button>
	                            <button class="divColor3" type="button" onclick="document.execCommand('removeFormat');">서식삭제</button>  
	                            <button class="divColor2" type="button" onclick="imgInsert()">사진</button>
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
	                        	<input class="divColor2" type="button" onclick="code()" value="코드 작성 하러 가기">  
	                        	<input class="divColor2" type="button" onclick="codeUpdate()" value="코드 수정하러 가기">
	                        </div>

	                    </div>
	                    <div>
	                    	<br>
	                    </div>
          
	                    <div id="writeContent" class="writeContent" contenteditable="true" aria-placeholder="내용을 입력해주세요.">${imageInsertContent }${pDTO.getContents() }</div>
	                    
	                    <input id="content" type="hidden" name="content">
	                    
	                    <!-- 수정할 때 필요한 번호 -->
	                    <input id="num" type="hidden" value="${pDTO.getNum() }" name="num">

	            	 </div>
	            	 <div class="buttonsArea">
	            	 	<c:if test="${pDTO.getTitle() ==null }">
		            	 	<input class="button" type="submit" value="글쓰기" onclick="return writeCheck();">
		            	 </c:if>
		            	 <c:if test="${pDTO.getTitle() !=null }">
		            	 	<input class="button" type="submit" value="글수정" onclick="return writeCheckUpdate();">
		            	 </c:if>
	            	 </div>
				 	
	            </div>
        	</form>
 
        </div>
        <!--컨텐츠 종료-->
        <form method="post" action="paragraphImageInsert.do" enctype="multipart/form-data" name="imgFrm" id="imgFrm">
        	<input type="file" name="imgInput" id="imgInput" onchange="imgChange()">
        	<input id="imgContent" type="hidden" name="imgContent">
        	<input id="imgTitle" type="hidden" name="imgTitle">
        </form>
		<div id="wrapPonup">
			<div id="ponup">
				<textarea id="writeContentLib"></textarea>
				<button class="button" onclick="cansle()">취소</button>
				<button class="button" onclick="realGo()">저장</button>
			</div>
		</div>
		<input id="hid" type="hidden">
	</body>
	<jsp:include page="./footer.jsp"/>
	<script>
	

		function justify(e)
		{
			var et= event.target.style.backgroundColor;
			if(et=="white")
			{
				document.execCommand(e);
			}
			else
			{
				document.execCommand('justifyleft');
			}
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
	
		function btnColor(e)
		{
			if(document.getSelection().anchorNode !=null)
			{
				if(e.target.style.backgroundColor=="white")
				{
					e.target.style.backgroundColor="gray";
				}
				else
				{
					e.target.style.backgroundColor="white";
				}
			}
		}
		
		function init()
		{	
	        for (var i = 0; i <divColor.length; i++)
	        {
	        	divColor[i].addEventListener("click", btnColor, false);
	        }
	    }

	    init();
	    
	    var divColor3 = document.getElementsByClassName("divColor3");
	    
	    function init3()
	    {
	    	 for (var i = 0; i <divColor3.length; i++)
		        {
	    			 divColor3[i].addEventListener("click", function(){
	    		    	for(var j=0; j<divColor.length; j++)
	    		    	{
	    		    		divColor[j].style.backgroundColor="white";
	    		    	}
	    		    });
		        }
	    }
	    init3();

		function writeCheck()
		{
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
	
		function writeCheckUpdate()
		{
			var frm = document.getElementById("frm");

			frm.action="paragraphUpdate.do";
			
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
	
	
		function imgInsert()
		{
			
			if(document.getSelection().anchorNode !=null)
			{
				var imgInput = document.getElementById("imgInput");
				document.getElementById("writeContent").focus();
				
				imgInput.click();
				
				imgChange();
			}
		}
		function imgChange()
		{
			var imgInput = document.getElementById("imgInput");
			
			if(imgInput.files.length>0)
			{
				if(imgInput.files)
				{
					var sel2 = document.getSelection();

		            var range2 = sel2.getRangeAt(0);

		            var insertNodeImg=document.createElement("img");
					insertNodeImg.setAttribute("src", "★");
					range2.insertNode(insertNodeImg);
					range2.setStartAfter(insertNodeImg);
					
					document.getElementById("writeContent").focus();
					
		  				
					document.getElementById("imgContent").value=document.getElementById('writeContent').innerHTML;
					
					document.getElementById("imgTitle").value=document.getElementById('writeTitle').value;

					document.getElementById("imgFrm").submit();
					
				}	
			}
		}

		var language;
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
		var hid;

		function code()
		{
			
			langs();//온체인지
			
			if(language == "none")
			{
				alert("언어를 선택해주세요");
				return;
			}
			
			document.getElementById("writeContent").focus();
			
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
			cansleButton.setAttribute("class", "button2");
			cansleButton.innerText="취소";
			wrapPonup.style.display="block";
			
			realgoButton.setAttribute("onclick", "realGo()");
			realgoButton.setAttribute("class", "button2");
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

				
				document.getElementById("focusValue").innerHTML=selected;
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
				
				textarea.innerHTML=getSels[2];
				
				
				cansleButton.setAttribute("onclick", "cansleUpdate()");
				cansleButton.setAttribute("class", "button2");
				cansleButton.innerText="취소";
				wrapPonup.style.display="block";
				
				realgoButton.setAttribute("onclick", "realGoUpdate()");
				realgoButton.setAttribute("class", "button2");
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
			document.getElementById("focusValue").insertAdjacentText("afterend", document.getElementById("focusValue").innerHTML);
			
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
