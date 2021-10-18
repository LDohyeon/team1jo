package DTO;

public class ParagraphDTO {

	private int num;
	private String id;
	private String name;
	private String title;
	private String contents;
	private String category;
	private String datetime;
	private int hits;


	
	
	public int getHits() {
		return hits;
	}
	public void setHits(int hits) {
		this.hits = hits;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getDatetime() {
		return datetime;
	}
	public void setDatetime(String datetime) {
		this.datetime = datetime;
	}
	
	
	
//	create table paragraph(
//			num int primary key auto_increment,
//			id text,
//			name text,
//			title text,
//			contents text,
//			category text,
//			date datetime);
//alter table paragraph add hits int;	

	
}
