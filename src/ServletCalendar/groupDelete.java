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

import DAO.GroupDAO;
import DTO.GroupDTO;
import DTO.GroupMemberDTO;
import DTO.GroupModifierDTO;
import DTO.MemberDTO;

@WebServlet("/groupDelete")
public class groupDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		// JSON 으로 데이터를 주고 받음 
		String json = readJSON(request);
		JSONObject data = objJSON(json);

		String id = String.valueOf(data.get("userKey"));
		String num = String.valueOf(data.get("num"));
		String members = String.valueOf(data.get("members"));
		String master=String.valueOf(data.get("master"));
		
		// 마스터는 해당 그룹의 권한자로, 그룹 생성자로 한정 
		master = master.replace("\"", "");
		master = master.replace("\'", "");
		
		String str = members.replace("[", "");
		str = str.replace("]", "");
		str = str.replace("\'", "");
		str = str.replace("\"", "");
		String[] arr = str.split(",");
		System.out.println(arr.length);
		
		GroupDTO gDTO = new GroupDTO();
		MemberDTO mDTO = new MemberDTO();
		GroupMemberDTO gmDTO = new GroupMemberDTO();
		GroupModifierDTO gdDTO = new GroupModifierDTO();
		
		mDTO.setId(id);
		gDTO.setGroupnum(num);
		gDTO.setMaster(master);
		
		gmDTO.setId(id);
		gmDTO.setGroupnum(num);
		
		gdDTO.setId(id);
		gdDTO.setGroupnum(num);
		
		GroupDAO gDAO = GroupDAO.getInstance();
		
		// 마스터랑 유저키가 같고 그룹 멤버가 자신 혼자라면 삭제함 
		// 마스터가 아니면 자신만 해당 그룹에서 빠지는 형태 
		if(gDTO.getMaster().equals(mDTO.getId())) {
			if(arr.length==1) {
				gDAO.groupDelete(gDTO);
				gDAO.deleteMember(gmDTO);
				gDAO.deleteModifier(gdDTO);
			}
		}
		else {
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
