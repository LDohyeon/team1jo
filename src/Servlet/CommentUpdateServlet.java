package Servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.CommentDAO;
import DAO.ParagraphDAO;
import DTO.CommentDTO;
import DTO.ParagraphDTO;

@WebServlet("/commentUpdate.do")
public class CommentUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int num=Integer.parseInt(request.getParameter("num"));
		//System.out.println("::::::수정버튼 클릭 시 이동확인:::::::");
		CommentDAO cDAO = CommentDAO.getInstance();
		CommentDTO cDTO = cDAO.CommentContents(num);
		System.out.println();
		request.setAttribute("comment", cDTO);
		request.setAttribute("flag", "u");
		request.setAttribute("num", num);
		//System.out.println(cDTO.getParagraph_num());
		RequestDispatcher dispatcher=request.getRequestDispatcher("paragraphEachSelect.do?num="+cDTO.getParagraph_num());
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String comment=request.getParameter("comment");
		int num = Integer.parseInt(request.getParameter("num"));
		
		CommentDAO cDAO=CommentDAO.getInstance();
		CommentDTO commentDTO = cDAO.CommentContents(num);
		
		CommentDTO cDTO=new CommentDTO();
		cDTO.setComment(comment);
		cDTO.setNum(num);
		
		cDAO.commentUpdate(cDTO);

		
		response.sendRedirect("paragraphEachSelect.do?num="+commentDTO.getParagraph_num());
	}

}
