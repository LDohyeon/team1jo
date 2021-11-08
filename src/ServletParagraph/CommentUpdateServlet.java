package ServletParagraph;

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

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
				
		String commentContent=request.getParameter("commentContent");
		
		int num = Integer.parseInt(request.getParameter("num"));
		int commentNum = Integer.parseInt(request.getParameter("commentNum"));

		CommentDAO cDAO=CommentDAO.getInstance();

		CommentDTO cDTO=new CommentDTO();
		cDTO.setComment(commentContent);
		cDTO.setNum(commentNum);
		
		cDAO.commentUpdate(cDTO);

		
		response.sendRedirect("paragraphEachSelect.do?num="+num+"&&flag=0");
	}

}
