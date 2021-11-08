<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
	<html lang="ko">
	<head>
		<meta charset="utf-8">
		<title>게시판</title>
		<link rel="stylesheet" href="style.css">
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		<link rel="stylesheet" href="style.css">
		<style>
			*
			{
				margin: 0;
				padding: 0;
			}
			
			.titleArea
			{
				margin: 0 0 10px 0;
			}
			
			.paragraphListWrap
			{
				width: 850px;
				padding: 35px;
				border : 1px solid #dbdadf;
				margin : 60px auto;		
			}
			
			.button
			{
				background-color: #064998;
				color: #fff;
				text-align: center;
				font-size: 14px;
				
				margin: 0;
				width: 60px;
				height: 42px;
				line-height: 42px;
				display: inline-block;
			}
			
			.nonInputSub
			{
				padding: 0;
			    border-width: 0;
			    border-style: none;
			    border-color: #fff;
			    font-family: inherit;
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
				text-align: center;
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
			
			.pageNum
			{
				text-align: center;
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
			.titleLength
			{
				/*display:inline-block;*/
				width:50px;
			    overflow:hidden;
			    text-overflow:ellipsis;
			    /*white-space:nowrap;*/
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
		 	span
		 	{
		 		padding:0;
		 	}
		</style>
	</head>
	<jsp:include page="./header.jsp"/>
	<body>
		<div class ="paragraphListWrap">
			<h2 class="titleArea">게시판</h2>
			<div class="spanWrap">
				<span>
					<span class="narrow th borderRight">번호</span>
					<span class="wideTitle th borderRight txt_line2">제목</span>
					<span class="narrow th borderRight">글쓴이</span>
					<span class="medium th borderRight">날짜</span>
					<span class="narrow th">조회수</span>
				</span>
				<c:forEach items="${list }" var="list">
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
							<c:when test="${fn:length(tag) <= 3 && fn:length(tag) > 0}">
								<div class="txt_line">
									<a href="paragraphEachSelect.do?num=${list.getNum()}&&flag=0">[${list.getCategory()}]${list.getTitle()}
										
									</a>
								</div>
								<c:forEach items="${tag }" var="tags">
									<span class="tagColor"><a onclick="getTag(this)" href="#">${tags }</a></span>
								</c:forEach>
							</c:when>
							<c:when test="${fn:length(tag) > 3}">
								<div class="txt_line">
									<a href="paragraphEachSelect.do?num=${list.getNum()}&&flag=0">[${list.getCategory()}]${list.getTitle()}
										
									</a>
								</div>
								<c:forEach begin="0" end="2" items="${tag }" var="tags">
									<span class="tagColor"><a onclick="getTag(this)" href="#">${tags }</a></span>
								</c:forEach>
							</c:when>
						</c:choose>		
					</span>
					<span class="narrow borderRight">${list.getId()}</span>
					<span class="medium borderRight">${list.getDatetime()}</span>
					<span class="narrow">${list.getHits()}</span>
				</c:forEach>
			</div>
			<div class="pageNum">
				<c:choose>
					<c:when test="${StartPage==1 }">	
					</c:when>
					<c:when test="${StartPage -10 <= 0}">
						<c:if test="${searchFlag==0 }">
							<a href="paragraphList.do?startPage=1">&#60;&#60;</a>
						</c:if>
						<c:if test="${searchFlag==1 }">
							<a href="search.do?searchValue=${searchValue}&startPage=1">&#60;&#60;</a>
						</c:if>
					</c:when>
					<c:otherwise>
						<c:if test="${searchFlag==0 }">
							<a href="paragraphList.do?startPage=${StartPage - StartPage%10 -9 }">&#60;&#60;</a>
						</c:if>
						<c:if test="${searchFlag==1 }">
							<a href="search.do?searchValue=${searchValue}&startPage=${StartPage - StartPage%10 -9 }">&#60;&#60;</a>
						</c:if>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${StartPage == 1}">
					</c:when>
					<c:otherwise>
						<c:if test="${searchFlag==0 }">
							<a href="paragraphList.do?startPage=${StartPage-1 }">&#60;</a>
						</c:if>
						<c:if test="${searchFlag==1 }">
							<a href="search.do?searchValue=${searchValue}&startPage=${StartPage-1 }">&#60;</a>
						</c:if>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${pageBlock==1 && pageBlock+9 >= nOfPages}">
						<c:forEach begin="${pageBlock }" end="${nOfPages}" var="i">
							<c:choose>
								<c:when test="${StartPage eq i}">
									<a><strong>${i}</strong></a>
								</c:when>
								<c:otherwise>
									<c:if test="${searchFlag==0 }">
										<a href="paragraphList.do?startPage=${i}">${i}</a>
									</c:if>
									<c:if test="${searchFlag==1 }">
										<a href="search.do?searchValue=${searchValue}&startPage=${i}">${i}</a>
									</c:if>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:when>
					<c:when test="${pageBlock==1 && pageBlock+9 < nOfPages}">
						<c:forEach begin="${pageBlock }" end="${pageBlock+9}" var="i">
							<c:choose>
								<c:when test="${StartPage eq i}">
									<a><strong>${i}</strong></a>
								</c:when>
								<c:otherwise>
									<c:if test="${searchFlag==0 }">
										<a href="paragraphList.do?startPage=${i}">${i}</a>
									</c:if>
									<c:if test="${searchFlag==1 }">
										<a href="search.do?searchValue=${searchValue}&startPage=${i}">${i}</a>
									</c:if>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:when>
					<c:when test="${pageBlock>=2 && pageBlock*10 >= nOfPages}">
						<c:forEach begin="${pageBlock*10-9 }" end="${nOfPages}" var="i">
							<c:choose>
								<c:when test="${StartPage eq i}">
									<a><strong>${i}</strong></a>
								</c:when>
								<c:otherwise>
									<c:if test="${searchFlag==0 }">
										<a href="paragraphList.do?startPage=${i}">${i}</a>
									</c:if>
									<c:if test="${searchFlag==1 }">
										<a href="search.do?searchValue=${searchValue}&startPage=${i}">${i}</a>
									</c:if>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:when>
					<c:when test="${pageBlock>=2 && pageBlock*10 < nOfPages}">
						<c:forEach begin="${pageBlock*10-9 }" end="${pageBlock*10}" var="i">
							<c:choose>
								<c:when test="${StartPage eq i}">
									<a><strong>${i}</strong></a>
								</c:when>
								<c:otherwise>
									<c:if test="${searchFlag==0 }">
										<a href="paragraphList.do?startPage=${i}">${i}</a>
									</c:if>
									<c:if test="${searchFlag==1 }">
										<a href="search.do?searchValue=${searchValue}&startPage=${i}">${i}</a>
									</c:if>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:when>
				</c:choose>
				<c:choose>
					<c:when test="${StartPage == nOfPages}">
					</c:when>
					<c:otherwise>
						<c:if test="${searchFlag==0 }">
							<a href="paragraphList.do?startPage=${StartPage+1 }">&#62;</a>
						</c:if>
						<c:if test="${searchFlag==1 }">
							<a href="search.do?searchValue=${searchValue}&startPage=${StartPage+1 }">&#62;</a>
						</c:if>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${StartPage==nOfPages }"></c:when>
					<c:when test="${StartPage +10 > nOfPages}">
						<c:if test="${searchFlag==0 }">
							<a href="paragraphList.do?startPage=${nOfPages }">&#62;&#62;</a>
						</c:if>
						<c:if test="${searchFlag==1 }">
							<a href="search.do?searchValue=${searchValue}&startPage=${nOfPages }">&#62;&#62;</a>
						</c:if>
					</c:when>
					<c:otherwise>
						<c:if test="${searchFlag==0 }">
							<a href="paragraphList.do?startPage=${StartPage - StartPage%10 +11 }">&#62;&#62;</a>
						</c:if>
						<c:if test="${searchFlag==1 }">
							<a href="search.do?searchValue=${searchValue}&startPage=${StartPage - StartPage%10 +11 }">&#62;&#62;</a>
						</c:if>
					</c:otherwise>
				</c:choose>
			</div>
			<c:choose>
				<c:when test="${loginUser.getAuthority()==4 }">
					<input class="blackSmallButton" type="button" value="글쓰기" onclick="alert('${loginMsg}')">
				</c:when>
				<c:when test="${loginUser.getId()==null }">
					
				</c:when>
				<c:otherwise>
					<input class="blackSmallButton" type="button" value="글쓰기" onclick="location.href='paragraphEditorWrite.do';">
				</c:otherwise>
			</c:choose>
		</div>
	</body>
	<script>
		function writeCheck(){
			if(document.frm.searchValue.value.length==0){
				alert("검색어를 입력해주세요.");
				frm.searchValue.focus();
				return false;
			}
		}
		
		function getTag(ths){
			var text=$(ths).text();
			location.href="search.do?searchValue="+text.replace('#','')+"&startPage=1";
		}
	</script>
	<jsp:include page="./footer.jsp"/>
</html>