package jsp.Bean.model;

public class MeetBean {
	
	private String no;
	private String id;
	private String MeetName;	//회의명
	private String writer;	// 작성자
	private String MeetDate;	// 회의일시
	private String MeetPlace;	// 회의장소
	private String attendees;	// 참석자
	private String P_meetnote;
	private String P_nextplan;
	private String date;
	

	private String[] MeetNote;	// 회의내용
	private String[] nextPlan;	// 향후일정
	
	
	public String[] getMeetNote() {
		String [] MeetNote = P_meetnote.split("\n");
		return MeetNote;
	}
	
	public String[] getNextPlan() {
		String [] nextPlan = P_nextplan.split("\n");
		return nextPlan;
	}
	
	
	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getAttendees() {
		return attendees;
	}
	public void setAttendees(String attendees) {
		this.attendees = attendees;
	}	
	public String getMeetName() {
		return MeetName;
	}
	public void setMeetName(String meetName) {
		MeetName = meetName;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getMeetDate() {
		return MeetDate;
	}
	public void setMeetDate(String meetDate) {
		MeetDate = meetDate;
	}
	public String getMeetPlace() {
		return MeetPlace;
	}
	public void setMeetPlace(String meetPlace) {
		MeetPlace = meetPlace;
	}
	
	public String getP_meetnote() {
		return P_meetnote;
	}
	public void setP_meetnote(String p_meetnote) {
		P_meetnote = p_meetnote;
	}
	public String getP_nextplan() {
		return P_nextplan;
	}
	public void setP_nextplan(String p_nextplan) {
		P_nextplan = p_nextplan;
	}


	
	
}
