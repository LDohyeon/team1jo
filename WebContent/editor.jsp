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
        	<form method="get" action="#" name="frm">
				<div class="title">
	                <input id="writeTitle" class="writeTitle" type="text" placeholder="제목을 입력해주세요." name="">
	            </div>
	            <div>
	                <div class="editor">
	                    <div class="editorTool">
	                        <div class="fontType">
	                            <select>
	                            	<option>고딕</option>
	                            	<option>명조</option>
	                            	<option>궁서</option>
	                            </select>
	                        </div>
	                        <div class="fontSize">
	                            <select>
	                            	<option>10pt</option>
	                            	<option>12pt</option>
	                            	<option>15pt</option>
	                            </select>
	                        </div>
	                        <div class="fontStyle">
	                            <button class="divColor" type="button" onclick="btnColor(0)">두껍게</button>
	                            <button class="divColor" type="button" onclick="btnColor(1)">밑줄</button>
	                            <button class="divColor" type="button" onclick="btnColor(2)">기울이기</button>
	                            <button class="divColor" type="button" onclick="btnColor(3)">취소선</button>
	                            <button class="divColor" type="button" onclick="btnColor(4)">글자색</button>
	                            <button class="divColor" type="button" onclick="btnColor(5)">배경색</button>
	                        </div>
	                        <div class="fontAlign">
	                            <button class="divColor" type="button" onclick="btnColor(6)">왼쪽</button>
	                            <button class="divColor" type="button" onclick="btnColor(7)">가운데</button>
	                            <button class="divColor" type="button" onclick="btnColor(8)">오른쪽</button>
	                            <button class="divColor" type="button" onclick="btnColor(9)">양쪽</button>
	                        </div>
	                        <div class="img">
	                            <button class="divColor" type="button" >사진</button>
	                        </div>
	                    </div>
	                    <div id="writeContent" class="writeContent" contenteditable="true" placeholder="내용을 입력해주세요." name=""></div>
	                	</div>
	                <input type="submit" value="글쓰기" onclick="return writeCheck()">
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
		var divColor=document.getElementsByClassName("divColor");
		for(var i=0;i<divColor.length;i++){
			divColor[i].style.backgroundColor="white";
		}

		function btnColor(i){
			if(divColor[i].style.backgroundColor=="gray"){
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
			return true;
 		}

	</script>
</html>