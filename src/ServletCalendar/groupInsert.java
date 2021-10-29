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

import DAO.GroupDAO;
import DTO.GroupDTO;
import DTO.MemberDTO;

@WebServlet("/groupInsert")
public class groupInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		
		String json = readJSON(request);
		JSONObject data = objJSON(json);
		
		String id = String.valueOf(data.get("userKey"));
		String num = String.valueOf(data.get("num"));
		String name=String.valueOf(data.get("name"));
		String color=String.valueOf(data.get("color"));
		String master=String.valueOf(data.get("master"));
		String searchable=String.valueOf(data.get("searchable"));


		master = master.replace("\"", "");
		master = master.replace("\'", "");
		
		GroupDTO gDTO = new GroupDTO();
		MemberDTO mDTO = new MemberDTO();
		
		mDTO.setId(id);
		gDTO.setGroupnum(num);
		gDTO.setGroupname(name);
		gDTO.setGroupcolor(color);
		gDTO.setMaster(master);
		gDTO.setSearchable(searchable);
		
		if(gDTO.getMaster().equals("")||gDTO.getMaster().equals("null")||gDTO.getMaster()==null) {
			gDTO.setMaster(mDTO.getId());
		}
		
		if(gDTO.getMaster().equals("")) {
			gDTO.setMaster(mDTO.getId());
		}
		else {
			gDTO.setMaster(gDTO.getMaster());
		}
		
		// DTO 생성시 수정 필요 
		
		GroupDAO gDAO = GroupDAO.getInstance();
		// 그룹 넘버가 "" 라면 지금 막 추가한 데이터 므로 인설트
		// 넘버가 있다면 수정이므로 업데이트  
		if(gDTO.getGroupnum().equals("")){
			if((mDTO.getId()).equals(gDTO.getMaster())) {
				System.out.println("인설트");
				gDAO.groupInsert(gDTO);
			}
		}
		else{
			if((mDTO.getId()).equals(gDTO.getMaster())) {
				System.out.print("업뎃");
				gDAO.groupUpdate(gDTO);
			}
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
