<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="utf-8">
		<title>게시판 내용 보기</title>
	</head>
	<body>
		${pDTO.getId() }
		${pDTO.getNum() }
		${pDTO.getName() }
		${pDTO.getDatetime() }
		${pDTO.getCategory() }
		${pDTO.getContents() }
		${pDTO.getTitle() }
		${pDTO.getHits() }
	</body>
</html>