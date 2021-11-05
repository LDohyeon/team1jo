package DTO;

public class MemberDTO {

	private int num;
	private String id;
	private String pw;
	private String name;
	private String authority;
	private String email;
	private String stopdate;
	private String createDate;
	
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getStopdate() {
		return stopdate;
	}
	public void setStopdate(String stopdate) {
		this.stopdate = stopdate;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}

	
	
//	create database status200;
//	create table member(
//			num int primary key auto_increment,
//			id text,
//			pw text,
//			name text,
//			authority text,
//			email text);
//alter table member add stopdate date;	
//alter table member add createdate date;
	
	
	

	
}