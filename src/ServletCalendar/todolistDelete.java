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

@WebServlet("/todolistDelete")
public class todolistDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
			
		String json = readJSON(request);
		JSONObject data = objJSON(json);
		TodolistDAO tDAO = TodolistDAO.getInstance();
		TodoDTO tDTO = new TodoDTO();
		String temp = String.valueOf(data.get("key"));
		temp=temp.replace("[", "");
		temp=temp.replace("]", "");
		temp=temp.replace("\"", "");
		String[] nums =  temp.split(",");
		
		for(int i = 0; i<nums.length; i++) {
			tDTO.setNum(nums[i]);
			System.out.println(tDTO.getNum());
			tDAO.todolistDelete(tDTO);
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

