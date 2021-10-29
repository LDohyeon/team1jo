package DTO;

public class GroupDTO {

	private String groupnum;
	private String groupname;
	private String groupcolor;
	private String searchable;
	private String master;
	
	// DB에는 아래 항목이 필요 없음 
	private String[] members;
	private String[] modifiers;
	
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
	public String[] getMembers() {
		return members;
	}
	public void setMembers(String[] membesr) {
		this.members = membesr;
	}
	public String[] getModifiers() {
		return modifiers;
	}
	public void setModifiers(String[] modifiers) {
		this.modifiers = modifiers;
	}
	
}
