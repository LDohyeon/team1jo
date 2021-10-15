package DAO;

import java.sql.*;

import DTO.ParagraphDTO;

public class ParagraphDAO {

	private ParagraphDAO()
	{
		
	}
	
	private static ParagraphDAO instance = new ParagraphDAO();
	
	public static ParagraphDAO getInstance()
	{
		return instance;
	}
	
	public Connection getConnection()
	{
		Connection conn = null;
		String url = "jdbc:mysql://127.0.0.1:3306/status200";
		String db_id = "root";
		String db_pw = "iotiot";
		
		try
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn=DriverManager.getConnection(url, db_id, db_pw);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("ParagraphDAO의 conn 에서 회선 문제 발생"+e);	
		}
		return conn;
		
	}
	
	public static void close(Connection conn, Statement stmt, ResultSet rs)
	{
		try
		{
			if(rs!=null)
			{
				rs.close();
			}
			if(stmt!=null)
			{
				stmt.close();
			}
			if(conn!=null)
			{
				conn.close();
			}
		}
		catch(Exception e)
		{
			System.out.println("회선 종료 중 문제 발생 : "+ e);
		}
	}
	public static void close(Connection conn, Statement stmt)
	{
		try
		{
			if(stmt!=null)
			{
				stmt.close();
			}
			if(conn!=null)
			{
				conn.close();
			}
		}
		catch(Exception e)
		{
			System.out.println("회선 종료 중 문제 발생 : "+ e);
		}
	}
	
	
	public void paragraphInsert(ParagraphDTO pDTO)
	{


		String sql="insert into paragraph(id, name, title, contents, category, date) values(?, ?, ?, ?, ?, NOW())";
		
		Connection conn=null;
		PreparedStatement pstmt = null;
		
		try
		{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, pDTO.getId());
			pstmt.setString(2, pDTO.getId());
			pstmt.setString(3, pDTO.getTitle());
			pstmt.setString(4, pDTO.getContents());
			pstmt.setString(5, pDTO.getCategory());
			
			pstmt.execute();

		}
		catch(Exception e)
		{
			System.out.println("paragraphInsert 중 문제 발생 : "+ e);
		}

		
	}
	
	
	
	
	
	
}













