package ServletCalendar;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import DAO.GroupDAO;

@WebServlet("/InviteList")
public class InviteList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		String userKey = request.getParameter("userKey");
		GroupDAO gDAO = new GroupDAO();

		response.setCharacterEncoding("utf-8");

	}

}
