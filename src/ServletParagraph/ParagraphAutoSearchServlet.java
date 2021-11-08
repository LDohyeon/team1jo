package ServletParagraph;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import org.json.simple.*;

import DAO.ParagraphDAO;



@WebServlet("/paragraphAutoSearch.do")
public class ParagraphAutoSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		String searchAuto = request.getParameter("searchAuto");
		
		System.out.println("searchAuto : "+ searchAuto);

		
		ParagraphDAO pDAO = ParagraphDAO.getInstance();
		
		List<String> list = pDAO.searchAutoParagraph(searchAuto);
		
		
		JSONArray jsonArr = new JSONArray();
		
		if(list.size()>0)
		{
			for(int i=0; i<list.size(); i++)
			{
				JSONObject jsonobj = new JSONObject();
				
				jsonobj.put("auto", list.get(i));
				
				jsonArr.add(jsonobj);
			}
		}
		
		response.setContentType("application/json");
		
		PrintWriter out = response.getWriter();
		out.print(jsonArr.toString());
		out.flush();
		
		
		
	}

}








