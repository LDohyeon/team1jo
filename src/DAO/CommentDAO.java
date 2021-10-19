package DAO;

import java.sql.*;
import java.util.*;

import DTO.CommentDTO;

public class CommentDAO {

	private CommentDAO()
	{
		
	}
	
	private static CommentDAO instance = new CommentDAO();
	
	public static CommentDAO getInstatce()
	{
		return instance;
	}
	
	public Connection getConnection()
	{
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
			System.out.println("MemberDAO의 MemberInsert에서 회선 문제 발생"+e);	
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
	
	
	public void insertComment(CommentDTO cDTO)
	{
		String sql="insert into comment(id, paragraph_num, comment, time) values(?, ?, ?, NOW())";
		
		Connection conn=null;
		PreparedStatement pstmt = null;
		
		try
		{
			conn= getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, cDTO.getId());
			pstmt.setInt(2, cDTO.getParagraph_num());
			pstmt.setString(3, cDTO.getComment());
		
			System.out.println("pstmt = "+pstmt);
			
			pstmt.execute();
			
		}
		catch(Exception e)
		{
			System.out.println("댓글 저장 중 오류 발생 : "+ e);
		}
		finally
		{
			close(conn, pstmt);
		}
	}
	
	
	public List<CommentDTO> commentList(int paragraph_num)
	{
		List<CommentDTO> list= new ArrayList<CommentDTO>();
		
		String sql="select * from comment where paragraph_num="+paragraph_num;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		try
		{
			conn= getConnection();
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				CommentDTO cDTO = new CommentDTO();
				
				cDTO.setNum(rs.getInt("num"));
				cDTO.setId(rs.getString("id"));
				cDTO.setComment(rs.getString("comment"));
				cDTO.setParagraph_num(rs.getInt("paragraph_num"));
				cDTO.setTime(rs.getString("time"));
				
				list.add(cDTO);		
			}
		}
		catch(Exception e)
		{
			System.out.println("댓글 리스트 출력 중 오류 발생 : "+ e);
		}
		finally
		{
			close(conn, pstmt, rs);
		}

		return list;
	}
	
	public void commentUpdate(CommentDTO cDTO)
	{
		String sql="update comment set comment=? where num =?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try
		{
			conn= getConnection();
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, cDTO.getComment());
			pstmt.setInt(2, cDTO.getNum());
			
			pstmt.executeUpdate();
			
		}
		catch(Exception e)
		{
			System.out.println("댓글 수정 중 오류 발생 : "+ e);
		}
		finally
		{
			close(conn, pstmt);
		}
	}
	
	public void commentDelete(int num)
	{
		String sql="delete from comment where num="+num;
		
		Connection conn = null;
		Statement stmt = null;
		
		try
		{
			conn= getConnection();
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);
			
		}
		catch(Exception e)
		{
			System.out.println("댓글 삭제 중 오류 발생 : "+ e);
		}
		finally
		{
			close(conn, stmt);
		}
	}
	
	
	
	
}









