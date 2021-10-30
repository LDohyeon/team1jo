package Servlet;

import java.io.*;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import com.oreilly.servlet.*;
import com.oreilly.servlet.multipart.*;


@WebServlet("/paragraphImageInsert.do")
public class ParagraphImageInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		ServletContext context = getServletContext();
		String path=context.getRealPath("/editor");
		System.out.println(path);
		String encType="utf-8";
		int sizeLimit=20*1024*1024;
		
		
		MultipartRequest multi = new MultipartRequest(request, path, sizeLimit, encType, new DefaultFileRenamePolicy());
		String imgContent = multi.getParameter("imgContent");
		String imgInput = multi.getFilesystemName("imgInput");
		String imgTitle= multi.getParameter("imgTitle");
		
		String[] imgContents=imgContent.split("★");
		
		imgContents[0]+="./editor/"+imgInput;
		
		String imgContentsHap="";
		for(int i=0; i<imgContents.length; i++)
		{
			imgContentsHap+=imgContents[i];
		}

		request.setAttribute("imageInsertContent", imgContentsHap);
		request.setAttribute("imgTitle", imgTitle);
		
		RequestDispatcher dispatcher= request.getRequestDispatcher("editor.jsp");
		dispatcher.forward(request, response);
		
		
		
		
	}
}












