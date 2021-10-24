package Servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Date;

import DAO.MemberDAO;
import DTO.MemberDTO;

@WebServlet("/suspension.do")
public class SuspensionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//세션에서 아이디 가져오기
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("loginUserId");
		//세션에서 권한 가져와서 4인지 확인하기
		MemberDTO mDTO=null;
		mDTO=(MemberDTO)session.getAttribute("loginUser");
		String auth=mDTO.getAuthority();
		//권한이 4이면 정지날짜 가져와서 현재날짜와 비교하기
		if(auth.equals("4"))
		{
			try
			{
	            //현재 날짜 가져오기
	            Date today=new Date();
	            System.out.println(today);
	            //정지 날짜 가져와서 date형식에 맞게 변경하기
	            SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	            MemberDAO mDAO=MemberDAO.getInstance();
	            String susLastDay_dao=mDAO.getSusLastDay(id);
	            String susLastDay_s=susLastDay_dao+" 23:59:59";
	            Date susLastDay=dateFormat.parse(susLastDay_s);
	            System.out.println(susLastDay);
	            //현재 날짜와 정지 날짜 비교하기
	            if(today.after(susLastDay))
	            {
	                System.out.println("정지날짜가 지났다.");
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
	            	System.out.println("아직 정지날짜가 지나지 않았다.");
	            }
	        }
			catch (Exception e)
			{
				System.out.println("날짜 포맷 변경 중 오류 "+e);
	        }
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
