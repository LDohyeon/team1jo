package DTO;

public class GroupDTO {

	private String groupnum;
	private String groupname;
	private String groupcolor;
	private String members;
	private String searchable;
	private String master;
	private String modifier;
	
	public String getGroupnum() {
		return groupnum;
	}
	public void setGroupnum(String groupnum) {
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
	public String getSearchable() {
		return searchable;
	}
	public void setSearchable(String searchable) {
		this.searchable = searchable;
	}
	public String getMaster() {
		return master;
	}
	public void setMaster(String master) {
		this.master = master;
	}
	
}
