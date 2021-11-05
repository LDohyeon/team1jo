package Servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.CommentDAO;
import DAO.ParagraphDAO;
import DTO.CommentDTO;
import DTO.MemberDTO;
import DTO.ParagraphDTO;


@WebServlet("/comment.do")
public class CommentInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		
		String id = (String)session.getAttribute("loginUserId");
		
		String comment=request.getParameter("content");
		
		
		int paragraph_num = Integer.parseInt(request.getParameter("paragraph_num"));

		CommentDTO cDTO = new CommentDTO();
		
		cDTO.setId(id);
		cDTO.setParagraph_num(paragraph_num);
		cDTO.setComment(comment);
		
		CommentDAO cDAO = CommentDAO.getInstance();
		
		cDAO.insertComment(cDTO);
		
		
		

		response.sendRedirect("paragraphEachSelect.do?num="+paragraph_num+"&&flag=2");
	

	}

}









