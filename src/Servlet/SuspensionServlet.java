package Servlet;

import java.io.*;
import javax.servlet.*;
import java.util.Calendar;
import java.time.LocalDate;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

import DAO.MemberDAO;

@WebServlet("/suspension.do")
public class SuspensionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected int isLean(int thisYear)
	{
		int lean;
		
		if((thisYear%4==0&&thisYear%100!=0)||thisYear%400==0)
		{
			lean=1;
			return lean;
		}
		else
		{
			lean=0;
			return lean;
		}
	}
	
	//월을 계산해주기 ::
	// 윤년이 이면, months = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
	// 윤년이 아니면, months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
	//for문을 돌려서 날짜수와 비교 => 날짜수보다 작으면 그 index+1가 month다.
	protected int getMonth(int thisYearLean, int susLastDay)
	{
		int month=0;
		
		if(thisYearLean==1)
		{
			int[] months= {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
			for(int i=0;i<12;i++)
			{
				if(susLastDay>months[i])
				{
					susLastDay=susLastDay-months[i];
					continue;
				}
				else
				{
					month=i+1;
					break;
				}
			}
			return month;
		}
		else
		{
			int[] months= {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
			for(int i=0;i<12;i++)
			{
				if(susLastDay>months[i])
				{
					susLastDay=susLastDay-months[i];
					continue;
				}
				else
				{
					month=i+1;
					break;
				}
			}
			return month;
		}
	}
	
	protected int getDay(int thisYearLean, int susLastDay)
	{
		int day=0;
		
		if(thisYearLean==1)
		{
			int[] months={31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
			for(int i=0;i<12;i++)
			{
				if(susLastDay>months[i])
				{
					susLastDay=susLastDay-months[i];
					continue;
				}
				else
				{
					day=susLastDay;
					break;
				}
			}
		}
		else
		{
			int[] months={31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
			for(int i=0;i<12;i++)
			{
				if(susLastDay>months[i])
				{
					susLastDay=susLastDay-months[i];
					continue;
				}
				else
				{
					day=susLastDay;
					break;
				}
			}
		}
		return day;
	}
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 방법 1
		//기본세팅
		Calendar calendar=Calendar.getInstance();
		int month=0;
		int day=0;
		//오늘 날짜와 올해 연도 받아오기
		int thisYear=calendar.get(Calendar.YEAR);
		int today=calendar.get(Calendar.DAY_OF_YEAR);
		//오늘 날짜에서 90일 더하기
		int susLastDay=today+90;
		//윤년 계산해서 올해 연도와 비교하기
		//윤년 :: 1, 평년 :: 0
		int thisYearLean=isLean(thisYear);
		//올해가 윤년이면 366일로 나눠주고, 올해가 윤년이 아니면 365일로 나눠주기
		if(thisYearLean==1)
		{
			//만약 몫이 1이라면 올해 연도에서 1을 더해주기
			if(susLastDay/366==1)
			{
				thisYear++;
				susLastDay=susLastDay-366;
				//다음해 윤년인지 평년인지 계산
				thisYearLean=isLean(thisYear);
			}
			month=getMonth(thisYearLean,susLastDay);
			day=getDay(thisYearLean,susLastDay);
		}
		else
		{
			//만약 몫이 1이라면 올해 연도에서 1을 더해주기
			if(susLastDay/365==1)
			{
				thisYear++;
				susLastDay=susLastDay-365;
				//다음해 윤년인지 평년인지 계산
				thisYearLean=isLean(thisYear);
			}
			month=getMonth(thisYearLean,susLastDay);
			day=getDay(thisYearLean,susLastDay);
		}	
		//날짜 예쁜 포맷으로 바꿔주기
		System.out.println(thisYear+"-"+month+"-"+day);
		
		//DB에 넣을 준비
		MemberDAO mDAO=MemberDAO.getInstance();
		//id 가져오기
		request.setCharacterEncoding("utf-8");
		String startPage=request.getParameter("startPage");
		startPage="1";
		String authority=request.getParameter("authority");
		String id=request.getParameter("id");
		
		//mDAO.updateSuspension(authority,susLastDay, id);
		
		/*
		// 방법 2
		LocalDate now = LocalDate.now();
		String plus90=now.plusDays(90).toString();
		
		System.out.println(mDAO+", "+id+", "+now+", "+plus90+", "+startPage);
		
		mDAO.updateSuspension(, plus90, id);
		*/
		
		response.sendRedirect("memberList.do?startPage="+startPage);

		/*
		/////////////////쿼리문 작성///////////////////
		public void updateSuspension(String authority,String plus90, String id)
		{
			String sql="update Member set authority=? date=? where id=?";
			Connection conn=null;
			PreparedStatement pstmt = null;
		
			try
			{
				conn=getConnection();
				pstmt=conn.prepareStatement(sql);
				
				pstmt.setString(1, authority);
				pstmt.setString(2, date);
				pstmt.setString(3, id);
				
				pstmt.executeUpdate();
			}
			catch(Exception e)
			{
				System.out.println("회원 정지 날짜 세팅 실패"+e);
			}
			finally
			{
				close(conn, pstmt);
			}
		}
		*/
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
