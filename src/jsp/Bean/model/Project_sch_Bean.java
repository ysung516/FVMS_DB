package jsp.Bean.model;

public class Project_sch_Bean {
	private String TEAM;
	private String TEAM_ORDER;	// 팀(수주)
	private String TEAM_SALES;	// 팀(매출)
	private String PROJECT_NAME;	// 프로젝트 
	private String STATE;	// 상태
	private String CLIENT;	// 고객사
	private String PROJECT_START;	// 착수
	private String PROJECT_END;	// 종료
	private String PROJECT_MANAGER;	// PM
	private String WORKER_LIST;	// 투입명단
	private int NO;
	private String color;

	public String getTEAM() {
		return TEAM;
	}
	public void setTEAM(String tEAM) {
		TEAM = tEAM;
	}
	public String getTEAM_ORDER() {
		return TEAM_ORDER;
	}
	public void setTEAM_ORDER(String tEAM_ORDER) {
		TEAM_ORDER = tEAM_ORDER;
	}
	public String getTEAM_SALES() {
		return TEAM_SALES;
	}
	public void setTEAM_SALES(String tEAM_SALES) {
		TEAM_SALES = tEAM_SALES;
	}
	public String getPROJECT_NAME() {
		return PROJECT_NAME;
	}
	public void setPROJECT_NAME(String pROJECT_NAME) {
		PROJECT_NAME = pROJECT_NAME;
	}
	public String getSTATE() {
		return STATE;
	}
	public void setSTATE(String sTATE) {
		STATE = sTATE;
	}
	public String getCLIENT() {
		return CLIENT;
	}
	public void setCLIENT(String cLIENT) {
		CLIENT = cLIENT;
	}
	public String getPROJECT_START() {
		return PROJECT_START;
	}
	public void setPROJECT_START(String pROJECT_START) {
		PROJECT_START = pROJECT_START;
	}
	public String getPROJECT_END() {
		return PROJECT_END;
	}
	public void setPROJECT_END(String pROJECT_END) {
		PROJECT_END = pROJECT_END;
	}
	public String getPROJECT_MANAGER() {
		return PROJECT_MANAGER;
	}
	public void setPROJECT_MANAGER(String pROJECT_MANAGER) {
		PROJECT_MANAGER = pROJECT_MANAGER;
	}
	public String getWORKER_LIST() {
		return WORKER_LIST;
	}
	public void setWORKER_LIST(String wORKER_LIST) {
		WORKER_LIST = wORKER_LIST;
	}
	public int getNO() {
		return NO;
	}
	public void setNO(int nO) {
		NO = nO;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
}
