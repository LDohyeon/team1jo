package Servlet;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import DAO.MemberDAO;
import DTO.MemberDTO;


@WebServlet("/login.do")
public class LoginServelt extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		RequestDispatcher dispatcher= request.getRequestDispatcher("login.jsp");
		dispatcher.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String url="index.jsp";

		request.setCharacterEncoding("utf-8");
		
		String id = request.getParameter("id");
		
		String pw = request.getParameter("pw");
		
		MemberDAO mDAO = MemberDAO.getInstance();
		
		MemberDTO mDTO = mDAO.loginMember(id, pw);
		
		if(mDTO == null)
		{
			// 로그인 실패시			url="login.jsp"; 
			request.setAttribute("loginMsg", "아이디 또는 비밀번호가 일치하지 않습니다");
		}
		else
		{	
			// 로그인 성공시
			HttpSession session= request.getSession();
			session.setAttribute("loginUser", mDTO); 
			session.setAttribute("loginUserId", mDTO.getId());
			session.setAttribute("Authority", mDTO.getAuthority());
			
			//권한 가져오기
			String auth=mDTO.getAuthority();
			//권한이 4이면 정지날짜 가져와서 현재날짜와 비교하기
			if(auth.equals("4"))
			{
				try
				{
		            //현재 날짜 가져오기
		            Date today=new Date();
		            //System.out.println(today);
		            //정지 날짜 가져와서 date형식에 맞게 변경하기
		            SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		            String susLastDay_dao=mDAO.getSusLastDay(id);
		            String susLastDay_s=susLastDay_dao+" 23:59:59";
		            Date susLastDay=dateFormat.parse(susLastDay_s);
		            //System.out.println(susLastDay);
		            //현재 날짜와 정지 날짜 비교하기
		            if(today.after(susLastDay))
		            {
		                //System.out.println("정지날짜가 지났다.");
		                //권한 2로 바꿔주기
		                auth="2";
		                mDAO.memberListAuthorityUpdate(id,auth);
		                //권한 수정된 것 세션에 반영하기
		                MemberDTO mUpdate=mDAO.loginMember(id, mDTO.getPw());
		        		session.setAttribute("loginUser", mUpdate);
		            }
		            else
		            {
		            	//아직 정지날짜가 지나지 않았다면, 권한 4 유지
		            	//댓글 쓰기, 글 쓰기 기능 막기

		            	String alertt="정지 날짜("+susLastDay_dao+") 자정까지 글쓰기가 제한됩니다.";
		    			session.setAttribute("loginMsg",alertt);
		            }
		        }
				catch (Exception e)
				{
					System.out.println("날짜 포맷 변경 중 오류 "+e);
		        }
			}
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);
	}
}







