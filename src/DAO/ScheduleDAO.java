package DAO;
import java.sql.*;
import java.util.*;

import DTO.GroupDTO;
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
	
	// Schedule add to table. 
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
	
	public void scheduleDelete(ScheduleDTO sDTO)
	{
		String sql ="delete from schedule where num = ?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try
		{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sDTO.getNum());
			pstmt.executeUpdate();
			
		}
		catch(Exception e){
			System.out.println("ScheduleDAO> Delete Error : "+ e);
		}
		finally{
			close(conn, pstmt);
		}
	}
	
	public void scheduleUpdate(ScheduleDTO sDTO){
		String sql="update schedule set title=?, contents=?, start=?, end=?, color=? where num=?";
		
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
			pstmt.setLong(6, sDTO.getNum());
			
			pstmt.executeUpdate();
		}
		catch(Exception e){
			System.out.println("ScheduleDAO > UPDATE Error : "+ e);
		}
		finally{
			close(conn, pstmt);
		}
	}
	
	public List<ScheduleDTO> scheduleList(GroupDTO gDTO, String word){
		
		List<ScheduleDTO> list= new ArrayList<ScheduleDTO>();
		word = "%"+word+"%";
		
		String sql="select * from schedule where groupnum=? and (title like ? or content like ?) order by num desc";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try
		{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, gDTO.getGroupnum());
			pstmt.setString(2, word);
			pstmt.setString(3, word);
			
			rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				ScheduleDTO sDTO = new ScheduleDTO();
				
				sDTO.setNum(rs.getInt("num"));
				sDTO.setTitle(rs.getString("title"));
				sDTO.setContent(rs.getString("content"));
				sDTO.setStart(rs.getString("start"));
				sDTO.setEnd(rs.getString("end"));
				sDTO.setWriter(rs.getString("writer"));
				sDTO.setGroupnum(rs.getString("groupnum"));
				
				list.add(sDTO);
			}
		}
		catch(Exception e){
			System.out.println("Schedule DAO> Select Error(val == 2) : "+ e);
		}
		finally{
			close(conn, pstmt, rs);
		}
		return list;
	}
	
	public List<ScheduleDTO> scheduleList(GroupDTO gDTO){
		
		List<ScheduleDTO> list= new ArrayList<ScheduleDTO>();
		
		String sql="select * from schedule where groupnum=? order by num desc";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try
		{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, gDTO.getGroupnum());
			
			rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				ScheduleDTO sDTO = new ScheduleDTO();
				
				sDTO.setNum(rs.getInt("num"));
				sDTO.setTitle(rs.getString("title"));
				sDTO.setContent(rs.getString("content"));
				sDTO.setStart(rs.getString("start"));
				sDTO.setEnd(rs.getString("end"));
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
	
	public List<GroupDTO> groupList(String userKey){
		List<GroupDTO> temp= new ArrayList<GroupDTO>();
		List<GroupDTO> list= new ArrayList<GroupDTO>();
		
		String searchWord = "%"+userKey+"%";
		String sql="select * from groupData where members like ?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try
		{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchWord);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				GroupDTO gDTO = new GroupDTO();
				
				gDTO.setGroupnum(rs.getInt("groupnum"));
				gDTO.setGroupname(rs.getString("groupname"));
				gDTO.setGroupcolor(rs.getString("groupcolor"));
				gDTO.setMembers(rs.getString("members"));
				gDTO.setModifier(rs.getString("modifier"));
				
				temp.add(gDTO);
			}
			
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
}

	
/* create table groupData(groupnum int primary key auto_increment, groupname text, groupcolor text, members text, modifier text);
 * create table schedule(num int primary key auto_increment, title text, content text, start text, end text, color text, writer text, groupnum text);
 * 
 * */








