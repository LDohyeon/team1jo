package DAO;

import java.sql.*;
import java.util.*;

import DTO.CommentDTO;
import DTO.ParagraphDTO;

public class CommentDAO {

	private CommentDAO()
	{
		
	}
	
	private static CommentDAO instance = new CommentDAO();
	
	public static CommentDAO getInstance()
	{
		return instance;
	}
	
	public Connection getConnection()
	{
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
			System.out.println("MemberDAO�� MemberInsert���� ȸ�� ���� �߻�"+e);	
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
			System.out.println("ȸ�� ���� �� ���� �߻� : "+ e);
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
			System.out.println("ȸ�� ���� �� ���� �߻� : "+ e);
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
			System.out.println("��� ���� �� ���� �߻� : "+ e);
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
		
		int commentCount=0;
		
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
				cDTO.setCommentCount(commentCount);
				
				list.add(cDTO);		
				
				commentCount++;
			}
		}
		catch(Exception e)
		{
			System.out.println("��� ����Ʈ ��� �� ���� �߻� : "+ e);
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
			System.out.println("��� ���� �� ���� �߻� : "+ e);
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
			System.out.println("��� ���� �� ���� �߻� : "+ e);
		}
		finally
		{
			close(conn, stmt);
		}
	}
	
	public CommentDTO CommentContents(int num)
	{
		CommentDTO cDTO = new CommentDTO();
		
		String sql="select * from comment where num =?";
		Connection conn =null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try
		{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			cDTO.setNum(rs.getInt("num"));
			cDTO.setId(rs.getString("id"));
			cDTO.setComment(rs.getString("comment"));
			cDTO.setTime(rs.getString("time"));
			cDTO.setParagraph_num(rs.getInt("paragraph_num"));
			
		}
		catch(Exception e)
		{
			System.out.println("CommentContents ��� ���� �� ���� �߻� : "+ e);
		}
		finally
		{
			close(conn, pstmt, rs);
		}
		
		
		return cDTO;
	}
	
	
	public int commentLastCount(int paragraph_num)
	{
		int clc=0;
		String sql="select count(num) from comment where paragraph_num="+paragraph_num;
		
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try
		{
			conn= getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			rs.next();
			
			clc = rs.getInt(1);

		}
		catch(Exception e)
		{
			System.out.println("commentLastCount 오류 발생 : "+ e);
		}
		finally
		{
			close(conn, pstmt, rs);
		}
		
		
		return clc;
	}
	
	
	
	
}









