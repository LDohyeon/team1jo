package ServletMember;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import DAO.ParagraphDAO;
import DTO.ParagraphDTO;

@WebServlet("/myWrite.do")
public class MyWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int StartPage=Integer.parseInt(request.getParameter("startPage"));
		
		int lastPage=20;
		
		ParagraphDAO pDAO=ParagraphDAO.getInstance();
		
		HttpSession session = request.getSession();
		String id=(String)session.getAttribute("loginUserId");
		
		int page=pDAO.ParagraphPage(id);
		
		List<ParagraphDTO> list = pDAO.paragraphList(id, StartPage, lastPage);
		
		request.setAttribute("list", list);
		
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
		request.setAttribute("StartPage", StartPage);
		request.setAttribute("searchFlag", 0);

		
		RequestDispatcher dispatcher= request.getRequestDispatcher("myWriteList.jsp");
		dispatcher.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
