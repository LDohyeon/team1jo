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
		String db_pw="iotiot";
		//String db_pw="iotiot12*";
		//吏��븷 :: �젣 db 鍮꾨�踰덊샇媛� �떖�씪�꽌 �옞源� �닔�젙�빀�땲�떎.
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn=DriverManager.getConnection(url, db_id, db_pw);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("MemberDAO�쓽 MemberInsert�뿉�꽌 �쉶�꽑 臾몄젣 諛쒖깮"+e);	
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
			System.out.println("�쉶�꽑 醫낅즺 以� 臾몄젣 諛쒖깮 : "+ e);
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
			System.out.println("�쉶�꽑 醫낅즺 以� 臾몄젣 諛쒖깮 : "+ e);
		}
	}
	
	public void MemberInsert(MemberDTO mDTO)//�쉶�썝媛��엯 �떆�옉
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
			System.out.println("MemberDAO�쓽 MemberInsert�뿉�꽌 臾몄젣 諛쒖깮"+e);
		}
		finally
		{
			close(conn, pstmt);
			
		}

	}//�쉶�썝 媛��엯 �걹
	

	//login �떆�옉
	
	

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
			System.out.println("MemberDAO�쓽 MemberLogin�뿉�꽌 臾몄젣 諛쒖깮"+e);
		}
		finally
		{
			close(conn, pstmt, rs);
		}
		return mDTO;
	}
	//login �걹
	
	//id 以묐났 泥댄겕 �떆�옉

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
			System.out.println("�삤瑜섏씤 嫄� �븘�땲怨� 洹몃깷 id 以묐났泥댄겕 �떎�뙣"+e);
		}
		finally
		{
			close(conn, pstmt, rs);
		}

		return result;
		
	}
	//id 以묐났 泥댄겕 �걹
	
	//鍮꾨� 踰덊썑 �닔�젙 �떆�옉
	
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
			System.out.println("鍮꾨�踰덊샇 �닔�젙 �떎�뙣"+e);
		}
		finally
		{
			close(conn, pstmt);
		}
		
	}
	
	//鍮꾨� 踰덊샇 �닔�젙 �걹
	
	
	//�쉶�썝 �젙蹂� �닔�젙 �떆�옉

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
			System.out.println("�쉶�썝 �닔�젙 �떎�뙣"+e);
		}
		finally
		{
			close(conn, pstmt);
		}
	}
	
	//�쉶�썝 �젙蹂� �닔�젙 �걹
	
	//�쉶�썝 �깉�눜 �떆�옉
	
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
			System.out.println("�쉶�썝 �깉�눜 �떎�뙣"+e);
		}
		finally
		{
			close(conn, pstmt);
		}
		
	}
	
	//�쉶�썝 �깉�눜 �걹
	
	
	//愿�由ъ옄 �쉶�썝 愿�由� �떆�옉
	
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
				
				list.add(mDTO);	
			}
		}
		catch(Exception e)
		{
			System.out.println("�쉶�썝 愿�由� 紐⑸줉 異쒕젰 �떎�뙣"+e);
		}
		finally
		{
			close(conn, pstmt, rs);
		}
		
		return list;
	}
	//愿�由ъ옄 �쉶�썝 愿�由� �걹
	
	//愿�由ъ옄 �쉶�썝 愿�由� 寃��깋 �떆�옉
	
	public List<MemberDTO> memberIdSerachList(String id, int startPage, int lastPage)
	{
		String ids=id+"%";
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

			rs=pstmt.executeQuery();
			
			while(rs.next())
			{
				MemberDTO mDTO = new MemberDTO();
				
				mDTO.setNum(rs.getInt("num"));
				mDTO.setId(rs.getString("id"));
				mDTO.setName(rs.getString("name"));
				mDTO.setEmail(rs.getString("email"));
				mDTO.setAuthority(rs.getString("authority"));
				
				list.add(mDTO);
			}
		}
		catch(Exception e)
		{
			System.out.println("�쉶�썝 愿�由� 寃��깋 異쒕젰 �떎�뙣"+e);
		}
		finally
		{
			close(conn, pstmt, rs);
		}

		return list;
	}
	

	public List<MemberDTO> memberNameSerachList(String name, int startPage, int lastPage)
	{
		String names=name+"%";
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

			rs=pstmt.executeQuery();
			
			while(rs.next())
			{
				MemberDTO mDTO = new MemberDTO();
				
				mDTO.setNum(rs.getInt("num"));
				mDTO.setId(rs.getString("id"));
				mDTO.setName(rs.getString("name"));
				mDTO.setEmail(rs.getString("email"));
				mDTO.setAuthority(rs.getString("authority"));
				
				list.add(mDTO);
			}
		}
		catch(Exception e)
		{
			System.out.println("�쉶�썝 愿�由� 寃��깋 異쒕젰 �떎�뙣"+e);
		}
		finally
		{
			close(conn, pstmt, rs);
		}

		return list;
	}
	
	

	
	public List<MemberDTO> memberIdSerachList(String id, String authority, int startPage, int lastPage)
	{
		String ids=id+"%";
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
				
				list.add(mDTO);
			}
		}
		catch(Exception e)
		{
			System.out.println("�쉶�썝 愿�由� 寃��깋 異쒕젰 �떎�뙣"+e);
		}
		finally
		{
			close(conn, pstmt, rs);
		}

		return list;
	}
	
	
	public List<MemberDTO> memberNameSerachList(String name, String authority, int startPage, int lastPage)
	{
		String names=name+"%";
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
				
				list.add(mDTO);
			}
		}
		catch(Exception e)
		{
			System.out.println("�쉶�썝 愿�由� 寃��깋 異쒕젰 �떎�뙣"+e);
		}
		finally
		{
			close(conn, pstmt, rs);
		}

		return list;
	}
	
	
	//愿�由ъ옄 �쉶�썝 愿�由� 寃��깋 �걹
	
	
	//�럹�씠吏� 踰꾪듉 �떆�옉 312踰덉㎏ 硫붿냼�뱶�� �뿰寃�
	
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
			System.out.println("member page 踰꾪듉 �떎�뙣"+e);
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
		String ids= id+"%";
		
		int pagebtn=0;
		
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		
		try
		{
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, ids);
			
			rs=pstmt.executeQuery();
			
			rs.next();
			
			pagebtn = rs.getInt(1);
			
		}
		catch(Exception e)
		{
			System.out.println("member page 踰꾪듉 �떎�뙣"+e);
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
		String names= name+"%";
		
		int pagebtn=0;
		
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		
		try
		{
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, names);
			
			rs=pstmt.executeQuery();
			
			rs.next();
			
			pagebtn = rs.getInt(1);
			
		}
		catch(Exception e)
		{
			System.out.println("member page 踰꾪듉 �떎�뙣"+e);
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
		String ids= id+"%";
		
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
			
			rs=pstmt.executeQuery();
			
			rs.next();
			
			pagebtn = rs.getInt(1);
			
		}
		catch(Exception e)
		{
			System.out.println("member page 踰꾪듉 �떎�뙣"+e);
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
		String names= name+"%";
		
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
			
			rs=pstmt.executeQuery();
			
			rs.next();
			
			pagebtn = rs.getInt(1);
			
		}
		catch(Exception e)
		{
			System.out.println("member page 踰꾪듉 �떎�뙣"+e);
		}
		finally
		{
			close(conn, pstmt, rs);
		}
		
		return pagebtn;
	}
	
	///�럹�씠吏� 踰꾪듉 �걹 312踰덉㎏ 硫붿냼�뱶�� �뿰寃�
	
	
	//�떊怨� 湲곕뒫
	
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
			System.out.println("member �떊怨� 踰꾪듉 �떎�뙣"+e);
		}
		finally
		{
			close(conn, pstmt);
		}
		
	}
	
	//�떊怨� 湲곕뒫
	
	//沅뚰븳 �닔�젙
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
	         System.out.println("�쉶�썝 沅뚰븳 �닔�젙 �떎�뙣"+e);
	      }
	      finally
	      {
	         close(conn, pstmt);
	      }
	   }
	//沅뚰븳 �닔�젙

}










