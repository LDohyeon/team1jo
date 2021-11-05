package Servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.ParagraphDAO;
import DTO.ParagraphDTO;


@WebServlet("/search.do")
public class ParagraphSerchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int StartPage = Integer.parseInt(request.getParameter("startPage"));
		int lastPage = 20;		
		
		String searchValue = request.getParameter("searchValue");

		ParagraphDAO pDAO = ParagraphDAO.getInstance();
		
		int page = pDAO.searchPageBtnParagraph(searchValue);
		int nOfPages=page/lastPage;
		if(nOfPages%lastPage>=0) {
			nOfPages++;
		}
		
		int pageBlock = 0;
		if(StartPage%10==0) {
			pageBlock = (StartPage-StartPage%10)/10;
		}else {
			pageBlock = (StartPage-StartPage%10)/10+1;
		}
		
		request.setAttribute("pageBlock",pageBlock);
		request.setAttribute("nOfPages",nOfPages);
		System.out.println(nOfPages);
		request.setAttribute("StartPage", StartPage);
		request.setAttribute("searchValue", searchValue);
		
		List<ParagraphDTO> list = pDAO.searchParagraph(searchValue,StartPage,lastPage);
		request.setAttribute("list", list);
		
		request.setAttribute("searchFlag",1);

		RequestDispatcher dispatcher= request.getRequestDispatcher("paragraphList.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
