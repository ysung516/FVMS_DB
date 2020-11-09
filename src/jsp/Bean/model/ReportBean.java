package jsp.Bean.model;

public class ReportBean {
	private String id;
	private String name;
	private String rank;
	private String title;
	private String date;
	private String weekPlan;
	private String weekPro;
	private String nextPlan;
	private String specialty;	// 특이사항
	private String note;	// 비고
	private int no;
	private int projectNo;
	private String weekly;	 //주차
	private String final_Check;

	private String [] P_weekPlan;
	public String getWeekly() {
		return weekly;
	}
	public void setWeekly(String weekly) {
		this.weekly = weekly;
	}
	private String [] P_weekPro;
	private String [] P_nextPlan;
	private String [] P_specialty;
	private String [] P_note;
	
	public String[] getP_specialty() {
		this.P_specialty = specialty.split("\n");
		return P_specialty;
	}
	public String[] getP_note() {
		this.P_note = note.split("\n");
		return P_note;
	}
	public String[] getP_weekPlan() {
		this.P_weekPlan = weekPlan.split("\n");
		return P_weekPlan;
	}
	public String[] getP_weekPro() {
		this.P_weekPro = weekPro.split("\n");
		return P_weekPro;
	}
	public String[] getP_nextPlan() {
		this.P_nextPlan = nextPlan.split("\n");
		return P_nextPlan;
	}
	
	public String getSpecialty() {
		return specialty;
	}
	public void setSpecialty(String specialty) {
		this.specialty = specialty;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	
	public String getFinal_Check() {
		return final_Check;
	}
	public void setFinal_Check(String final_Check) {
		this.final_Check = final_Check;
	}
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
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
	public int getProjectNo() {
		return projectNo;
	}
	public void setProjectNo(int projectNo) {
		this.projectNo = projectNo;
	}


}
