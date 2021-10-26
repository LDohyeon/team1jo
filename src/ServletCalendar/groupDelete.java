package ServletCalendar;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import DAO.ScheduleDAO;
import DTO.GroupDTO;
import DTO.MemberDTO;

@WebServlet("/groupDelete")
public class groupDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String json = readJSON(request);
		JSONObject data = objJSON(json);
		int length = 0;
		List<String> arrlist = new ArrayList<String>();
		
		String id = String.valueOf(data.get("userKey"));
		String num = String.valueOf(data.get("num"));
		String members=String.valueOf(data.get("members"));
		String master=String.valueOf(data.get("master"));
		
		master = master.replace("\"", "");
		master = master.replace("\'", "");
		
		GroupDTO gDTO = new GroupDTO();
		MemberDTO mDTO = new MemberDTO();
		
		mDTO.setId(id);
		gDTO.setGroupnum(num);
		gDTO.setMaster(master);
		gDTO.setMembers(members);
		
		String str = gDTO.getMembers().replace("[", "");
		str = str.replace("]", "");
		str = str.replace("\"", "");
		str = str.replace("\'", "");
		String[] arr = str.split(",");
		str = "";
		for(int i = 0; i<arr.length; i++) {
			if(arr[i].equals("")==false) {
				if(arr[i].equals(mDTO.getId())) {
					arrlist.add(arr[i]);
				}
				else {
					arrlist.add(arr[i]);
					str+="@"+arr[i];
				}
			}
		}
		gDTO.setMembers(str);
		
		
		ScheduleDAO sDAO = ScheduleDAO.getInstance();
		length = arrlist.size();
		
		if(gDTO.getMaster().equals(mDTO.getId())) {
			if(length==1) {
				sDAO.groupDelete(gDTO);
			}
		}
		else {
			sDAO.groupUpdate(gDTO, mDTO);
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
