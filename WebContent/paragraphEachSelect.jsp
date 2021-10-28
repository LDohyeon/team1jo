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
            .content{
                width: 800px;
                margin: 0 auto;
            }
            .fontType , .fontSize, .fontStyle, .fontAlign, .img{
                margin: 0px 5px 0px 0px;
                float: left;
            }
            .button{
            	float: right;
            	clear: both;
            }
            .tagColor
			{
				color: blue;
			    background-color: lightblue;
			    border-color: blue;
			    float:left;
			    margin-right:5px;
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
		<div class="header">
            header
        </div>
        
        <div class="content">
        	<h2>${pDTO.getTitle() }</h2>
        	<p>Id ${pDTO.getId() },Num ${pDTO.getNum() },Name ${pDTO.getName() },Date ${pDTO.getDatetime() },Category ${pDTO.getCategory() },Hits ${pDTO.getHits() }</p>
        	<c:set var="tag" value="${fn:split(pDTO.getTag(),'★') }"></c:set>
        	<c:forEach items="${tag }" var="tags">
				<span class="tagColor"><a onclick="getTag(this)" href="#">${tags }</a></span>
			</c:forEach>
			
        	<br>
        	<hr>
        	
			
			
			<p>${pDTO.getContents() }</p>
			<input id="languageSelect" type="hidden" value="${language }">
			<input id="langValueSelect" type="hidden" value="${langValue }">
			
			<br>
			<hr>
			
		 	<c:if test="${loginUserId == pDTO.getId() }">
		 		<a href="paragraphUpdate.do?num=<%=num%>">수정</a>
	 			<a onclick="return confirm('정말 삭제하시겠습니까?')" href="paragraphDelete.do?num=<%=num%>">삭제</a>
		 	</c:if>

			<a onclick="return confirm('정말로 신고하시겠습니까?')" href="memberReport.do?id=${pDTO.getId() }&&num=<%=num %>"><button type="button" class="button">신고</button></a>
			
			<br>
			<br>
			<script>
				var languageSelect =document.getElementById("languageSelect").value;
				var langValueSelect =document.getElementById("langValueSelect").value;
				var languagesSelect= languageSelect.split(",");
				var langValuesSelect= langValueSelect.split(",");
	
				for(var i=0; i<languagesSelect.length-1; i++)
				{
					var textArea= document.getElementById(langValuesSelect[i]);
	
					textArea = CodeMirror.fromTextArea(textArea, {
						lineNumbers: true,
						theme: "darcula",
						mode: languagesSelect[i],
						//mode: "text/x-python",
						spellcheck: true,
						autocorrect: true,
						autocapitalize: true,
						readOnly: true,
						autoCloseTags: true
					});
					textArea.setSize("800", "250");
				}
				
			</script>
			
			<form method="post" action="comment.do" class="frm" name="frm">
	            <div>
	                <div class="editor">
	                    <div class="editorTool">
	                        <div class="fontType">
	                            <select class="fontTypes" onchange="selectFont(0)">
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
	                            <input type="color" class="fontColor"><button class="divColor" type="button" onclick="btnColor(3); document.execCommand('foreColor', false, document.getElementById('fontColor').value);">글자색</button>
	                            <input type="color" class="bgColor" value="#ffffff"><button class="divColor" type="button" onclick="btnColor(4); document.execCommand('hiliteColor', false, document.getElementById('bgColor').value);">배경색</button>
	                        </div>
	                        <div class="fontAlign">
	                            <button class="divColor" type="button" onclick="btnColor(5); document.execCommand('justifyleft');">왼쪽</button>
	                            <button class="divColor" type="button" onclick="btnColor(6); document.execCommand('justifycenter');">가운데</button>
	                            <button class="divColor" type="button" onclick="btnColor(7); document.execCommand('justifyRight');">오른쪽</button>
	                            <button class="divColor" type="button" onclick="btnColor(8); document.execCommand('removeFormat');">서식삭제</button>                      
	                        	
	                        </div>

	                        <div class="img">
	                            <button class="divColor" type="button" onclick="imgInsert(0)">사진</button>
	                        </div>
	                        
	                        <div class="codeWrite">   
	                        	<select class="language" onchange="langs()">
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
          
	                    <div class="writeContent" contenteditable="true" placeholder="내용을 입력해주세요.">${imageInsertContent }</div>
	                    
	                    <input class="content" type="hidden" name="content">
	                    
	                    <!-- 수정할 때 필요한 번호 -->
	                    <input class="num" type="hidden" value="${pDTO.getNum() }" name="num">

	            	 </div>
	            	 
	            	 <input type="submit" value="글쓰기" onclick="return writeCheck(0);">

				 	
	            </div>
        	</form>


		</div>
		
		<div class="footer">
            footer
        </div>
        <form method="post" action="commentInsertImage.do" enctype="multipart/form-data" name="imgFrm" class="imgFrm">
        	<input type="file" name="imgInput" class="imgInput" onchange="imgChange(0)">
        	<input class="imgContent" type="hidden" name="imgContent">
        	<input name="num" type="hidden" value="<%=num%>">
        </form>
        
		
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

				return false;
		}
		
		
		function imgInsert(e)
		{
			var imgInput = document.getElementsByClassName("imgInput");
			
			imgInput[e].click();
			
			imgChange(e);
			
		}
		function imgChange(e)
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
					range.insertNode(insertNodeImg);
					range.setStartAfter(insertNodeImg);
					
					document.getElementsByClassName("writeContent")[e].focus();
					
		  				
					document.getElementsByClassName("imgContent")[e].value=document.getElementsByClassName('writeContent')[e].innerHTML;
				
					document.getElementsByClassName("imgFrm")[e].submit();
					
				}	
			}
		}
	
	
	
		
		function getTag(ths){
			var text=$(ths).text();
			location.href="search.do?searchValue="+text.replace('#','')+"&startPage=1";
		}
		
	</script>
</html>









