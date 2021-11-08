package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import DTO.TodoDTO;

public class TodolistDAO {
	private TodolistDAO(){
		// getInstance로 호출해서 생성자 new를 막음
	}
	
	private static TodolistDAO instance = new TodolistDAO();
	
	public static TodolistDAO getInstance(){
		return instance;
	}
	
	public Connection getConnection(){
		Connection conn=null;
		String url="jdbc:mysql://127.0.0.1:3306/status200";
		String db_id="root";
		//String db_pw="iotiot";
		String db_pw="iotiot12*";
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
	
	// TodoList 데이터를 가져옴
	public List<TodoDTO> TodoLists(TodoDTO todoDTO){
		List<TodoDTO> list= new ArrayList<TodoDTO>();
		
		String sql="select * from todolist where id=? order by importance desc";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try
		{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, todoDTO.getId());
			
			rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				TodoDTO tDTO = new TodoDTO();
				
				tDTO.setNum(rs.getString("num"));
				tDTO.setTitle(rs.getString("title"));
				tDTO.setContent(rs.getString("content"));
				tDTO.setId(rs.getString("id"));
				tDTO.setDate(rs.getString("date"));
				tDTO.setTime(rs.getString("time"));
				tDTO.setImportance(rs.getInt("importance"));
				tDTO.setChecked(rs.getString("checked"));
				
				list.add(tDTO);
				// ID 로 조회후 일치하는 데이터를 가져옴, 임폴턴스에 따라 중요도가 다르며, 높은 숫자부터 정렬됨 
			}
		}
		catch(Exception e){
			System.out.println("Todolist DAO> Select Error(val == 1) : "+ e);
		}
		finally{
			close(conn, pstmt, rs);
		}
		
		return list;
	}
	// 투두리스트 인설트 
	public void todolistInsert(TodoDTO tDTO){
		
		String sql="insert into todolist(title, content, id, date, time, importance, checked) values(?,?,?,?,?,?,?)";
		Connection conn=null;
		PreparedStatement pstmt=null;
		
		try{
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, tDTO.getTitle());
			pstmt.setString(2, tDTO.getContent());
			pstmt.setString(3, tDTO.getId());
			pstmt.setString(4, tDTO.getDate());
			pstmt.setString(5, tDTO.getTime());
			pstmt.setInt(6, tDTO.getImportance());
			pstmt.setString(7, tDTO.getChecked());

			System.out.println(pstmt);
			pstmt.executeUpdate();

		}
		catch(Exception e)
		{
			System.out.println("todolistDAO> Insert Error: "+e);
		}
		finally
		{
			close(conn, pstmt);
		}
	}
	
	// 투두리스트 딜리트 
	public void todolistDelete(TodoDTO tDTO)
	{
		String sql ="delete from todolist where num = ?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try
		{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(tDTO.getNum()));
			pstmt.executeUpdate();
			System.out.println(pstmt);
		}
		catch(Exception e){
			System.out.println("todolistDAO> Delete Error : "+ e);
		}
		finally{
			close(conn, pstmt);
		}
	}
	
	// 투두리스트 업데이트 
	public void todolistUpdate(TodoDTO tDTO){
		String sql="update todolist set title=?, content=?, date=?, time=?, importance=?, checked=? where num=?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, tDTO.getTitle());
			pstmt.setString(2, tDTO.getContent());
			pstmt.setString(3, tDTO.getDate());
			pstmt.setString(4, tDTO.getTime());
			pstmt.setInt(5, tDTO.getImportance());
			pstmt.setString(6, tDTO.getChecked());
			pstmt.setString(7, tDTO.getNum());
			
			pstmt.executeUpdate();
		}
		catch(Exception e){
			System.out.println("ScheduleDAO > UPDATE Error : "+ e);
		}
		finally{
			close(conn, pstmt);
		}
	}
}

/* 
 * create table todolist(num int primary key auto_increment, title text, content text, id text, date text, time text, importance text, checked text);
 * 
 * */
 