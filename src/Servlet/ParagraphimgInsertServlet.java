package Servlet;

import java.io.*;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import com.oreilly.servlet.*;
import com.oreilly.servlet.multipart.*;



@WebServlet("/paragraphimgInsert.do")
public class ParagraphimgInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");//한글을 던질 거라서
		
		response.setContentType("multipart/form-data");	
		
		System.out.println(1);
		ServletContext context = getServletContext();
		
		System.out.println(1);
		String path=context.getRealPath("/files");
		System.out.println(1);
		
		System.out.println(path);
		System.out.println(1);
		
		String encType="utf-8";
		System.out.println(1);
		int sizeLimit=20*1024*1024;
		
		System.out.println(1);
		MultipartRequest multi = new MultipartRequest(request, path, sizeLimit, encType, new DefaultFileRenamePolicy());
		System.out.println(2);
		
		
		
	}

}
