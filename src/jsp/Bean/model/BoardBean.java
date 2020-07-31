package jsp.Bean.model;

public class BoardBean {
	private String id;
	private String name;
	private String rank;
	private String team;
	private String title;
	private String date;
	private String weekPlan;
	private String weekPro;
	private String nextPlan;
	private String no;
	private String [] P_weekPlan;
	private String [] P_weekPro;
	private String [] P_nextPlan;
	
	
	
	public String[] getP_weekPlan() {
		String [] P_weekPlan = weekPlan.split("\n");
		return P_weekPlan;
	}
	public String[] getP_weekPro() {
		String [] P_weekPro = weekPro.split("\n");
		return P_weekPro;
	}
	public String[] getP_nextPlan() {
		String [] P_nextPlan = nextPlan.split("\n");
		return P_nextPlan;
	}
	
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
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
	public String getRank() {
		return rank;
	}
	public void setRank(String rank) {
		this.rank = rank;
	}
	public String getTeam() {
		return team;
	}
	public void setTeam(String team) {
		this.team = team;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getWeekPlan() {
		return weekPlan;
	}
	public void setWeekPlan(String weekPlan) {
		this.weekPlan = weekPlan;
	}
	public String getWeekPro() {
		return weekPro;
	}
	public void setWeekPro(String weekPro) {
		this.weekPro = weekPro;
	}
	public String getNextPlan() {
		return nextPlan;
	}
	public void setNextPlan(String nextPlan) {
		this.nextPlan = nextPlan;
	}
	


}
