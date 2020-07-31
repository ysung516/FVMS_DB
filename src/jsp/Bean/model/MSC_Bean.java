package jsp.Bean.model;

public class MSC_Bean {
	private String ID;
	private String no;
	private String AMplace;
	private String PMplace;
	private String Date;
	private String name;
	private String level;
	
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTeam() {
		return team;
	}
	public void setTeam(String team) {
		this.team = team;
	}
	private String team;
	
	public String getID() {
		return ID;
	}
	public void setID(String iD) {
		ID = iD;
	}
	public String getAMplace() {
		return AMplace;
	}
	public void setAMplace(String aMplace) {
		AMplace = aMplace;
	}
	public String getPMplace() {
		return PMplace;
	}
	public void setPMplace(String pMplace) {
		PMplace = pMplace;
	}
	public String getDate() {
		return Date;
	}
	public void setDate(String date) {
		Date = date;
	}
}
