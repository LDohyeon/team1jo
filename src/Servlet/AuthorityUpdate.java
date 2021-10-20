package Servlet;

import java.io.*;
import java.util.*;
import java.util.Calendar;
import java.time.LocalDate;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import DAO.MemberDAO;
import DTO.MemberDTO;

@WebServlet("/AuthorityUpdate.do")
public class AuthorityUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	//윤달 계산 함수
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
	
	protected void getYear()
	{
		int thisYearLean=0;
		while(susLastDay>0)
		{
			thisYearLean=isLean(thisYear);
			System.out.println("getYear에서 윤달 확인 "+thisYearLean);
			if(thisYearLean==1)
			{
				if(susLastDay>366)
				{
					susLastDay=susLastDay-366;
					System.out.println("getYear에서 366일 빼줌 "+susLastDay);
					thisYear++;
					System.out.println("getYear에서 연도를 ++ 해줌 "+thisYear);
				}
				else
				{
					break;
				}
			}
			else
			{
				if(susLastDay>365)
				{
					susLastDay=susLastDay-365;
					System.out.println("getYear에서 365일 빼줌 "+susLastDay);
					thisYear++;
					System.out.println("getYear에서 연도를 ++ 해줌 "+thisYear);
				}
				else
				{
					break;
				}
			}
		}
	}
	
	//월을 계산해주기 ::
	// 윤년이 이면, months = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
	// 윤년이 아니면, months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
	//for문을 돌려서 날짜수와 비교 => 날짜수보다 작으면 그 index+1가 month다.
	protected void getDate(int thisYearLean)
	{
		if(thisYearLean==1)
		{
			int[] months= {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
			for(int i=0;i<12;i++)
			{
				if(susLastDay>months[i])
				{
					susLastDay=susLastDay-months[i];
					System.out.println("getDate에서 "+i+", "+months[i]+" 빼줌 "+susLastDay);
					continue;
				}
				else
				{
					month=i+1;
					System.out.println("월 계산 "+month);
					break;
				}
			}
		}
		else
		{
			int[] months= {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
			for(int i=0;i<12;i++)
			{
				if(susLastDay>months[i])
				{
					susLastDay=susLastDay-months[i];
					System.out.println("getDate에서 "+i+", "+months[i]+" 빼줌 "+susLastDay);
					continue;
				}
				else
				{
					month=i+1;
					System.out.println("월 계산 "+month);
					break;
				}
			}
		}
	}
	
	//date 포맷으로 string 값 바꾸기 :: month
	protected String getFormMonth(int month)
	{
		String month_s=null;
		if(month<10)
		{
			month_s="0"+month;
		}
		else if(month>=10&&month<13)
		{
			month_s=month+"";
		}
		return month_s;
	}
	
	//date 포맷으로 string 값 바꾸기 :: day
	protected String getFormDay(int day)
	{
		String day_s=null;
		if(day<10)
		{
			day_s="0"+day;
		}
		else
		{
			day_s=day+"";
		}
		return day_s;
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	int month=0;
	int susLastDay=0;
	int thisYear=0;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		//권한
		String selAuValue = request.getParameter("selAuValue");
		//아이디
		String selAuIdValue = request.getParameter("selAuIdValue");	
		//일수
		int selAuDay = Integer.parseInt(request.getParameter("selAuDay"));
		
		MemberDAO mDAO= MemberDAO.getInstance();
		//권한 바꿔주는 함수
		mDAO.memberListAuthorityUpdate(selAuIdValue,selAuValue);
		
		// 방법 1
		//기본세팅
		Calendar calendar=Calendar.getInstance();
		int thisYearLean=0;
		//오늘 날짜와 올해 연도 받아오기
		thisYear=calendar.get(Calendar.YEAR);
		int today=calendar.get(Calendar.DAY_OF_YEAR);
		//오늘 날짜에서 정지일수 더하기
		susLastDay=today+selAuDay;
		//올해에 정지가 풀리나? 아니면 다른 해에 정지가 풀리나?
		//올해가 윤년이면 366일로 나눠주고, 올해가 윤년이 아니면 365일로 나눠주기
		//나눴을 때 몫이 0이 아니라면 다른 해에 정지가 풀린다.
		thisYearLean=isLean(thisYear);
		if(thisYearLean==1)
		{
			System.out.println("올해는 윤년 "+thisYearLean);
			System.out.println("올해 연도 "+thisYear);
			System.out.println("정지 끝나는 날 "+susLastDay);
			if((susLastDay/366)>0)
			{
				//몫이 0이 아니라면 무조건 몫은 1 이상이다.
				//따라서 366일을 빼주고 올해 연도에 ++를 해주면 다음 연도로 넘어간다.
				susLastDay=susLastDay-366;
				thisYear++;
				System.out.println("바로 다음 해 "+thisYear);
				System.out.println("정지 끝나는 날-366 "+susLastDay);
				//연도, 날짜 정재하기
				getYear();
				System.out.println("getYear 이후의 연도 "+thisYear);
				System.out.println("getYear 이후의 정지 끝나는 날 "+susLastDay);
			}
			System.out.println("최종 연도 "+thisYear);
			thisYearLean=isLean(thisYear);
			getDate(thisYearLean);
			System.out.println("최종 연도 윤달 여부 "+thisYearLean);
			System.out.println("최종 날짜 "+thisYear+", "+month+", "+susLastDay);
		}
		else
		{
			//만약 몫이 1이라면 올해 연도에서 1을 더해주기
			System.out.println("올해는 평년 "+thisYearLean);
			System.out.println("올해 연도 "+thisYear);
			System.out.println("정지 끝나는 날 "+susLastDay);
			if((susLastDay/365)>0)
			{
				susLastDay=susLastDay-365;
				thisYear++;
				System.out.println("바로 다음 해 "+thisYear);
				System.out.println("정지 끝나는 날-365 "+susLastDay);
				//연도, 날짜 정재하기
				getYear();
				System.out.println("getYear 이후의 연도 "+thisYear);
				System.out.println("getYear 이후의 정지 끝나는 날 "+susLastDay);
			}
			System.out.println("최종 연도 "+thisYear);
			thisYearLean=isLean(thisYear);
			getDate(thisYearLean);
			System.out.println("최종 연도 윤달 여부 "+thisYearLean);
			System.out.println("최종 날짜 "+thisYear+", "+month+", "+susLastDay);
		}
		
		//날짜 예쁜 포맷으로 바꿔주기
		String month_s=getFormMonth(month);
		String day_s=getFormDay(susLastDay);
		String date=thisYear+"-"+month_s+"-"+day_s;
		System.out.println(date);
		
		//id 가져오기
		request.setCharacterEncoding("utf-8");
		String authority=request.getParameter("authority");
		String id=request.getParameter("id");
		//쿼리문으로 던지기
		//mDAO.updateSuspension(authority,date,id);
		
		/*
		// 방법 2
		LocalDate now = LocalDate.now();
		String plus90=now.plusDays(90).toString();
		
		System.out.println(mDAO+", "+id+", "+now+", "+plus90+", "+startPage);
		
		mDAO.updateSuspension(, plus90, id);
		*/
		
		//String startPage=request.getParameter("startPage");
		//response.sendRedirect("memberList.do?startPage="+startPage);

		/*
		/////////////////쿼리문 작성///////////////////
		public void updateSuspension(String authority,String date, String id)
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
		
		//팝업으로 돌아가기
		String val = "T";
		request.setAttribute("val", val);		
		RequestDispatcher dispatcher= request.getRequestDispatcher("auUpdatePopUp.jsp");
		dispatcher.forward(request, response);	
	}
}