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
		
		// JSON 으로 데이터를 주고 받음 
		String json = readJSON(request);
		JSONObject data = objJSON(json);
		int length = 0;
		List<String> arrlist = new ArrayList<String>();
		
		String id = String.valueOf(data.get("userKey"));
		String num = String.valueOf(data.get("num"));
		String members=String.valueOf(data.get("members"));
		String master=String.valueOf(data.get("master"));
		
		// 마스터는 해당 그룹의 권한자로, 그룹 생성자로 한정 
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
		
		// 그룹 데이터를 가져와서 나눠서 저장함
		// DTO를 생성하면 객체 List로 담아야함 
		// 추후 진행 예정 
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
		
		// 마스터랑 유저키가 같고 그룹 멤버가 자신 혼자라면 삭제함 
		// 마스터가 아니면 자신만 해당 그룹에서 빠지는 형태 
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
