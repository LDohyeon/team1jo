package ServletCalendar;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.GroupDAO;
import DTO.GroupDTO;
import DTO.GroupMemberDTO;
import DTO.MemberDTO;

@WebServlet("/groupMemberInsert")
public class groupMemberInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		
		String id = request.getParameter("userKey");
		String num = request.getParameter("num");
		String target=request.getParameter("target");
		String master=request.getParameter("master");
		
		GroupMemberDTO gmDTO = new GroupMemberDTO();
		gmDTO.setId(target);
		gmDTO.setGroupnum(num);
		
		GroupDTO gDTO = new GroupDTO();
		gDTO.setMaster(master);
		
		MemberDTO mDTO = new MemberDTO();
		mDTO.setId(id);
		
		GroupDAO gDAO = GroupDAO.getInstance();
		
		if(gDTO.getMaster().equals(mDTO.getId())) {
			gDAO.insertMember(gmDTO);
		}
	}
}
