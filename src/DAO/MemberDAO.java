package DAO;

import java.sql.*;


import DTO.MemberDTO;

public class MemberDAO {

	
	private MemberDAO()
	{
		
	}
	
	private static MemberDAO instance = new MemberDAO();
	
	public static MemberDAO getInstance()
	{
		return instance;
	}
	public Connection getConnection()
	{
		Connection conn=null;
		String url="jdbc:mysql://127.0.0.1:3306/status200";
		String db_id="root";
		String db_pw="iotiot12*";
		//지애 :: 제 db 비밀번호가 달라서 잠깐 수정합니다.
		//String db_pw="iotiot";
		
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
	
	public void MemberInsert(MemberDTO mDTO)//회원가입 시작
	{
		
		String sql="insert into Member(id, pw, name, email, authority) values(?,?,?,?, 2)";
		Connection conn=null;
		PreparedStatement pstmt=null;
		try
		{
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, mDTO.getId());
			pstmt.setString(2, mDTO.getPw());
			pstmt.setString(3, mDTO.getName());
			pstmt.setString(4, mDTO.getEmail());

			System.out.println(pstmt);
			pstmt.executeUpdate();

		}
		catch(Exception e)
		{
			System.out.println("MemberDAO의 MemberInsert에서 문제 발생"+e);
		}
		finally
		{
			close(conn, pstmt);
			
		}

	}//회원 가입 끝
	

	//login 시작
	
	

	public MemberDTO loginMember(String id, String pw)
	{
		
		MemberDTO mDTO=null;
		String sql="select * from member where id = ?";
		
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		
		try
		{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();
		

			rs.next();
		
			if(rs.getString("pw").equals(pw))
			{
				mDTO=new MemberDTO();
				
				mDTO.setNum(rs.getInt("num"));
				mDTO.setId(rs.getString("id"));
				mDTO.setPw(rs.getString("pw"));
				mDTO.setName(rs.getString("name"));
				mDTO.setEmail(rs.getString("email"));
				mDTO.setAuthority(rs.getString("authority"));

			}								
		}
		catch(Exception e)
		{
			System.out.println("MemberDAO의 MemberLogin에서 문제 발생"+e);
		}
		finally
		{
			close(conn, pstmt, rs);
		}
	
		
		return mDTO;
		
	}
	//login 끝
	
	//id 중복 체크 시작

	public int idCheck(String id)
	{
		int result = 1;
		String sql="select id from member where id = ?";
		
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		
		try
		{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, id);
	
			rs = pstmt.executeQuery();
		
			rs.next();
		
			if(rs.getString("id").equals(id))
			{		
				result = -1;
			}								
		}
		catch(Exception e)
		{
			System.out.println("오류인 건 아니고 그냥 id 중복체크 실패"+e);
		}
		finally
		{
			close(conn, pstmt, rs);
		}

		return result;
		
	}
	
	//id 중복 체크 끝
	
	
}















