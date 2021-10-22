package ServletCalendar;

import java.io.BufferedReader;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import DAO.TodolistDAO;
import DTO.TodoDTO;


@WebServlet("/todolistInsert")
public class todolistInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String json = readJSON(request);
		System.out.println(json);
		JSONObject data = objJSON(json);
		
		String num = String.valueOf(data.get("num"));
		String title=String.valueOf(data.get("title"));
		String content=String.valueOf(data.get("content"));
		String id=String.valueOf(data.get("id"));
		String date=String.valueOf(data.get("date"));
		String time=String.valueOf(data.get("time"));
		int importance= Integer.valueOf(String.valueOf(data.get("importance")));
		String checked=String.valueOf(data.get("checked"));
		
		TodoDTO tDTO = new TodoDTO();
		tDTO.setNum(num);
		tDTO.setTitle(title);
		tDTO.setContent(content);
		tDTO.setId(id);
		tDTO.setDate(date);
		tDTO.setTime(time);
		tDTO.setImportance(importance);
		tDTO.setChecked(checked);
		
		if(tDTO.getNum().equals("")){
			System.out.println("인설트");
		}
		else {
			System.out.print("업뎃");
		}
		
		TodolistDAO tDAO = TodolistDAO.getInstance();
		
		if(tDTO.getNum().equals("")) {
			tDAO.todolistInsert(tDTO);	
		}
		else {
			tDAO.todolistUpdate(tDTO);
		}
	}
	
	protected String readJSON(HttpServletRequest request) { 
		StringBuffer json = new StringBuffer(); 
		String line = null;
		
		try { 
			BufferedReader reader=request.getReader();

			while((line=reader.readLine())!=null){ 
				json.append(line); 
			}
		}
		catch(Exception e) {
			System.out.println("JSON 파일을 읽어오던 중 오류 발생");
		}
		return json.toString(); 
	}
	
	protected JSONObject objJSON(String str) {
		Object obj=null;
		JSONObject json=null;
		System.out.println(str);
		try {
			JSONParser parser = new JSONParser();
			obj=parser.parse(str);
			json=(JSONObject)obj;
		}
		catch(Exception e) {
			System.out.println("JSON 변환 중 오류 발생: "+e);
		}
		return json;
	}
}
