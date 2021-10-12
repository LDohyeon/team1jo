<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="DAO.MemberDAO" %>
<%@ page import="DTO.MemberDTO" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
   
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>회원 리스트 페이지</title>
      <link rel="stylesheet" href="style.css">
   </head>
   <body>
      <%
         List<MemberDTO> list = (List<MemberDTO>)request.getAttribute("memberList");
      %>
         
      <div class="wrap1">
         <div class="wrap2">
            <h1>회원 리스트</h1>
            <div>
	            <form method="post" action="memberList.do">
	               <select name="sel_serch">
	                  <option value="">==선택==</option>
	                  <option value="id">아이디</option>
	                  <option value="name">이름</option>
	               </select>
	               <input type="text" name="serch">
	               <input type="submit" value="검색">
	            </form>
	         </div>
            <table class="memberList">
               <tr>
                  <td>번호</td>
                  <td>아이디</td>
                  <td>이름</td>
                  <td>이메일</td>
                  <td>권한</td>
               </tr>
               <%
                  try{            
                     for(int i=0; i<list.size(); i++){               
               %>         
                        <tr>
                           <td><%=list.get(i).getNum() %></td>
                           <td><%=list.get(i).getId() %></td>
                           <td><%=list.get(i).getName() %></td>
                           <td><%=list.get(i).getEmail() %></td>
                           <td><%=list.get(i).getAuthority() %></td>
                        </tr>         
               <% 
                     }
                  } catch(Exception e) {
                     System.out.println("member 리스트 조회 오류 발생 : " + e);
                  } 
               %>               
            </table>
         </div>
      </div>
   </body>
</html>