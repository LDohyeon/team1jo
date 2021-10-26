package Servlet;

import java.io.*;
import java.util.Map;
import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import DAO.ParagraphDAO;
import DTO.MemberDTO;
import DTO.ParagraphDTO;


@WebServlet("/paragraphEditorWrite.do")
public class ParagraphEditorWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		RequestDispatcher dispatcher= request.getRequestDispatcher("editor.jsp");
		dispatcher.forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		String category = "질문";
		String language="";
		
		
		
		String[] contents=content.split("※");
		Map<String, String> map = new HashMap<String, String>();

		for(int i=0; i<contents.length; i++)
		{
			if(i%3==1)
			{
				if(contents[i].equals("text/xml"))
				{
					map.put("text/xml", "html/xml");
				}
				if(contents[i].equals("text/x-java"))
				{
					map.put("text/x-java", "java");
				}
				if(contents[i].equals("text/x-python"))
				{
					map.put("text/x-python", "python");
				}
				if(contents[i].equals("text/x-sql"))
				{
					map.put("text/x-sql", "sql");
				}
				if(contents[i].equals("text/javascript"))
				{
					map.put("text/javascript", "javascript");
				}
			}	
		}
		
		Iterator<String> it = map.keySet().iterator();
		
		while(it.hasNext())
		{
			String key = it.next();
			String value = map.get(key);
			
			language +="#"+value+"★";
		}
		
		HttpSession session = request.getSession();
		
		MemberDTO mDTO = (MemberDTO)session.getAttribute("loginUser");
		
		ParagraphDTO pDTO = new ParagraphDTO();
		
		pDTO.setId(mDTO.getId());
		pDTO.setName(mDTO.getName());
		pDTO.setTitle(title);
		pDTO.setContents(content);
		pDTO.setCategory(category);
		pDTO.setTag(language);

		ParagraphDAO pDAO = ParagraphDAO.getInstance();
		
		pDAO.paragraphInsert(pDTO);
		

		response.sendRedirect("paragraphList.do?startPage=1");
		
		
	}

}

















