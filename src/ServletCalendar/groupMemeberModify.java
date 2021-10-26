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

import DAO.ScheduleDAO;
import DTO.GroupDTO;
import DTO.MemberDTO;

@WebServlet("/groupMemeberModify")
public class groupMemeberModify extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String json = readJSON(request);
		JSONObject data = objJSON(json);
		
		String id = String.valueOf(data.get("userKey"));
		String num = String.valueOf(data.get("num"));
		String modifier=String.valueOf(data.get("modifier"));
		String target=String.valueOf(data.get("target"));
		String master=String.valueOf(data.get("master"));

		GroupDTO gDTO = new GroupDTO();
		MemberDTO mDTO = new MemberDTO();
		
		master = master.replace("\"", "");
		master = master.replace("\'", "");
		
		mDTO.setId(id);
		gDTO.setGroupnum(num);
		gDTO.setMaster(master);
		gDTO.setModifier(modifier);
		
		
		String str = gDTO.getModifier().replace("[", "");
		str = str.replace("]", "");
		str = str.replace("\"", "");
		str = str.replace("\'", "");
		String[] arr = str.split(",");
		str = "";
		boolean flag=true;
		
		for(int i = 0; i<arr.length; i++) {
			if(arr[i].equals("")) {
				
			}
			else {
				if(arr[i].equals(target)) {
					flag=false;
					if(target.equals(mDTO.getId())) {
						str+="@"+arr[i];
					}
				}
				else {
					str+="@"+arr[i];
				}
			}
		}
		
		if(flag==true) {
			str+="@"+target;
		}
		
		gDTO.setModifier(str);
		
		ScheduleDAO sDAO = ScheduleDAO.getInstance();
	
		if(gDTO.getMaster().equals(mDTO.getId())) {
			sDAO.groupUpdateModifier(gDTO);
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
