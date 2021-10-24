package Servlet;

import java.io.*;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;



@WebServlet("/code.do")
public class CodeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int flag= Integer.parseInt(request.getParameter("flag"));
		String language=null;
		
		String write=null;//수정때 불러올 글자
		
		if(flag == 0)
		{
			language = request.getParameter("language");

		}
		else if(flag ==1)
		{
			String drag = request.getParameter("drag");
			
			System.out.println("drag : "+ drag);
			
			String[] drags=drag.split("※");

			for(int i=0; i<drags.length; i++)
			{
				if(i==1)
				{
					language=drags[i];
				}
				if(i==2)
				{
					write=drags[i];
					request.setAttribute("write", write);
				}
			}
			
		}
		
		request.setAttribute("flag", flag);
		request.setAttribute("language", language);

		RequestDispatcher dispatcher=request.getRequestDispatcher("code.jsp");
		dispatcher.forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
