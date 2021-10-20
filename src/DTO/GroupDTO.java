package DTO;

public class GroupDTO {

	private int groupnum;
	private String groupname;
	private String groupcolor;
	private String members;
	private String modifier;
	
	public int getGroupnum() {
		return groupnum;
	}
	public void setGroupnum(int groupnum) {
		this.groupnum = groupnum;
	}
	
	public String getGroupname() {
		return groupname;
	}
	public void setGroupname(String groupname) {
		this.groupname = groupname;
	}
	public String getMembers() {
		return members;
	}
	public void setMembers(String members) {
		this.members = members;
	}
	public String getModifier() {
		return modifier;
	}
	public void setModifier(String modifier) {
		this.modifier = modifier;
	}
	public String getGroupcolor() {
		return groupcolor;
	}
	public void setGroupcolor(String groupcolor) {
		this.groupcolor = groupcolor;
	}
	
}
