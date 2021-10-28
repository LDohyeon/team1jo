package DAO;
import java.sql.*;
import java.util.*;

import DTO.GroupDTO;
import DTO.MemberDTO;
import DTO.ScheduleDTO;

public class ScheduleDAO {
	private ScheduleDAO(){
		
	}
	
	private static ScheduleDAO instance = new ScheduleDAO();
	
	public static ScheduleDAO getInstance(){
		return instance;
	}
	
	public Connection getConnection(){
		Connection conn=null;
		String url="jdbc:mysql://127.0.0.1:3306/status200";
		String db_id="root";
		String db_pw="iotiot";
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn=DriverManager.getConnection(url, db_id, db_pw);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("Schedule DAO Error **********"+e);	
		}

		return conn;
	}
	public static void close(Connection conn, Statement stmt, ResultSet rs){
		try{
			if(rs!=null){
				rs.close();
			}
			if(stmt!=null){
				stmt.close();
			}
			if(conn!=null){
				conn.close();
			}
		}
		catch(Exception e){
			System.out.println("Close Error(val ==3) : "+ e);
		}
	}
	
	public static void close(Connection conn, Statement stmt){
		try{
			if(stmt!=null){
				stmt.close();
			}
			if(conn!=null){
				conn.close();
			}
		}
		catch(Exception e){
			System.out.println("Close Error(val == 2) : "+ e);
		}
	}
	
	// Schedule add to table. 스케줄 인설트  
	public void scheduleInsert(ScheduleDTO sDTO){
		
		String sql="insert into schedule(title, content, start, end, writer, groupnum, color) values(?,?,?,?,?,?,?)";
		Connection conn=null;
		PreparedStatement pstmt=null;
		
		try{
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, sDTO.getTitle());
			pstmt.setString(2, sDTO.getContent());
			pstmt.setString(3, sDTO.getStart());
			pstmt.setString(4, sDTO.getEnd());
			pstmt.setString(5, sDTO.getWriter());
			pstmt.setString(6, sDTO.getGroupnum());
			pstmt.setString(7, sDTO.getColor());

			System.out.println(pstmt);
			pstmt.executeUpdate();

		}
		catch(Exception e)
		{
			System.out.println("ScheduleDAO> Insert Error: "+e);
		}
		finally
		{
			close(conn, pstmt);
		}
	}
	//스케줄 딜리트 
	public void scheduleDelete(ScheduleDTO sDTO)
	{
		String sql ="delete from schedule where num = ?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try
		{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sDTO.getNum());
			pstmt.executeUpdate();
			
		}
		catch(Exception e){
			System.out.println("ScheduleDAO> Delete Error : "+ e);
		}
		finally{
			close(conn, pstmt);
		}
	}
	// 스케줄 업데이트 
	public void scheduleUpdate(ScheduleDTO sDTO){
		String sql="update schedule set title=?, content=?, start=?, end=?, color=? where num=?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, sDTO.getTitle());
			pstmt.setString(2, sDTO.getContent());
			pstmt.setString(3, sDTO.getStart());
			pstmt.setString(4, sDTO.getEnd());
			pstmt.setString(5, sDTO.getColor());
			pstmt.setString(6, sDTO.getNum());
			
			pstmt.executeUpdate();
		}
		catch(Exception e){
			System.out.println("ScheduleDAO > UPDATE Error : "+ e);
		}
		finally{
			close(conn, pstmt);
		}
	}
	// 스케줄 리스트를 반환함, 다수의 스케줄을 확인함 
	public List<ScheduleDTO> scheduleList(GroupDTO gDTO){
		// 변수를 Group으로 받아서 그룹 데이터를 기준으로 조회함 
		// 이렇게 조회해야 Group 별로 스케줄을 분류하고 '보기 및 끄기'를 구현할 수 있음 
		List<ScheduleDTO> list= new ArrayList<ScheduleDTO>();
		
		String sql="select * from schedule where groupnum=? order by num desc";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try
		{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, gDTO.getGroupnum());
			
			rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				ScheduleDTO sDTO = new ScheduleDTO();
				
				sDTO.setNum(rs.getString("num"));
				sDTO.setTitle(rs.getString("title"));
				sDTO.setContent(rs.getString("content"));
				sDTO.setStart(rs.getString("start"));
				sDTO.setEnd(rs.getString("end"));
				sDTO.setColor(rs.getString("color"));
				sDTO.setWriter(rs.getString("writer"));
				sDTO.setGroupnum(rs.getString("groupnum"));
				
				list.add(sDTO);
			}
		}
		catch(Exception e){
			System.out.println("Schedule DAO> Select Error(val == 1) : "+ e);
		}
		finally{
			close(conn, pstmt, rs);
		}
		return list;
	}
	
	// 스케줄을 찾을 경우 반환하는 데이터, 단어를 Like로 지정하여 일치하면 찾음 
	// 다만 속해있는 그룹이 아니면 찾아서는 안됨 
	public List<ScheduleDTO> scheduleListSearch(GroupDTO gDTO, String word){
		
		List<ScheduleDTO> list= new ArrayList<ScheduleDTO>();
		
		String searchWord = "%"+word+"%";
		String sql="select * from schedule where groupnum = ? and (title like ? or content like ?) limit 10";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try
		{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, gDTO.getGroupnum());
			pstmt.setString(2, searchWord);
			pstmt.setString(3, searchWord);
			
			rs = pstmt.executeQuery();
			System.out.println(pstmt);
			while(rs.next())
			{
				ScheduleDTO sDTO = new ScheduleDTO();
				
				sDTO.setNum(rs.getString("num"));
				sDTO.setTitle(rs.getString("title"));
				sDTO.setContent(rs.getString("content"));
				sDTO.setStart(rs.getString("start"));
				sDTO.setEnd(rs.getString("end"));
				sDTO.setColor(rs.getString("color"));
				sDTO.setWriter(rs.getString("writer"));
				sDTO.setGroupnum(rs.getString("groupnum"));
				
				list.add(sDTO);
			}
		}
		catch(Exception e){
			System.out.println("Schedule DAO> Select Error(val == 3) : "+ e);
		}
		finally{
			close(conn, pstmt, rs);
		}
		return list;
	}
	
	// 그룹 정보를 가져옴 
	public List<GroupDTO> groupList(String userKey){
		List<GroupDTO> temp= new ArrayList<GroupDTO>();
		List<GroupDTO> list= new ArrayList<GroupDTO>();
		
		String searchWord = "%"+userKey+"%";
		String sql="select * from groupData where members like ?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		// 테이블을 다수로 잡지 않고, @를 구분자로 해서 구성함
		// 테이블을 나눈다면 수정자와 멤버들로 2개 나눠서 별도의 메서드 생성이 필요
		// 물론 테이블을 나누는게 더 편하고 보기 쉬움 
		try
		{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchWord);
			
			System.out.println(pstmt);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				GroupDTO gDTO = new GroupDTO();
				gDTO.setGroupnum(rs.getString("groupnum"));
				gDTO.setGroupname(rs.getString("groupname"));
				gDTO.setGroupcolor(rs.getString("groupcolor"));
				gDTO.setMaster(rs.getString("master"));
				gDTO.setSearchable(rs.getString("searchable"));
				gDTO.setMembers(rs.getString("members"));
				gDTO.setModifier(rs.getString("modifier"));

				temp.add(gDTO);
			}
			// 아이디를 Like 절로 검색하는 것은 하나의 컬럼에 데이터가 다 들어가기 때문
			// 결과적으로 test 와 test1을 식별해야 한다는 것
			// 때문에 일치하는 데이터를 한 차례 더 검증하여 List를 구성함 
			for(int i = 0; i<temp.size(); i++) {
				String member[] = temp.get(i).getMembers().split("@");
				
				for(int j = 0; j<member.length; j++) {
					if(userKey.equals(member[j])) {
						list.add(temp.get(i));
					}
				}
			}
		}
		catch(Exception e){
			System.out.println("Schedule DAO> Select Error(val == 1) : "+ e);
		}
		finally{
			close(conn, pstmt, rs);
		}
		return list;
	}
	
/*	=============================================================
 *  ======================== GROUP ==============================
 *	============================================================= */
	
	// Schedule add to table. 
	public void groupInsert(GroupDTO gDTO){
		
		String sql="insert into groupData(groupname, groupcolor, members, searchable, master, modifier) values(?,?,?,?,?,?)";
		Connection conn=null;
		PreparedStatement pstmt=null;
		
		try{
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, gDTO.getGroupname());
			pstmt.setString(2, gDTO.getGroupcolor());
			pstmt.setString(3, gDTO.getMembers());
			pstmt.setString(4, gDTO.getSearchable());
			pstmt.setString(5, gDTO.getMaster());
			pstmt.setString(6, gDTO.getModifier());
			

			System.out.println(pstmt);
			pstmt.executeUpdate();

		}
		catch(Exception e)
		{
			System.out.println("ScheduleDAO> groupData Insert Error: "+e);
		}
		finally
		{
			close(conn, pstmt);
		}
	}
	// 그룹 삭제 
	public void groupDelete(GroupDTO gDTO)
	{
		String sql ="delete from groupData where groupnum = ?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		// 그룹 삭제에 대한 알고리즘은 서블렛에 구현 
		
		try
		{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, gDTO.getGroupnum());
			pstmt.executeUpdate();
			
		}
		catch(Exception e){
			System.out.println("ScheduleDAO> groupData Delete Error : "+ e);
		}
		finally{
			close(conn, pstmt);
		}
	}
	
	public void groupUpdate(GroupDTO gDTO){
		String sql="update groupData set groupname=?, groupcolor=?, members=?, searchable=?, master=?, modifier=? where groupnum=?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, gDTO.getGroupname());
			pstmt.setString(2, gDTO.getGroupcolor());
			pstmt.setString(3, gDTO.getMembers());
			pstmt.setString(4, gDTO.getSearchable());
			pstmt.setString(5, gDTO.getMaster());
			pstmt.setString(6, gDTO.getModifier());
			pstmt.setString(7, gDTO.getGroupnum());
			
			pstmt.executeUpdate();
		}
		catch(Exception e){
			System.out.println("ScheduleDAO > groupData UPDATE Error : "+ e);
		}
		finally{
			close(conn, pstmt);
		}
	}
	public void groupUpdate(GroupDTO gDTO, MemberDTO mDTO){

		String sql="update groupData set members=? where groupnum=?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, gDTO.getMembers());
			pstmt.setString(2, gDTO.getGroupnum());
			pstmt.executeUpdate();
		}
		catch(Exception e){
			System.out.println("ScheduleDAO > groupData UPDATE Error : "+ e);
		}
		finally{
			close(conn, pstmt);
		}
	}
	public void groupUpdateModifier(GroupDTO gDTO){

		String sql="update groupData set modifier=? where groupnum=?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
		
			pstmt.setString(1, gDTO.getModifier());
			pstmt.setString(2, gDTO.getGroupnum());
			pstmt.executeUpdate();
		}
		catch(Exception e){
			System.out.println("ScheduleDAO > groupData UPDATE Error : "+ e);
		}
		finally{
			close(conn, pstmt);
		}
	}
	public void groupUpdateMember(GroupDTO gDTO){

		String sql="update groupData set members=?, modifier=? where groupnum=?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
		
			pstmt.setString(1, gDTO.getMembers());
			pstmt.setString(2, gDTO.getModifier());
			pstmt.setString(3, gDTO.getGroupnum());
			pstmt.executeUpdate();
		}
		catch(Exception e){
			System.out.println("ScheduleDAO > groupData UPDATE Error : "+ e);
		}
		finally{
			close(conn, pstmt);
		}
	}
	
	// 멤버 정보를 리스트로 뽑아옴 
	// 멤버 초대 기능에 사용함 
	public List<MemberDTO> memberList(String word){
		
		String searchword = "%"+word+"%";
		List<MemberDTO> list = new ArrayList<MemberDTO>();
		
		String sql="select * from member where id like ? or name like ? limit 10";
	
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		
		try
		{
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, searchword);
			pstmt.setString(2, searchword);
			
			System.out.println(pstmt);
			rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				MemberDTO mDTO = new MemberDTO();
			
				mDTO.setNum(rs.getInt("num"));
				mDTO.setId(rs.getString("id"));
				mDTO.setName(rs.getString("name"));
				mDTO.setEmail(rs.getString("email"));
				mDTO.setAuthority(rs.getString("authority"));
				
				list.add(mDTO);	
			}
		}
		catch(Exception e)
		{
			System.out.println("ScheduleDAO > MemberSearch (val == 2) ERROR "+e);
		}
		finally
		{
			close(conn, pstmt, rs);
		}
		
		return list;
	}
}

	
/* create table groupData(groupnum int primary key auto_increment, groupname text, groupcolor text, members text, searchable varchar(11) default disable, master text, modifier text);
 * create table schedule(num int primary key auto_increment, title text, content text, start text, end text, color text, writer text, groupnum text);
 * c
 * */








