package DTO;

public class GroupModifierDTO {
	private String num;
	private String groupnum;
	private String id;
	// db에는 없음
	private String name;
	
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getGroupnum() {
		return groupnum;
	}
	public void setGroupnum(String groupnum) {
		this.groupnum = groupnum;
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
}
