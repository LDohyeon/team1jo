<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="DTO.ParagraphDTO" %>
<%@ page import="DAO.ParagraphDAO" %>
<%@ page import="DTO.CommentDTO" %>
<%@ page import="DAO.CommentDAO" %>
<%@page import="java.util.List" %>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="utf-8">
		<title>게시판 내용 보기</title>
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
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		
		<link rel="stylesheet" href="style.css">
		<style>			
            .writeContent{ 
                width: 800px;
                height: 300px;
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
            .writeContent:empty:before {
                content: attr(placeholder);
                color: gray;
            }
            .bodys{
                width: 800px;
                margin: 0 auto;
            }
            .fontType , .fontSize, .fontStyle, .fontAlign, .img{
                margin: 0px 5px 0px 0px;
                float: left;
            }
            
            .tagColor
			{
				border-radius: 15px;
				font-size:10.5px;
				padding:3px;
				color: black;
			    background-color: cornsilk;
			   
			    border:1px solid #989898;
			    margin-right: 5px;
			   
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
			.imgInput
			{
				display:none;
			}
			.commentUpdate
			{
				display:none;
			}
			#imageInsertContent
			{
				display:none;
			}
			#wrapPonup{
				posotion: relative;
				z-index: 30;
			}
			#ponup{
				posotion: absolute;
				z-index: 60;
			}
			
			.CodeMirror {
			    border: 1px solid #eee;
			    height: auto;
			    max-height:200px;
			}
			
			.CodeMirror-scroll {
			    height: auto;
			    max-height:200px;
			}
			
			#ponup .CodeMirror
			{
				height: 400px;
			}
			#ponup .CodeMirror-scroll
			{
				height: 400px;
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
			.clicked
			{
				background-color:gray;
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
			.button3
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
			}

			.button2:hover, .button3:hover
			{
				background-color: #fff;
			}
			.fontType{
				line-height:20px;
			}
			.fontColor, .bgColor{
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
			form div span
			{
				padding:0;
			}
			.smallText{
				font-size: 10px;
				color:gray;
			}

        </style>
	</head>
	<jsp:include page="./header.jsp"/>
	<body>
	<c:if test="${report!=null }">
		<script>
			alert("신고가 완료되었습니다.");
		</script>
	</c:if>
	
	<%
		int num=Integer.parseInt(request.getParameter("num"));
		ParagraphDAO pDAO = ParagraphDAO.getInstance();
		ParagraphDTO pDTO = pDAO.ParagraphContents(num);
	%>
        <div class="bodys">
        	<h2>${pDTO.getTitle() }</h2>
        	<p><strong>${pDTO.getId() }</strong> <span class="smallText">${pDTO.getDatetime() } 조회수 ${pDTO.getHits() }</span></p>
        	<c:set var="tag" value="${fn:split(pDTO.getTag(),'★') }"></c:set>
        	<c:forEach items="${tag }" var="tags">
        		<c:if test="${pDTO.getTag() == '' }">
        		
        		</c:if>
        		<c:if test="${pDTO.getTag() !='' }">
        			<span class="tagColor"><a href="#" onclick="getTag(this)">${tags }</a></span>
        		</c:if>
				
			</c:forEach>
			
        	<div>
				<br>
			</div>
        	<hr>

			<p>${pDTO.getContents() }</p>
			<input id="languageMode" type="hidden" value="${languageMode }">
			<input id="languageModeId" type="hidden" value="${languageModeId }">

			<div>
				<br>
			</div>
			<hr>
			
			<div class="buttonsArea">
				<c:if test="${loginUserId == pDTO.getId() }">
			 		<a class="button" href="paragraphUpdate.do?num=<%=num%>">수정</a>
		 			<a class="button" onclick="return confirm('정말 삭제하시겠습니까?')" href="paragraphDelete.do?num=<%=num%>">삭제</a>
			 	</c:if>
			</div>

			<c:choose>
				<c:when test="${loginUser.getAuthority()==4 }">
					<a onclick="alert('${loginMsg}')"><button type="button" class="button2">신고</button></a>
				</c:when>
				<c:when test="${loginUserId==null }">
					<a onclick="alert('로그인 후 이용해주세요')"><button type="button" class="button2">신고</button></a>
				</c:when>
				<c:when test="${loginUserId!=null }">
					<a onclick="return confirm('정말로 신고하시겠습니까?')" href="memberReport.do?id=${pDTO.getId() }&&num=<%=num %>"><button type="button" class="button2">신고</button></a>
				</c:when>
			</c:choose>

			
			
			<div>
				<br>
			</div>
			<div>
				<br>
			</div>

			<hr>
			<p>댓글</p>
			<c:set var="count" value="${-1 }"></c:set>
				
			<c:forEach items="${clistSelect }" var="clistSelect">
				<!--<span>댓글 고유 번호 : ${clistSelect.getNum() }</span>  -->
				<span><strong>${clistSelect.getId() }</strong></span>
				<span class="smallText">${clistSelect.getTime() }</span>
				<!--<span>댓글 순서도 : ${clistSelect.getCommentCount()}</span>  -->
				<c:if test="${loginUserId == clistSelect.getId() }">
						
					<span class="button3" onclick="cup(${clistSelect.getCommentCount()})">수정</span>				
					<a onclick="return confirm('정말 삭제하시겠습니까?')" class="button3" href="commentDelete.do?num=${pDTO.getNum() }&&commentNum=${clistSelect.getNum() }"><span>삭제</span></a>				
				</c:if>
				
				<c:if test="${loginUserId== null }">
					<a onclick="alert('로그인 후 이용해주세요')"><button type="button" class="button2">신고</button></a>
				</c:if>
				<c:if test="${loginUserId!= null }">
					<a onclick="return confirm('정말로 신고하시겠습니까?')" href="memberReport.do?id=${clistSelect.getId() }&&num=<%=num %>"><button type="button" class="button2">신고</button></a>
				</c:if>			
				<div>
					<br>
				</div>
				
				<div class="commentUpdate">
					<form method="post" action="commentUpdate.do" class="frm" name="frm">
			            <div>
			                <div class="editor">
			                    <div class="editorTool">
			                        <div class="fontType">
			                            <select class="fontTypes" onchange="selectFont(${clistSelect.getCommentCount()})">
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
			                            <input type="color" class="fontColor"><button class="divColor" type="button" onclick="document.execCommand('foreColor', false, document.getElementsByClassName('fontColor')[${clistSelect.getCommentCount()}].value);">글자색</button>
			                            <input type="color" class="bgColor" value="#ffffff"><button class="divColor" type="button" onclick="document.execCommand('hiliteColor', false, document.getElementsByClassName('bgColor')[${clistSelect.getCommentCount()}].value);">배경색</button>
			                            <button class="divColor" type="button" onclick="document.execCommand('justifyleft');">왼쪽</button>
			                            <button class="divColor" type="button" onclick="document.execCommand('justifycenter');">가운데</button>
			                            <button class="divColor" type="button" onclick="document.execCommand('justifyRight');">오른쪽</button>
			                            <button class="divColor3" type="button" onclick="document.execCommand('removeFormat');">서식삭제</button>
			                            <button class="divColor2" type="button" onclick="imgInsert(${clistSelect.getCommentCount()})">사진</button> 
			                        </div>
			                        
			                        <div class="codeWrite">   
			                        	<select class="language" onchange="langs(${clistSelect.getCommentCount()})">
			                        		<option value="none">질문할 언어를 선택하세요</option>
			                        		<option value="text/xml">html/xml</option>
			                            	<option value="text/x-python">python</option>
			                            	<option value="text/x-java">java</option>
			                            	<option value="text/x-sql">sql</option>
			                            	<option value="text/javascript">javascript</option>
			                        	</select>
			                        	<input class="divColor2" type="button" onclick="code(${clistSelect.getCommentCount()})" value="코드 작성 하러 가기">  
			                        	<input class="divColor2" type="button" onclick="codeUpdate(${clistSelect.getCommentCount()})" value="코드 수정하러 가기">
			                        </div>
		
			                    </div>
			                    <div>
			                    	<br>
			                    </div>
			                    <div class="writeContent" contenteditable="true" placeholder="내용을 입력해주세요.">${clistSelect.getComment()}</div>
			                    
			                    <input class="content" type="hidden" name="commentContent">
			                    
			                    <!-- 수정할 때 필요한 번호 -->
			                    
			                    <input class="num" type="hidden" value="${clistSelect.getNum() }" name="commentNum">
			                    <input class="num" type="hidden" value="${pDTO.getNum() }" name="num">
			            	 </div>
			            	 
			            	 <input class="button2" type="button" value="취소" onclick="cupCancle(${clistSelect.getCommentCount()})">
			            	 <input class="button2"	type="submit" value="수정" onclick="return writeCheck(${clistSelect.getCommentCount()})">
			            	 <div>
			                    <br>
			                 </div>
			                 <div>
			                    <br>
			                 </div>
						 	
			            </div>
		        	</form>
		        	<!-- action="commentInsertImage.do" -->
			        <form method="post" enctype="multipart/form-data" name="imgFrm" class="imgFrm">
			        	<input type="file" name="imgInput" class="imgInput" onchange="imgChange(${clistSelect.getCommentCount()}, 'commentInsertImage.do')">
			        	<input class="imgContent" type="hidden" name="imgContent">
			        	<input name="num" type="hidden" value="<%=num%>">
			        	<input class="num" type="hidden" value="${clistSelect.getCommentCount()}" name="commentNum">
			        	
			        </form>
				</div>
				
				<div>${clistSelect.getCommentSplit() }</div>

				<hr>
			</c:forEach> 
        	
			
			
			
			<form method="post" action="comment.do" class="frm" name="frm">
	            <div>
	                <div class="editor">
	                    <div class="editorTool">
	                        <div class="fontType">
	                            <select class="fontTypes" onchange="selectFont(${commentLastCount })">
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
	                            <input type="color" class="fontColor"><button class="divColor" type="button" onclick="document.execCommand('foreColor', false, document.getElementsByClassName('fontColor')[${commentLastCount }].value);">글자색</button>
	                            <input type="color" class="bgColor" value="#ffffff"><button class="divColor" type="button" onclick="document.execCommand('hiliteColor', false, document.getElementsByClassName('bgColor')[${commentLastCount }].value);">배경색</button>
	                        </div>
	                        <div class="fontAlign">
	                            <button class="divColor" type="button" onclick="document.execCommand('justifyleft');">왼쪽</button>
	                            <button class="divColor" type="button" onclick="document.execCommand('justifycenter');">가운데</button>
	                            <button class="divColor" type="button" onclick="document.execCommand('justifyRight');">오른쪽</button>
	                            <button class="divColor3" type="button" onclick="document.execCommand('removeFormat');">서식삭제</button>                      
	                        	
	                        </div>

	                        <div class="img">
	                            <button class="divColor2" type="button" onclick="imgInsert(${commentLastCount })">사진</button>
	                        </div>
	                        
	                        <div class="codeWrite">   
	                        	<select class="language" onchange="langs(${commentLastCount })">
	                        		<option value="none">질문할 언어를 선택하세요</option>
	                        		<option value="text/xml">html/xml</option>
	                            	<option value="text/x-python">python</option>
	                            	<option value="text/x-java">java</option>
	                            	<option value="text/x-sql">sql</option>
	                            	<option value="text/javascript">javascript</option>
	                        	</select>
	                        	
	                        	
	                        	<input class="divColor2" type="button" onclick="code(${commentLastCount })" value="코드 작성 하러 가기">  
	                        	<input class="divColor2" type="button" onclick="codeUpdate(${commentLastCount })" value="코드 수정하러 가기">
	                        </div>

	                    </div>
	                    <div>
	                    	<br>
	                    </div>
          
	                    <div class="writeContent" contenteditable="true" placeholder="내용을 입력해주세요."></div>
	                    
	                    <input class="content" type="hidden" name="content">
	                    
	                    <!-- 수정할 때 필요한 번호 -->
	                    <input class="num" type="hidden" value="${pDTO.getNum() }" name="paragraph_num">

	            	 </div>
	            	 <div class="buttonsArea">
	            	 	<input class="button" type="submit" value="글쓰기" onclick="return writeCheck(${commentLastCount })">
	            	 </div>
	            	 

	            </div>
        	</form>
			<form method="post" enctype="multipart/form-data" name="imgFrm" class="imgFrm">
	        	<input type="file" name="imgInput" class="imgInput" onchange="imgChange(${commentLastCount }, 'commentInsertImage.do')">
	        	<input class="imgContent" type="hidden" name="imgContent">
	        	<input name="num" type="hidden" value="<%=num%>">
	        	<input class="num" type="hidden" value="${commentLastCount }" name="commentNum">
	        </form>

		</div>

        <!-- 결제 창 판업 띄우기 -->
		<div id="wrapPonup">
			<div id="ponup">
				<textarea id="writeContentLib"></textarea>
				<button onclick="cansle()">취소</button>
				<button onclick="realGo()">저장</button>
			</div>
		</div>
		<input id="hid" type="hidden">
        <input id="commentLastCount" type="hidden" value="${commentLastCount }">

        <div id="imageInsertContent" contenteditable="true" placeholder="내용을 입력해주세요.">${imageInsertContent }</div>
        <input id="commentNum" type="hidden" value="${commentNum }">

    
	<script>	
		function selectFont(e){
			var select=document.getElementsByClassName("fontTypes")[e];
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
	    
	   
	    
	    

		function writeCheck(e)
		{
			if(document.getElementsByClassName("writeContent")[e].innerHTML=="")
			{
				alert("내용을 입력해주세요.");
				document.getElementsByClassName("writeContent")[e].focus();
				return false;
			}
				var text;
				text=document.getElementsByClassName("writeContent")[e].innerHTML;
				document.getElementsByClassName('content')[e].value=text;

				return true;
		}
		
		
		function imgInsert(e)
		{
			var imgInput = document.getElementsByClassName("imgInput");
			
			imgInput[e].click();
			
			imgChange(e);
			
		}
		function imgChange(e, action)
		{
			var imgInput = document.getElementsByClassName("imgInput");

			if(imgInput[e].files.length>0)
			{
				if(imgInput[e].files)
				{
					var sel = document.getSelection();
		            var range = sel.getRangeAt(0);

		            var insertNodeImg=document.createElement("img");
					insertNodeImg.setAttribute("src", "★");
					insertNodeImg.setAttribute("alt", "");
					range.insertNode(insertNodeImg);
					range.setStartAfter(insertNodeImg);
					
					document.getElementsByClassName("writeContent")[e].focus();
						
					document.getElementsByClassName("imgContent")[e].value=document.getElementsByClassName('writeContent')[e].innerHTML;
				
					document.getElementsByClassName("imgFrm")[e].action = action;
					document.getElementsByClassName("imgFrm")[e].submit();
				}	
			}
		}
		
	
		var language;
		function langs(e)
		{
			language=document.getElementsByClassName("language")[e].value;
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
 		
		function insertSpan(e)
		{
			var sel = document.getSelection();

            var range = sel.getRangeAt(0);

			var insertNodeSpan=document.createElement("span");
			insertNodeSpan.setAttribute("id", "focusValue");
			range.insertNode(insertNodeSpan);
			range.setStartAfter(insertNodeSpan);
			
			document.getElementsByClassName("writeContent")[e].focus();
		}
	
 		var wrapPonup=document.getElementById("wrapPonup");
		var hid;

		function code(e)
		{
			langs(e);//온체인지
			
			if(language == "none")
			{
				alert("언어를 선택해주세요");
				return;
			}
			
			var viewScroll=document.documentElement.scrollTop;
			
			scrolled(viewScroll);
			
			document.getElementsByClassName("writeContent")[e].focus();
			
			insertSpan(e);
			
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
		function codeUpdate(e)
		{
			if(document.getSelection().isCollapsed==true)
			{
				alert("수정하고 싶은 코드를 드래그 해주세요");
			}
			else if(document.getSelection().isCollapsed==false)
			{
				
				var viewScroll=document.documentElement.scrollTop;
				
				scrolled(viewScroll);
				
				insertSpan(e);
				
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
		function realGo()
		{
			var val ="※"+hid+"※"+writeContentLib.getValue()+"※";
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
		
		var cupClass = document.getElementsByClassName("commentUpdate");
		function cup(count)
		{
			cupClass[count].style.display="none";
			for(var i=0; i<cupClass.length; i++)
			{
				cupClass[i].style.display="none";
				if(i==count)
				{
					cupClass[count].style.display="block";
				}
			}
		}
		
		function cupCancle(count)
		{
			cupClass[count].style.display="none";
		}

		function scrolled(viewScroll)
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
				ponup.style.top=viewScroll+height+"px";	
				wrapPonup.style.width=fullWidth+"px";
				wrapPonup.style.height=fullHeight+"px";
			}
			pon();
			var ponupFrm = document.getElementById("ponupFrm");

		}
		
		
		function getTag(ths){
			var text=$(ths).text();
			location.href="search.do?searchValue="+text.replace('#','')+"&startPage=1";
		}
		

	</script>
		<script>
			var languageMode =document.getElementById("languageMode").value;
			var languageModeId =document.getElementById("languageModeId").value;

			var languageModeSplit= languageMode.split(",");
			var languageModeIdSplit= languageModeId.split(",");
			
			
			for(var i=0; i<languageModeSplit.length-1; i++)
			{
				var textArea= document.getElementById(languageModeIdSplit[i]);

				textArea = CodeMirror.fromTextArea(textArea, {
					//tabSize:2,
					//smartIndent:true,
					//viewportMargin: Infinity,
					//lineWrapping:true,   
	
					lineNumbers: true,
					theme: "darcula",
					mode: languageModeSplit[i],
					//mode: "text/x-python",
					spellcheck: true,
					autocorrect: true,
					autocapitalize: true,
					readOnly: true,
					autoCloseTags: true

				});
				//textArea.setSize("800", "200");

			}
		</script>
		<c:if test="${focusdown!=null }">
			<script>
				
				var commentLastCount= document.getElementById("commentLastCount").value;
			
				function writeFocus(commentLastCount)
				{
					document.getElementsByClassName("writeContent")[commentLastCount].focus();
				}
				//이미지 넣고 포커스를 맞추기 위함	
				writeFocus(commentLastCount);
			</script>
		</c:if>
		
		<c:if test="${imageInsertContent !=null }">
			<script>
				//이미지
				var imageInsertContent= document.getElementById("imageInsertContent").innerHTML;
				var commentNum= document.getElementById("commentNum").value;
		
				function imgInsertContent(imageInsertContent, commentNum)
				{

					document.getElementsByClassName("writeContent")[commentNum].innerHTML=imageInsertContent;

					var writeContentLength = document.getElementsByClassName("writeContent").length-1;
					
					if(commentNum != writeContentLength)	
					{
						document.getElementsByClassName("commentUpdate")[commentNum].style.display="block";
					}
	
					document.getElementsByClassName("writeContent")[commentNum].focus();
				}
				
				imgInsertContent(imageInsertContent, commentNum);
				//이미지
			</script>
		</c:if>
	</body>
	<jsp:include page="./footer.jsp"/>
</html>









