package Servlet;

import java.io.*;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import DAO.CommentDAO;
import DAO.ParagraphDAO;
import DTO.CommentDTO;
import DTO.ParagraphDTO;

@WebServlet("/paragraphEachSelect.do")
public class ParagraphEachSelectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int num = Integer.parseInt(request.getParameter("num"));
		
		String code="";
		String language = "";
		String lang="";
		String langValue="";
				
		ParagraphDAO pDAO = ParagraphDAO.getInstance();
		
		pDAO.paragraphHitsUp(num);
		
		ParagraphDTO pDTO = pDAO.ParagraphContents(num);
		
		String content= pDTO.getContents();
		
		String[] contents=content.split("※");

		for(int i=0; i<contents.length; i++)
		{
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
		
		
		

		CommentDAO cDAO = CommentDAO.getInstance();
		
		List<CommentDTO> list = cDAO.commentList(num);
		

		
		request.setAttribute("list", list);

		
		
		
		request.setAttribute("pDTO", pDTO);
		request.setAttribute("language", language);
		request.setAttribute("langValue", langValue);

		RequestDispatcher dispatcher = request.getRequestDispatcher("paragraphEachSelect.jsp");
		dispatcher.forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
