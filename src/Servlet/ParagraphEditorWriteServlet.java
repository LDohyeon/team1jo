package Servlet;

import java.io.*;
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
		
		HttpSession session = request.getSession();
		
		MemberDTO mDTO = (MemberDTO)session.getAttribute("loginUser");
		
		ParagraphDTO pDTO = new ParagraphDTO();
		
		pDTO.setId(mDTO.getId());
		pDTO.setName(mDTO.getName());
		pDTO.setTitle(title);
		pDTO.setContents(content);
		pDTO.setCategory(category);

		ParagraphDAO pDAO = ParagraphDAO.getInstance();
		
		pDAO.paragraphInsert(pDTO);
		

		response.sendRedirect("paragraphEditorWrite.do");
		
		
	}

}

















