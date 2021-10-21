package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import DTO.GroupDTO;
import DTO.ScheduleDTO;
import DTO.TodoDTO;

public class todolistDAO {
	private todolistDAO(){
		
	}
	
	private static todolistDAO instance = new todolistDAO();
	
	public static todolistDAO getInstance(){
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
				
				tDTO.setNum(rs.getInt("num"));
				tDTO.setTitle(rs.getString("title"));
				tDTO.setContent(rs.getString("content"));
				tDTO.setId(rs.getString("id"));
				tDTO.setDate(rs.getString("date"));
				tDTO.setTime(rs.getString("time"));
				tDTO.setImportance(rs.getInt("importance"));
				tDTO.setChecked(rs.getString("checked"));
				
				list.add(tDTO);
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
}

/* 
 * create table todolist(num int primary key auto_increment, title text, content text, id text, date text, time text, importance text, checked text);
 * 
 * */
 