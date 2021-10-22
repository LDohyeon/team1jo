<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
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
		<style>			
            .writeContent{ 
                width: 800px;
                height: 300px;
                border: 1px solid #ccc;
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
        	<p>Id ${pDTO.getId() },Num ${pDTO.getNum() },Name ${pDTO.getName() },Date ${pDTO.getDatetime() },Category ${pDTO.getCategory() },Hits ${pDTO.getHits() }</p><hr><br>
			<p>${pDTO.getContents() }</p>
			<input id="language" type="hidden" value="${language }">
			<input id="langValue" type="hidden" value="${langValue }">
			
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
				var language =document.getElementById("language").value;
				var langValue =document.getElementById("langValue").value;
				var languages= language.split(",");
				var langValues= langValue.split(",");
	
				for(var i=0; i<languages.length-1; i++)
				{
					var textArea= document.getElementById(langValues[i]);
	
					textArea = CodeMirror.fromTextArea(textArea, {
						lineNumbers: true,
						theme: "darcula",
						mode: languages[i],
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
			
			<!-- 댓글 부분 -->
			<div class="reply">
			댓글
			</div>
			<div>
				<c:forEach items="${list }" var="list">
					<c:choose>
						<c:when test="${flag =='u' && num == list.getNum() }">
							<form method="post" action="commentUpdate.do" name="frm">
								<div class="editor" id="editor">
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
										<select id="commentLanguage">
				                       		<option value="none">질문할 언어를 선택하세요</option>
				                       		<option value="text/xml">html/xml</option>
				                           	<option value="text/x-python">python</option>
				                           	<option value="text/x-java">java</option>
				                           	<option value="text/x-sql">sql</option>
				                           	<option value="text/javascript">javascript</option>
				                       	</select>
				                       	<input class="divColor" type="button" onclick="code()" value="코드 작성 하러 가기">
									</div>
									<div>
										<br>
									</div>
									<div id="writeContent1" class="writeContent" contenteditable="true">${comment.comment }</div>
									<input id="content1" type="hidden" value="" name="comment">
									<input name="num" type="hidden" value="${comment.num }">
								</div>
								<input type="submit" class="button" value="수정" onclick="return writeCheck1()">
							</form>
						</c:when>
						<c:otherwise>
							<span id="comment">
							<span>${flag }</span>
							<span>${list.getNum() }</span>
							<span>${list.getId()}</span>
							<span>${list.getTime()}</span>
							<span>${list.getComment()}</span>
							<c:if test="${loginUserId == list.getId() }">
								<a href="commentUpdate.do?num=${list.getNum() }">수정</a>
		 						<a onclick="return confirm('정말 삭제하시겠습니까?')" href="commentDelete.do?num=${list.getNum() }">삭제</a>
							</c:if>
					</span>
						</c:otherwise>
					</c:choose>
					<br>
				</c:forEach>
			</div>
			<form method="post" action="comment.do" name="frm">
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
						<select id="commentLanguage">
                       		<option value="none">질문할 언어를 선택하세요</option>
                       		<option value="text/xml">html/xml</option>
                           	<option value="text/x-python">python</option>
                           	<option value="text/x-java">java</option>
                           	<option value="text/x-sql">sql</option>
                           	<option value="text/javascript">javascript</option>
                       	</select>
                       	<input class="divColor" type="button" onclick="code()" value="코드 작성 하러 가기">
					</div>
					<div>
						<br>
					</div>
					<div id="writeContent2" class="writeContent" contenteditable="true"></div>
					<input id="content2" type="hidden" value="" name="content">
					<input name="paragraph_num" type="hidden" value="${pDTO.getNum() }">
				</div>
				<input type="submit" class="button" value="댓글쓰기" onclick="return writeCheck2();">
			</form>
        </div>
		
		<div class="footer">
            footer
        </div>
	</body>
	<script>
	
		function code()
		{
			var commentLanguage=document.getElementById("commentLanguage");
			
			if(commentLanguage.value == "none")
			{
				alert("언어를 선택해주세요");
				return;
			}
	
			var url="code.do?language="+commentLanguage.value;
			
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
		function writeCheck1(){
			if(document.getElementById("writeContent1").innerHTML==""){
				alert("내용을 입력해주세요.");
				document.getElementById("writeContent1").focus();
				return false;
			}
			
			var text;
			text=document.getElementById('writeContent1').innerHTML;
			document.getElementById('content1').value=text;
			return true;
 		}
		
		function writeCheck2(){
			if(document.getElementById("writeContent2").innerHTML==""){
				alert("내용을 입력해주세요.");
				document.getElementById("writeContent2").focus();
				return false;
			}
			
			var text;
			text=document.getElementById('writeContent2').innerHTML;
			document.getElementById('content2').value=text;
			return true;
 		}
		
	</script>
</html>