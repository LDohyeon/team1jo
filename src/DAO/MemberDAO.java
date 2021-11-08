package DAO;

import java.sql.*;
import java.util.*;

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
		//String db_pw="iotiot";
		String db_pw="iotiot12*";
		//지애 :: 제 db 비밀번호가 달라서 잠깐 수정합니다.
		
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
		
		String sql="insert into Member(id, pw, name, email, authority, createDate) values(?,?,?,?, ?, NOW())";
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
			 pstmt.setString(5, mDTO.getAuthority());

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
	
	//신고 기능을 위한 loginmember 오버로딩
	
	public MemberDTO loginMember(String id)
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
		
		
			mDTO=new MemberDTO();
			
			mDTO.setNum(rs.getInt("num"));
			mDTO.setId(rs.getString("id"));
			mDTO.setPw(rs.getString("pw"));
			mDTO.setName(rs.getString("name"));
			mDTO.setEmail(rs.getString("email"));
			mDTO.setAuthority(rs.getString("authority"));
			
									
		}
		catch(Exception e)
		{
			System.out.println("MemberDAO의 MemberLogin2에서 문제 발생"+e);
		}
		finally
		{
			close(conn, pstmt, rs);
		}
	
		
		return mDTO;
		
	}
	
	
	//신고 기능을 위한 loginmember 오버로딩
	
	
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
	
	//비밀 번후 수정 시작
	
	public void MemberPwUpdate(String pw, String id)
	{
		String sql="update member set pw=? where id=?";
		
		Connection conn=null;
		PreparedStatement pstmt = null;
		
		try
		{
			conn= getConnection();
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, pw);
			pstmt.setString(2, id);
			
			pstmt.executeUpdate();
			
		}
		catch(Exception e)
		{
			System.out.println("비밀번호 수정 실패"+e);
		}
		finally
		{
			close(conn, pstmt);
		}
		
	}
	
	//비밀 번호 수정 끝
	
	
	//회원 정보 수정 시작

	public void MemberUpdate(String name, String email, String id)
	{
		String sql="update Member set name=?, email=? where id=?";
		
		Connection conn=null;
		PreparedStatement pstmt = null;
		
		try
		{
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, name);
			pstmt.setString(2, email);
			pstmt.setString(3, id);
			
			pstmt.executeUpdate();
			
			
		}
		catch(Exception e)
		{
			System.out.println("회원 수정 실패"+e);
		}
		finally
		{
			close(conn, pstmt);
		}
	}
	
	//회원 정보 수정 끝
	
	//회원 탈퇴 시작
	
	public void MemberDelete(String id)
	{
		String sql="delete from member where id =?";
		
		Connection conn=null;
		PreparedStatement pstmt = null;
		
		try
		{
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			pstmt.executeUpdate();
			
		}
		catch(Exception e)
		{
			System.out.println("회원 탈퇴 실패"+e);
		}
		finally
		{
			close(conn, pstmt);
		}
		
	}
	
	//회원 탈퇴 끝
	
	
	//관리자 회원 관리 시작
	
	public List<MemberDTO> memberList(int startPage, int lastPage)
	{
		List<MemberDTO> list = new ArrayList<MemberDTO>();
		
		String sql="select * from member order by num desc limit ?, ?";
		
		int start=startPage*lastPage-lastPage;
		
		
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		
		try
		{
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, lastPage);
			
			rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				MemberDTO mDTO = new MemberDTO();
			
				mDTO.setNum(rs.getInt("num"));
				mDTO.setId(rs.getString("id"));
				mDTO.setName(rs.getString("name"));
				mDTO.setEmail(rs.getString("email"));
				mDTO.setAuthority(rs.getString("authority"));
				mDTO.setStopdate(rs.getString("stopdate"));
				mDTO.setCreateDate(rs.getString("createdate"));
				
				list.add(mDTO);	
			}
		}
		catch(Exception e)
		{
			System.out.println("회원 관리 목록 출력 실패"+e);
		}
		finally
		{
			close(conn, pstmt, rs);
		}
		
		return list;
	}
	//관리자 회원 관리 끝
	
	//관리자 회원 관리  시작
	
	public List<MemberDTO> memberIdSerachList(String id, int startPage, int lastPage)
	{
		String ids="%"+id+"%";
		int start=startPage*lastPage-lastPage;
		
		List<MemberDTO> list = new ArrayList<MemberDTO>();
		
		String sql="select * from member where id like ? order by num desc limit ?, ?";
		
		Connection conn =null;
		PreparedStatement pstmt =null;
		ResultSet rs=null;
		
		
		try
		{
			conn= getConnection();
			pstmt= conn.prepareStatement(sql);
			
			pstmt.setString(1, ids);
			pstmt.setInt(2, start);
			pstmt.setInt(3, lastPage);

			System.out.print(pstmt);
			
			rs=pstmt.executeQuery();
			
			while(rs.next())
			{
				MemberDTO mDTO = new MemberDTO();
				
				mDTO.setNum(rs.getInt("num"));
				mDTO.setId(rs.getString("id"));
				mDTO.setName(rs.getString("name"));
				mDTO.setEmail(rs.getString("email"));
				mDTO.setAuthority(rs.getString("authority"));
				mDTO.setStopdate(rs.getString("stopdate"));
				mDTO.setCreateDate(rs.getString("createdate"));
				
				list.add(mDTO);
			}
		}
		catch(Exception e)
		{
			System.out.println("회원 관리 검색 출력 실패"+e);
		}
		finally
		{
			close(conn, pstmt, rs);
		}

		return list;
	}
	

	public List<MemberDTO> memberNameSerachList(String name, int startPage, int lastPage)
	{
		String names="%"+name+"%";
		int start=startPage*lastPage-lastPage;
		
		List<MemberDTO> list = new ArrayList<MemberDTO>();
		
		String sql="select * from member where name like ? order by num desc limit ?, ?";
		
		Connection conn =null;
		PreparedStatement pstmt =null;
		ResultSet rs=null;
		
		
		try
		{
			conn= getConnection();
			pstmt= conn.prepareStatement(sql);
			
			pstmt.setString(1, names);
			pstmt.setInt(2, start);
			pstmt.setInt(3, lastPage);
			
			System.out.print(pstmt);

			rs=pstmt.executeQuery();
			
			while(rs.next())
			{
				MemberDTO mDTO = new MemberDTO();
				
				mDTO.setNum(rs.getInt("num"));
				mDTO.setId(rs.getString("id"));
				mDTO.setName(rs.getString("name"));
				mDTO.setEmail(rs.getString("email"));
				mDTO.setAuthority(rs.getString("authority"));
				mDTO.setStopdate(rs.getString("stopdate"));
				mDTO.setCreateDate(rs.getString("createdate"));
				
				list.add(mDTO);
			}
		}
		catch(Exception e)
		{
			System.out.println("회원 관리 검색 출력 실패"+e);
		}
		finally
		{
			close(conn, pstmt, rs);
		}

		return list;
	}
	
	

	
	public List<MemberDTO> memberIdSerachList(String id, String authority, int startPage, int lastPage)
	{
		String ids="%"+id+"%";
		int start=startPage*lastPage-lastPage;
		
		List<MemberDTO> list = new ArrayList<MemberDTO>();
		
		String sql="select * from member where id like ? and authority=? order by num desc limit ?, ?";
		
		Connection conn =null;
		PreparedStatement pstmt =null;
		ResultSet rs=null;
		
		
		try
		{
			conn= getConnection();
			pstmt= conn.prepareStatement(sql);
			
			pstmt.setString(1, ids);
			pstmt.setString(2, authority);
			pstmt.setInt(3, start);
			pstmt.setInt(4, lastPage);
			
			System.out.println("mem : "+ pstmt);
			
			rs=pstmt.executeQuery();
			
			while(rs.next())
			{
				MemberDTO mDTO = new MemberDTO();
				
				mDTO.setNum(rs.getInt("num"));
				mDTO.setId(rs.getString("id"));
				mDTO.setName(rs.getString("name"));
				mDTO.setEmail(rs.getString("email"));
				mDTO.setAuthority(rs.getString("authority"));
				mDTO.setStopdate(rs.getString("stopdate"));
				mDTO.setCreateDate(rs.getString("createdate"));
				
				list.add(mDTO);
			}
		}
		catch(Exception e)
		{
			System.out.println("회원 관리 검색 출력 실패"+e);
		}
		finally
		{
			close(conn, pstmt, rs);
		}

		return list;
	}
	
	
	public List<MemberDTO> memberNameSerachList(String name, String authority, int startPage, int lastPage)
	{
		String names="%"+name+"%";
		int start=startPage*lastPage-lastPage;
		
		List<MemberDTO> list = new ArrayList<MemberDTO>();
		
		String sql="select * from member where name like ? and authority=? order by num desc limit ?, ?";
		
		Connection conn =null;
		PreparedStatement pstmt =null;
		ResultSet rs=null;
		
		
		try
		{
			conn= getConnection();
			pstmt= conn.prepareStatement(sql);
			
			pstmt.setString(1, names);
			pstmt.setString(2, authority);
			pstmt.setInt(3, start);
			pstmt.setInt(4, lastPage);
			
			System.out.print(pstmt);
			
			rs=pstmt.executeQuery();
			
			while(rs.next())
			{
				MemberDTO mDTO = new MemberDTO();
				
				mDTO.setNum(rs.getInt("num"));
				mDTO.setId(rs.getString("id"));
				mDTO.setName(rs.getString("name"));
				mDTO.setEmail(rs.getString("email"));
				mDTO.setAuthority(rs.getString("authority"));
				mDTO.setStopdate(rs.getString("stopdate"));
				mDTO.setCreateDate(rs.getString("createdate"));
				
				list.add(mDTO);
			}
		}
		catch(Exception e)
		{
			System.out.println("회원 관리 검색 출력 실패"+e);
		}
		finally
		{
			close(conn, pstmt, rs);
		}

		return list;
	}
	
	
	//관리자 회원 관리 검색 끝
	
	
	//페이지 버튼 시작 312번째 메소드와 연결
	
	public int memberListPageBtn()
	{
		String sql="select count(num) from member";
		
		int pagebtn=0;
		
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		
		try
		{
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			rs.next();
			
			pagebtn = rs.getInt(1);
			
		}
		catch(Exception e)
		{
			System.out.println("member page 버튼 실패"+e);
		}
		finally
		{
			close(conn, pstmt, rs);
		}
		
		return pagebtn;
	}
	
	
	public int memberListIdPageBtn(String id)
	{
		String sql="select count(num) from member where id like ?";
		String ids= "%"+id+"%";
		
		int pagebtn=0;
		
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		
		try
		{
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, ids);
			
			System.out.print(pstmt);
			
			rs=pstmt.executeQuery();
			
			rs.next();
			
			pagebtn = rs.getInt(1);
			
		}
		catch(Exception e)
		{
			System.out.println("member page 버튼 실패"+e);
		}
		finally
		{
			close(conn, pstmt, rs);
		}
		
		return pagebtn;
	}
	
	
	public int memberListNamePageBtn(String name)
	{
		String sql="select count(num) from member where name like ?";
		String names= "%"+name+"%";
		
		int pagebtn=0;
		
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		
		try
		{
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, names);
			
			System.out.print(pstmt);
			
			rs=pstmt.executeQuery();
			
			rs.next();
			
			pagebtn = rs.getInt(1);
			
		}
		catch(Exception e)
		{
			System.out.println("member page 버튼 실패"+e);
		}
		finally
		{
			close(conn, pstmt, rs);
		}
		
		return pagebtn;
	}
	
	public int memberListIdPageBtn(String id, String authority)
	{
		String sql="select count(num) from member where id like ? and authority=?";
		String ids= "%"+id+"%";
		
		int pagebtn=0;
		
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		
		try
		{
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, ids);
			pstmt.setString(2, authority);
			
			System.out.print(pstmt);
			
			rs=pstmt.executeQuery();
			
			rs.next();
			
			pagebtn = rs.getInt(1);
			
		}
		catch(Exception e)
		{
			System.out.println("member page 버튼 실패"+e);
		}
		finally
		{
			close(conn, pstmt, rs);
		}
		
		return pagebtn;
	}
	
	public int memberListNamePageBtn(String name, String authority)
	{
		String sql="select count(num) from member where name like ? and authority=?";
		String names= "%"+name+"%";
		
		int pagebtn=0;
		
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		
		try
		{
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, names);
			pstmt.setString(2, authority);
			
			System.out.print(pstmt);
			
			rs=pstmt.executeQuery();
			
			rs.next();
			
			pagebtn = rs.getInt(1);
			
		}
		catch(Exception e)
		{
			System.out.println("member page 버튼 실패"+e);
		}
		finally
		{
			close(conn, pstmt, rs);
		}
		
		return pagebtn;
	}
	
	///페이지 버튼 끝 312번째 메소드와 연결
	
	
	//신고 기능
	
		public void memberReport(String id)
		{
			String sql = "update member set authority=3 where id=?";
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			
			try
			{
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, id);
				
				pstmt.executeUpdate();
				
			}
			catch(Exception e)
			{
				System.out.println("member 신고 버튼 실패"+e);
			}
			finally
			{
				close(conn, pstmt);
			}
			
		}
		
		//신고 기능
		
		//권한 수정
		public void memberListAuthorityUpdate(String selAuIdValue, String authority) {
		      
		      String sql="update member set authority=? where id=?";
		      
		      Connection conn=null;
		      PreparedStatement pstmt = null;
		      
		      try
		      {
		         conn=getConnection();
		         pstmt=conn.prepareStatement(sql);
		         
		         pstmt.setString(1, authority);
		         pstmt.setString(2, selAuIdValue);
		         pstmt.executeUpdate();   
		      }
		      catch(Exception e)
		      {
		         System.out.println("회원 권한 수정 실패"+e);
		      }
		      finally
		      {
		         close(conn, pstmt);
		      }
		   }
		//권한 수정
		
		//정지 기간 설정
		public void updateSuspension(String date, String selAuIdValue)
		{
			String sql="update Member set stopdate=? where id=?";
			Connection conn=null;
			PreparedStatement pstmt = null;
		
			try
			{
				conn=getConnection();
				pstmt=conn.prepareStatement(sql);
				
				pstmt.setString(1, date);
				pstmt.setString(2, selAuIdValue);
				
				pstmt.executeUpdate();
			}
			catch(Exception e)
			{
				System.out.println("MemberDAO의 updateSuspension에서 문제 발생"+e);
			}
			finally
			{
				close(conn, pstmt);
			}
		}
		//정지 기간 설정
		
		//정지 기간 가져오기
		public String getSusLastDay(String id)
		{
			String susLastDay="";
			String sql="select stopdate from member where id = ?";
			
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
				susLastDay = rs.getString("stopdate");
											
			}
			catch(Exception e)
			{
				System.out.println("MemberDAO의 getSusLastDay에서 문제 발생"+e);
			}
			finally
			{
				close(conn, pstmt, rs);
			}
			return susLastDay;
		}
		//정지 기간 가져오기
			
		// 회원가입자 수 
		public String registerMemberDateCount(String ymdDate) {
			String sql="select count(*) from member where createdate=?"; 
			Connection conn=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null; 
			try {
				conn=getConnection();
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, ymdDate);
				rs=pstmt.executeQuery();
				rs.next();
				ymdDate = rs.getString(1);		
			}
			catch(Exception e) {
				System.out.println("회원가입자 수 오류 발생 +e");
			}
			finally
			{
				close(conn, pstmt, rs);
			}
			return ymdDate;
		}
	}