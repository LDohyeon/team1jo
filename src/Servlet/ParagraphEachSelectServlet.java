package Servlet;

import java.io.*;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import DAO.ParagraphDAO;
import DTO.ParagraphDTO;

@WebServlet("/paragraphEachSelect.do")
public class ParagraphEachSelectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int num = Integer.parseInt(request.getParameter("num"));
		
		String code="";//전체 글
		String language = "";//선택된 언어
		String lang="";//id 할당
		String langValue="";//아이디 할당한 걸 jsp로 보내기
				
		ParagraphDAO pDAO = ParagraphDAO.getInstance();
		
		pDAO.paragraphHitsUp(num);
		
		ParagraphDTO pDTO = pDAO.ParagraphContents(num);
		
		String content= pDTO.getContents();
		
		String[] contents=content.split("※");
		
		for(int i=0; i<contents.length; i++)
		{
			System.out.println("contents : "+ contents[i]+", i= "+i);
			System.out.println();
			

			
			if(i%3==0)
			{
				code+=contents[i];
			}
			if(i%3==1)
			{
				language +=contents[i]+",";
				lang=contents[i]+i;
				langValue+=lang+",";
			}
			if(i%3==2)
			{
				code+="<textarea id="+lang+">";
				code+=contents[i];
				code+="</textarea>";
			}
		}
		
		pDTO.setContents(code);
		
		request.setAttribute("pDTO", pDTO);
		request.setAttribute("language", language);
		request.setAttribute("langValue", langValue);

		RequestDispatcher dispatcher = request.getRequestDispatcher("paragraphEachSelect.jsp");
		dispatcher.forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
