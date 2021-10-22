package ServletCalendar;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.*;

import DAO.TodolistDAO;
import DTO.TodoDTO;

@WebServlet("/todolistSelect")
public class todolistSelect extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String userKey = request.getParameter("userKey");
		
		TodoDTO todoDTO = new TodoDTO();
		todoDTO.setId(userKey);
		
		TodolistDAO tDAO = TodolistDAO.getInstance();
		
		List<TodoDTO> list= tDAO.TodoLists(todoDTO);
		List<JSONObject> jsons = new ArrayList<JSONObject>();

		for(int i = 0; i<list.size(); i++) {
			JSONObject json = new JSONObject();
			json.put("num", list.get(i).getNum());
			json.put("title", list.get(i).getTitle());
			json.put("content", list.get(i).getContent());
			json.put("id", list.get(i).getId());
			json.put("date", list.get(i).getDate());
			json.put("time", list.get(i).getTime());
			json.put("importance", list.get(i).getImportance());
			json.put("checked", list.get(i).getChecked());
			
			jsons.add(i, json);
		}
		System.out.println(jsons);
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.print(jsons.toString());
		out.flush();// 버퍼 청소 	
	}

}
