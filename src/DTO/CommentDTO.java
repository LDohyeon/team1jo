package DTO;

public class CommentDTO {

	private int num;
	private int paragraph_num;
	private String content;
	private String time;
	private String id;
	
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getParagraph_num() {
		return paragraph_num;
	}
	public void setParagraph_num(int paragraph_num) {
		this.paragraph_num = paragraph_num;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	
	
//	create table comment(
//			num int primary key auto_increment,
//			paragraph_num int,
//			comment text,
//			time datetime,
//			id text);
	
	
	
	
}
