package Servlet;

import java.io.*;

import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import DAO.CommentDAO;
import DAO.ParagraphDAO;
import DTO.CommentDTO;
import DTO.ParagraphDTO;

@WebServlet("/paragraphEachSelect.do")
public class ParagraphEachSelectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		int flag= Integer.parseInt(request.getParameter("flag"));

		if(flag==0)
		{
			HttpSession session = request.getSession();
			session.setAttribute("imageInsertContent", "");
			//session에 남아있는 이미지와 글귀들 삭제
			//commentInsertImage 확인
			

		}
		else if(flag==1)
		{

			String focus = "1";
			request.setAttribute("focusdown", focus);

		}
		if(flag==2)//댓글 달면 밑으로 포거싱을 위해서
		{
			String focus = "1";
			request.setAttribute("focusdown", focus);
			
			HttpSession session = request.getSession();
			session.setAttribute("imageInsertContent", "");

		}

		
		int num = Integer.parseInt(request.getParameter("num"));
		
		String code="";
		String langId="";
		String languageMode = "";
		String languageModeId="";
				
		ParagraphDAO pDAO = ParagraphDAO.getInstance();
		
		pDAO.paragraphHitsUp(num);
		
		ParagraphDTO pDTO = pDAO.ParagraphContents(num);
		
		String content= pDTO.getContents();
		
		String[] contents=content.split("※");

		int idCount=0;
		
		for(int i=0; i<contents.length; i++)
		{
			if(i%3==0)
			{
				code+=contents[i];
			}
			if(i%3==1)
			{
				languageMode +=contents[i]+",";
				langId=contents[i]+idCount;
				languageModeId+=langId+",";
				idCount++;
			}
			if(i%3==2)
			{
				code+="<textarea id="+langId+">";
				code+=contents[i];
				code+="</textarea>";
			}
			
			
		}
		
		pDTO.setContents(code);
		
		
		

		CommentDAO cDAO = CommentDAO.getInstance();
		
		List<CommentDTO> clist = cDAO.commentList(num);
		
		List<CommentDTO> clistSelect= new ArrayList<CommentDTO>();
		

		//이게 clist 의 getComment()의 역할을 한다.
		//jsp에서 출력할 떄 clist getComment()로 댓글 내용을 출력하는 게 아니라
		//얘로 출력해야 한다.

		
		String commentCode="";


		for(int i=0; i<clist.size(); i++)
		{
			String[] commentContent = clist.get(i).getComment().split("※");
			
			for(int j=0; j<commentContent.length; j++)
			{	
				if(j%3==0)
				{
					commentCode+=commentContent[j];
				}
				if(j%3==1)
				{
					languageMode +=commentContent[j]+",";
					langId=commentContent[j]+idCount;
					languageModeId+=langId+",";
					idCount++;
				}
				if(j%3==2)
				{
					commentCode+="<textarea id="+langId+">";
					commentCode+=commentContent[j];
					commentCode+="</textarea>";
				}

			}
			CommentDTO cDTO = new CommentDTO();
			
			cDTO.setNum(clist.get(i).getNum());
			cDTO.setId(clist.get(i).getId());
			cDTO.setTime(clist.get(i).getTime());
			
			
			cDTO.setCommentCount(clist.get(i).getCommentCount());//댓글 순서도
			cDTO.setComment(clist.get(i).getComment());//원본 코맨트 내용
			cDTO.setCommentSplit(commentCode);//textArea를 결합
			clistSelect.add(cDTO);
			
			commentCode="";//코멘트 코드 초기화
		}
		
		
		int commentLastCount = cDAO.commentLastCount(num);
		

		request.setAttribute("commentLastCount", commentLastCount);//댓글 수정이 아닌 댓글 쓰기를 위한 숫자
		request.setAttribute("clistSelect", clistSelect);


		request.setAttribute("pDTO", pDTO);
		request.setAttribute("languageMode", languageMode);
		request.setAttribute("languageModeId", languageModeId);

		RequestDispatcher dispatcher = request.getRequestDispatcher("paragraphEachSelect.jsp");
		dispatcher.forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
