package Servlet;

import java.io.*;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import DTO.CommentDTO;

@WebServlet("/commentInsertImage.do")
public class CommentInsertImageServlet extends HttpServlet {
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
		int num= Integer.parseInt(multi.getParameter("num"));
		String commentNum= multi.getParameter("commentNum");
		
		
		String[] imgContents=imgContent.split("★");
		
		imgContents[0]+="./editor/"+imgInput;
		
		String imgContentsHap="";
		for(int i=0; i<imgContents.length; i++)
		{
			imgContentsHap+=imgContents[i];
		}

		HttpSession session = request.getSession();
		session.setAttribute("imageInsertContent", imgContentsHap);
		session.setAttribute("commentNum", commentNum);
		
		
		response.sendRedirect("paragraphEachSelect.do?num="+num+"&&flag=3");

		
		
		

	}

}
