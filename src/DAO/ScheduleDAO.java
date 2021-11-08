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
		//String db_pw="iotiot12*";
		//지애 :: 제 db 비밀번호가 달라서 잠깐 수정합니다.
		
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
	public void scheduleDelete(ScheduleDTO sDTO){
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
		String sql="update schedule set title=?, content=?, start=?, end=?, color=?, groupnum=? where num=?";
		
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
			pstmt.setString(6, sDTO.getGroupnum());
			pstmt.setString(7, sDTO.getNum());
			System.out.println(pstmt);
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
}

	
/* create table groupData(groupnum int primary key auto_increment, groupname text, groupcolor text, searchable varchar(11) default 'disable', master text);
 * create table schedule(num int primary key auto_increment, title text, content text, start text, end text, color text, writer text, groupnum text);
 * create table groupMember(num int primary key auto_increment, groupnum int, groupname text, id text, name text, invite varchar(11) default 'notaccept');
 * create table groupModifier(num int primary key auto_increment, groupnum int, groupname text, id text, name text);
 */








