package DAO;

import java.sql.*;
import java.util.*;

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
		String db_pw="iotiot";
		//String db_pw="iotiot12*";
		//지애 :: 제 db 비밀번호가 달라서 잠깐 수정합니다.
		
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
		String sql="insert into paragraph(id, name, title, contents, category, date, hits, tag) values(?, ?, ?, ?, ?, NOW(), 0, ?)";
		
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
			pstmt.setString(6, pDTO.getTag());
			
			pstmt.execute();

		}
		catch(Exception e)
		{
			System.out.println("paragraphInsert 중 문제 발생 : "+ e);
		}	
	}
	
	public List<ParagraphDTO> paragraphList(int StartPage, int lastPage)
	{
		List<ParagraphDTO> list= new ArrayList<ParagraphDTO>();
		int start = StartPage*lastPage-lastPage;
		
		
		String sql="select * from paragraph order by date desc limit ?, ?";
		
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try
		{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, lastPage);
			
			rs = pstmt.executeQuery();
			
			
			while(rs.next())
			{
				ParagraphDTO pDTO = new ParagraphDTO();
				
				pDTO.setNum(rs.getInt("num"));
				pDTO.setId(rs.getString("id"));
				pDTO.setName(rs.getString("name"));
				pDTO.setTitle(rs.getString("title"));
				pDTO.setContents(rs.getString("contents"));
				pDTO.setCategory(rs.getString("category"));
				pDTO.setDatetime(rs.getString("date"));
				pDTO.setHits(rs.getInt("hits"));
				pDTO.setTag(rs.getString("tag"));
				
				list.add(pDTO);
			}
			
		}
		catch(Exception e)
		{
			System.out.println("paragraphList 중 문제 발생 : "+ e);
		}
		finally
		{
			close(conn, pstmt, rs);
		}

		return list;
	}
	
	public int ParagraphPage()
	{
		String sql="select count(num) from paragraph";
		
		int page=0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try
		{
			conn= getConnection();
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			rs.next();
		
			page= rs.getInt(1);
		}
		catch(Exception e)
		{
			System.out.println("ParagraphPage 중 문제 발생 : "+ e);
		}
		finally
		{
			close(conn, pstmt, rs);
		}
		
		return page;
	}
	
	
	public ParagraphDTO ParagraphContents(int num)
	{
		ParagraphDTO pDTO = new ParagraphDTO();
		
		String sql="select * from paragraph where num =?";
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
			
			pDTO.setNum(rs.getInt("num"));
			pDTO.setId(rs.getString("id"));
			pDTO.setName(rs.getString("name"));
			pDTO.setTitle(rs.getString("title"));
			pDTO.setContents(rs.getString("contents"));
			pDTO.setCategory(rs.getString("category"));
			pDTO.setDatetime(rs.getString("date"));
			pDTO.setHits(rs.getInt("hits"));
			pDTO.setTag(rs.getString("tag"));
			
		}
		catch(Exception e)
		{
			System.out.println("ParagraphContents 게시판 보기 중 문제 발생 : "+ e);
		}
		finally
		{
			close(conn, pstmt, rs);
		}
		
		
		return pDTO;
	}
	

	//게시판 수정
	public void paragraphUpdate(ParagraphDTO pDTO)
	{
		String sql="update paragraph set title=?, contents = ? where num = ?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try
		{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, pDTO.getTitle());
			pstmt.setString(2, pDTO.getContents());
			pstmt.setInt(3, pDTO.getNum());
			
			pstmt.executeUpdate();
			
		}
		catch(Exception e)
		{
			System.out.println("ParagraphContents 게시판 수정 중 문제 발생 : "+ e);
		}
		finally
		{
			close(conn, pstmt);
		}

	}
	//게시판 수정
	
	//게시판 삭제
	public void paragraphDelete(int num)
	{
		String sql ="delete from paragraph where num = ?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try
		{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
			
		}
		catch(Exception e)
		{
			System.out.println("ParagraphContents 게시판 삭제 중 문제 발생 : "+ e);
		}
		finally
		{
			close(conn, pstmt);
		}

	}
	//게시판 수정
	
	
	//조회수 업
	
	public void paragraphHitsUp(int num)
	{
		String sql = "update paragraph set hits = hits+1 where num=? ";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
			
		try
		{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
			
		}
		catch(Exception e)
		{
			System.out.println("paragraphHitsUp 게시판 조회수 업 중 문제 발생 : "+ e);
		}
		finally
		{
			close(conn, pstmt);
		}
	}
	
	//조회수 업
	
	//날짜별 작성글 개수 가져오기
	public int countWritings(String date)
	{
		String sql="select count(num) from paragraph where DATE(date)=?;";
		
		int writings=0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try
		{
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, date);
			
			rs=pstmt.executeQuery();
			
			rs.next();
		
			writings=rs.getInt(1);
		}
		catch(Exception e)
		{
			System.out.println("countWritings 중 문제 발생 : "+ e);
		}
		finally
		{
			close(conn, pstmt, rs);
		}
		
		return writings;
	}
	//날짜별 작성글 개수 가져오기
	
	
	//태그 개수 세기
	
	public int countTagParagraph(String tag, String date)
	{
		int tagNum=0;
		String tags="%"+tag+"%";
		
		String sql="select count(num) from Paragraph where tag like ? and DATE(date)=?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		
		try
		{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, tags);
			pstmt.setString(2, date);
				
			rs = pstmt.executeQuery();
			
			rs.next();
			
			tagNum=rs.getInt(1);

		}
		catch(Exception e)
		{
			System.out.println("태그 개수 세기 실패" + e);
		}
		finally
		{
			close(conn, pstmt, rs);
		}
	
		return tagNum;
	}
	
	//태그 개수 세기
	
	
	//게시판 검색
	
	public List<ParagraphDTO> searchParagraph(String search)
	{
		String searchs= "%"+search+"%";		
		String sql="select * from Paragraph where tag like ? || title like ? || contents like ?";
		
		List<ParagraphDTO> list = new ArrayList<ParagraphDTO>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try
		{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, searchs);
			pstmt.setString(2, searchs);
			pstmt.setString(3, searchs);
			
			rs= pstmt.executeQuery();
			
			while(rs.next())
			{
				ParagraphDTO pDTO = new ParagraphDTO();
				
				pDTO.setNum(rs.getInt("num"));
				pDTO.setId(rs.getString("id"));
				pDTO.setName(rs.getString("name"));
				pDTO.setTitle(rs.getString("title"));
				pDTO.setContents(rs.getString("contents"));
				pDTO.setCategory(rs.getString("category"));
				pDTO.setDatetime(rs.getString("date"));
				pDTO.setHits(rs.getInt("hits"));
				pDTO.setTag(rs.getString("tag"));
				
				list.add(pDTO);
			}
			
		}
		catch(Exception e)
		{
			System.out.println("게시판 검색 실패" + e);
		}
		finally
		{
			close(conn, pstmt, rs);
		}
		
		return list;
	}
	
	//게시판 검색
	
	//게시판 검색 페이지 버튼
	
	public int searchPageBtnParagraph(String search)
	{
		String searchs= "%"+search+"%";		
		String sql="select count(num) from Paragraph where tag like ? || title like ? || contents like ?";
		
		int searchPageBtn=0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try
		{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, searchs);
			pstmt.setString(2, searchs);
			pstmt.setString(3, searchs);
			
			rs= pstmt.executeQuery();
			
			rs.next();
			
			searchPageBtn = rs.getInt(1);

		}
		catch(Exception e)
		{
			System.out.println("게시판 페이지 검색 실패" + e);
		}
		finally
		{
			close(conn, pstmt, rs);
		}
		
		return searchPageBtn;
	}	
}
