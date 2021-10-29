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
import DTO.GroupMemberDTO;
import DTO.GroupModifierDTO;
import DTO.MemberDTO;

@WebServlet("/groupMemberDelete")
public class groupMemberDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String json = readJSON(request);
		JSONObject data = objJSON(json);
		
		String id = String.valueOf(data.get("userKey"));
		String num = String.valueOf(data.get("num"));
		String target=String.valueOf(data.get("target"));
		String master=String.valueOf(data.get("master"));

		GroupDTO gDTO = new GroupDTO();
		MemberDTO mDTO = new MemberDTO();
		GroupMemberDTO gmDTO = new GroupMemberDTO();
		GroupModifierDTO gdDTO = new GroupModifierDTO();
		
		master = master.replace("\"", "");
		master = master.replace("\'", "");
		mDTO.setId(id);
		gDTO.setGroupnum(num);
		gDTO.setMaster(master);
		
		gmDTO.setId(target);
		gmDTO.setGroupnum(num);
		
		gdDTO.setId(target);
		gdDTO.setGroupnum(num);
		
		
		GroupDAO gDAO = GroupDAO.getInstance();
		
		// 그룹 멤버 삭제 > 자신이 권한자라면 속해있는 그룹원을 추방할 수 있음 
		if(gDTO.getMaster().equals(mDTO.getId())) {
			gDAO.deleteMember(gmDTO);
			gDAO.deleteModifier(gdDTO);
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
