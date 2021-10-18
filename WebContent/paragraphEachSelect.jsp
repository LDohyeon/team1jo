<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ page import="DTO.ParagraphDTO" %>
<%@ page import="DAO.ParagraphDAO" %>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="utf-8">
		<title>게시판 내용 보기</title>
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
        	<h2>Title ${pDTO.getTitle() }</h2>
        	<p>Id ${pDTO.getId() },Num ${pDTO.getNum() },Name ${pDTO.getName() },Date ${pDTO.getDatetime() },Category ${pDTO.getCategory() },Hits ${pDTO.getHits() }</p><hr><br>
			<p>내용 ${pDTO.getContents() }</p>
			
			<br>
			<hr>
			
		 	<c:if test="${loginUserId == pDTO.getId() }">
		 		<a href="paragraphUpdate.do?num=<%=num%>">수정</a>
	 			<a onclick="return confirm('정말 삭제하시겠습니까?')" href="paragraphDelete.do?num=<%=num%>">삭제</a>
		 	</c:if>

			<a onclick="return confirm('정말 삭제하시겠습니까?')" href="memberReport.do?id=${pDTO.getId() }&&num=<%=num %>"><button type="button" class="button">신고</button></a>
			
			<br>
			<br>
			
			<div class="reply">
			댓글
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
					</div>
					<div id="writeContent" class="writeContent" contenteditable="true" placeholder="내용을 입력해주세요."></div>
						<input id="content" type="hidden" value="" name="content">
				</div>
				<input type="submit" class="button" value="글쓰기" onclick="return writeCheck();">
			</form>
        </div>
		
		<div class="footer">
            footer
        </div>
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

	</script>
</html>