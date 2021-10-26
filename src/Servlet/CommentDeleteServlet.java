package Servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.CommentDAO;
import DAO.ParagraphDAO;

@WebServlet("/commentDelete.do")
public class CommentDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int num=Integer.parseInt(request.getParameter("num"));
		int paragraphNum=Integer.parseInt(request.getParameter("paragraph_num"));

		
		CommentDAO cDAO=CommentDAO.getInstance();
		cDAO.commentDelete(num);
		
		

		response.sendRedirect("paragraphEachSelect.do?num="+paragraphNum);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}