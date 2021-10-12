package ServletCalendar;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CheckGroup
 */
@WebServlet("/getGroup")
public class getGroup extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/xml; charset=utf-8");
		
		String userKey = request.getParameter("userKey");
		PrintWriter xml = response.getWriter();
		
		
		if(userKey.equals("DEMOUSER")) {
			xml.print("<data>"
					+ "<group>"
						+ "<num>1</num>"
						+ "<name>DEMOUSER</name>"
						+ "<schedule>"
							+ "<num>1</num>"
							+ "<name>병원가기</name>"
							+ "<start>2021-10-30 09:00:00</start>"
							+ "<end>2021-10-30 13:00:00</end>"
							+ "<user>DEMOUSER</user>"
						+ "</schedule>"
					+ "</group>"
					+ "<group>"
						+ "<num>2</num>"
						+ "<name>DEMO1</name>"
						+ "<schedule>"
							+ "<num>2</num>"
							+ "<name>관리자 페이지 차트 보기 구현</name>"
							+ "<start>2021-10-01 12:00:00</start>"
							+ "<end>2021-10-03 18:00:00</end>"
							+ "<user>DEMOUSER</user>"
						+ "</schedule>"
					+ "</group>"
					+ "<group>"
						+ "<num>3</num>"
						+ "<name>DEMO2</name>"
						+ "<schedule>"
							+ "<num>3</num>"
							+ "<name>거래처 김팀장님에게 전화하기</name>"
							+ "<start>2021-10-02 12:00:00</start>"
							+ "<end>2021-10-02 13:00:00</end>"
							+ "<user>DEMOUSER</user>"
						+ "</schedule>"
					+ "</group>"
					+ "<group>"
						+ "<num>4</num>"
						+ "<name>DEMO3</name>"
						+ "<schedule>"
							+ "<num>4</num>"
							+ "<name>서버 페이지 디버그</name>"
							+ "<start>2021-10-07 12:00:00</start>"
							+ "<end>2021-10-17 13:00:00</end>"
							+ "<user>DEMOUSER</user>"
						+ "</schedule>"
						+ "<schedule>"
							+ "<num>5</num>"
							+ "<name>휴가</name>"
							+ "<start>2021-10-20 12:00:00</start>"
							+ "<end>2021-10-24 13:00:00</end>"
							+ "<user>DEMOUSER</user>"
						+ "</schedule>"
					+ "</group>"
					+ "</data>");
		}
	}
	
}
