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
			if(thisYearLean==1)
			{
				if(susLastDay>366)
				{
					susLastDay=susLastDay-366;
					thisYear++;
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
					thisYear++;
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
					continue;
				}
				else
				{
					month=i+1;
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
					continue;
				}
				else
				{
					month=i+1;
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
		//기본 세팅
		MemberDAO mDAO= MemberDAO.getInstance();
		String selAuValue = request.getParameter("selAuValue");//권한
		String selAuIdValue = request.getParameter("selAuIdValue");//아이디
		int selAuDay = Integer.parseInt(request.getParameter("selAuDay"));//일수
		//권한 바꿔주는 함수 실행
		mDAO.memberListAuthorityUpdate(selAuIdValue,selAuValue);
		//권한이 4면 회원정지 함수 실행
		if(selAuValue.equals("4"))
		{
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
				if((susLastDay/366)>0)
				{
					//몫이 0이 아니라면 무조건 몫은 1 이상이다.
					//따라서 366일을 빼주고 올해 연도에 ++를 해주면 다음 연도로 넘어간다.
					susLastDay=susLastDay-366;
					thisYear++;
					//연도, 날짜 정재하기
					getYear();
				}
				thisYearLean=isLean(thisYear);
				getDate(thisYearLean);
			}
			else
			{
				//만약 몫이 1이라면 올해 연도에서 1을 더해주기
				if((susLastDay/365)>0)
				{
					susLastDay=susLastDay-365;
					thisYear++;
					//연도, 날짜 정재하기
					getYear();
				}
				thisYearLean=isLean(thisYear);
				getDate(thisYearLean);
			}
			
			//날짜 예쁜 포맷으로 바꿔주기
			String month_s=getFormMonth(month);
			String day_s=getFormDay(susLastDay);
			String date=thisYear+"-"+month_s+"-"+day_s;
			System.out.println(date);
			
			//쿼리문으로 던지기
			mDAO.updateSuspension(date, selAuIdValue);
		}
		
		//팝업으로 돌아가기
		String val = "T";
		request.setAttribute("val", val);		
		RequestDispatcher dispatcher= request.getRequestDispatcher("auUpdatePopUp.jsp");
		dispatcher.forward(request, response);
		
		/*
		// 방법 2
		LocalDate now = LocalDate.now();
		String plus90=now.plusDays(90).toString();
		
		System.out.println(mDAO+", "+id+", "+now+", "+plus90+", "+startPage);
		
		mDAO.updateSuspension(, plus90, id);
		*/
	}
}