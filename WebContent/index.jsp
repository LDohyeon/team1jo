<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import ="java.util.*"%>
<%@ page import="DAO.ParagraphDAO" %>
<%@ page import="DTO.ParagraphDTO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="utf-8">
		<title>STATUS 200</title>
		<link rel="stylesheet" href="style.css">
		<style>
		
			/*임시 a태그 hover*/
			a:hover
			{
				color:lightgray;
			}
			body
			{
                margin: 0;
                padding: 0;
                /*font-size: 1.2em;*/
            }
            header
            {
                padding: 20px;
            }
            section
            {
                padding: 20px;
                display: flex;
                background-color: lightgray;
            }
            footer
            {
            	text-align: center;
            	font-size: 0.8em;
                padding: 20px;
                color: gray;
            }
            section > div {
                margin: auto;
                width: 150px;
                height: 25px;
            }
            .ulist
            {
                margin: 0;
                padding: 0;
                list-style-type: none;
                float: right;
            }
            .list
            {
                display: inline;
                margin: 0 20px 0 0 ;
            }
            .titleArea
			{
				margin:0 0 10px 0;
			}
            .paragraphListWrap
			{
				width: 850px;
				padding: 35px;
				border : 1px solid #dbdadf;
				margin : 60px auto;		
			}
			.spanWrap::after
			{
				content: "";
				display: block;
				clear: both;
			}
			.th
			{
				font-weight: bold;
				background-color: #f1f1f1;
				border-top: 1.5px solid #222;
				
			}
			.borderRight
			{
				border-right: 1px solid #dbdadf;
			}
			.narrow
			{
				text-align: center;
				display: inline-block;
				width: 70px;
				padding: 10px;
				float: left;
				border-bottom: 1px solid #dbdadf;
				line-height:36px;
				
			}
			.medium
			{
				text-align: center;
				display: inline-block;
				width: 165px;
				padding: 10px;
				float: left;
				border-bottom: 1px solid #dbdadf;
				line-height:36px;
			}
			.wide
			{
				text-align: left;
				display: inline-block;
				width: 371px;
				padding: 10px;
				float: left;
				border-bottom: 1px solid #dbdadf;
				height:36px;
			}
			.wideTitle{
				text-align: center;
				display: inline-block;
				width: 371px;
				padding: 10px;
				float: left;
				border-bottom: 1px solid #dbdadf;
				height:36px;
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
			.title{
				text-align:center;
			}
			.linkBlack{
				color: black;
				text-decoration:none;
			}
			.txt_line {
				width:370px;
		      	overflow:hidden;
		      	text-overflow:ellipsis;
		      	white-space:nowrap;
		      	overflow: hidden;
		      	
		 	}
		 	.txt_line2 {
				width:370px;
		      	overflow:hidden;
		      	text-overflow:ellipsis;
		      	white-space:nowrap;
		      	overflow: hidden;
		      	line-height:36px;
		 	}
		 	.paragraphListWrap{
		 		min-height: calc(100vh - 320px);
		 	}
		</style>
	</head>
		<body>
	<% 
		ParagraphDAO pDAO = ParagraphDAO.getInstance();
		List<ParagraphDTO> list = pDAO.paragraphList(1, 10);
	%>
		<jsp:include page="header.jsp"/>
		<div class ="paragraphListWrap">
			<h2 class="titleArea">최근 게시글</h2>
			<div class="spanWrap">
				<span>
					<span class="narrow th borderRight">번호</span>
					<span class="wideTitle th borderRight txt_line2">제목</span>
					<span class="narrow th borderRight">글쓴이</span>
					<span class="medium th borderRight">날짜</span>
					<span class="narrow th">조회수</span>
					<br>
				</span>
				<c:forEach items="<%=list %>" var="list">
					<span class="narrow borderRight">${list.getNum() }</span>
					<span class="wide borderRight">
						
					
						<c:set var="tag" value="${fn:split(list.getTag(),'★')}"></c:set>
							
						<c:choose>
							<c:when test="${list.getTag() == ''}">
								<div class="txt_line2">
						
									<a href="paragraphEachSelect.do?num=${list.getNum()}&&flag=0">[${list.getCategory()}]${list.getTitle()}
										
									</a>
									
								</div>
							</c:when>
							<c:when test="${fn:length(tag) <= 3}">
								<div class="txt_line">
						
									<a href="paragraphEachSelect.do?num=${list.getNum()}&&flag=0">[${list.getCategory()}]${list.getTitle()}
										
									</a>
									
								</div>
								<c:forEach items="${tag }" var="tags">
									<span class="tagColor">${tags }</span>
								</c:forEach>
							</c:when>
							<c:when test="${fn:length(tag) > 3}">
								<div class="txt_line">
						
									<a href="paragraphEachSelect.do?num=${list.getNum()}&&flag=0">[${list.getCategory()}]${list.getTitle()}
										
									</a>
									
								</div>
								<c:forEach begin="0" end="2" items="${tag }" var="tags">
									<span class="tagColor">${tags }</span>
								</c:forEach>
							</c:when>
						</c:choose>	
					</span>
					<span class="narrow borderRight">${list.getId()}</span>
					<span class="medium borderRight">${list.getDatetime()}</span>
					<span class="narrow">${list.getHits()}</span>		
				</c:forEach>
			</div>
			
			<input class="writebutton blackSmallButton" type="button" value="더보기" onclick="location.href='paragraphList.do?startPage=1';">
			
		</div>

	<jsp:include page="./footer.jsp"/>

	</body>
</html>