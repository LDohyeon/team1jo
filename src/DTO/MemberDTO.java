package DTO;

public class MemberDTO {

	private int num;
	private String id;
	private String pw;
	private String name;
	private String authority;//������.
	private String email;
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
	
	
}
