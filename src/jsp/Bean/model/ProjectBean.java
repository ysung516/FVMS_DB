package jsp.Bean.model;

public class ProjectBean {
	private String TEAM_ORDER;	// 팀(수주)
	private String TEAM_SALES;	// 팀(매출)
	private String PROJECT_CODE;	// 프로젝트 코드
	private String PROJECT_NAME;	// 프로젝트 
	private String STATE;	// 상태
	private String PART;	// 실
	private String CLIENT;	// 고객사
	private String ClIENT_PART;	// 고객부서
	private float MAN_MONTH;	// M/M
	private float PROJECT_DESOPIT;	// 프로젝트계약금액
	private float FH_ORDER_PROJECTIONS; //상반기 예상 수주
	private float FH_ORDER;	// 상반기수주
	private float FH_SALES_PROJECTIONS;	// 상반기 예상 매출
	private float FH_SALES;	//상반기 매출
	private float SH_ORDER_PROJECTIONS; //하반기 예상 수주
	private float SH_ORDER;	//하반기 수주
	private float SH_SALES_PROJECTIONS;	// 하반기 예상 매출
	private float SH_SALES;	//하반기 매출
	private String PROJECT_START;	// 착수
	private String PROJECT_END;	// 종료
	private String CLIENT_PTB;	// 고객담당자
	private String WORK_PLACE;	//근무지
	private String WORK;	//업무
	private String PROJECT_MANAGER;	// PM
	private String WORKER_LIST;	// 투입명단
	private String ASSESSMENT_TYPE;	// 평가유형
	private float EMPLOY_DEMAND;	//채용수요
	private float OUTSOURCE_DEMAND;	//외주수요
	private int REPORTCHECK; //주간보고서여부
	private int RESULT_REPORT; //실적보고
	private int NO;
	private int year;	// 년도
	private String copy; // 차년도 복사
	private String color;

	
	public String getCopy() {
		return copy;
	}
	public void setCopy(String copy) {
		this.copy = copy;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}

	public String getTEAM_SALES() {
		return TEAM_SALES;
	}
	public void setTEAM_SALES(String tEAM_SALES) {
		TEAM_SALES = tEAM_SALES;
	}
	public String getTEAM_ORDER() {
		return TEAM_ORDER;
	}
	public void setTEAM_ORDER(String tEAM_ORDER) {
		TEAM_ORDER = tEAM_ORDER;
	}
	public String getPROJECT_CODE() {
		return PROJECT_CODE;
	}
	public void setPROJECT_CODE(String pROJECT_CODE) {
		PROJECT_CODE = pROJECT_CODE;
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
	public String getPART() {
		return PART;
	}
	public void setPART(String pART) {
		PART = pART;
	}
	public String getCLIENT() {
		return CLIENT;
	}
	public void setCLIENT(String cLIENT) {
		CLIENT = cLIENT;
	}
	public String getClIENT_PART() {
		return ClIENT_PART;
	}
	public void setClIENT_PART(String clIENT_PART) {
		ClIENT_PART = clIENT_PART;
	}
	public float getMAN_MONTH() {
		return MAN_MONTH;
	}
	public void setMAN_MONTH(float mAN_MONTH) {
		MAN_MONTH = mAN_MONTH;
	}
	public float getPROJECT_DESOPIT() {
		return PROJECT_DESOPIT;
	}
	public void setPROJECT_DESOPIT(float pROJECT_DESOPIT) {
		PROJECT_DESOPIT = pROJECT_DESOPIT;
	}
	public float getFH_ORDER_PROJECTIONS() {
		return FH_ORDER_PROJECTIONS;
	}
	public void setFH_ORDER_PROJECTIONS(float fH_ORDER_PROJECTIONS) {
		FH_ORDER_PROJECTIONS = fH_ORDER_PROJECTIONS;
	}
	public float getFH_ORDER() {
		return FH_ORDER;
	}
	public void setFH_ORDER(float fH_ORDER) {
		FH_ORDER = fH_ORDER;
	}
	public float getFH_SALES_PROJECTIONS() {
		return FH_SALES_PROJECTIONS;
	}
	public void setFH_SALES_PROJECTIONS(float fH_SALES_PROJECTIONS) {
		FH_SALES_PROJECTIONS = fH_SALES_PROJECTIONS;
	}
	public float getFH_SALES() {
		return FH_SALES;
	}
	public void setFH_SALES(float fH_SALES) {
		FH_SALES = fH_SALES;
	}
	public float getSH_ORDER_PROJECTIONS() {
		return SH_ORDER_PROJECTIONS;
	}
	public void setSH_ORDER_PROJECTIONS(float sH_ORDER_PROJECTIONS) {
		SH_ORDER_PROJECTIONS = sH_ORDER_PROJECTIONS;
	}
	public float getSH_ORDER() {
		return SH_ORDER;
	}
	public void setSH_ORDER(float sH_ORDER) {
		SH_ORDER = sH_ORDER;
	}
	public float getSH_SALES_PROJECTIONS() {
		return SH_SALES_PROJECTIONS;
	}
	public void setSH_SALES_PROJECTIONS(float sH_SALES_PROJECTIONS) {
		SH_SALES_PROJECTIONS = sH_SALES_PROJECTIONS;
	}
	public float getSH_SALES() {
		return SH_SALES;
	}
	public void setSH_SALES(float sH_SALES) {
		SH_SALES = sH_SALES;
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
	public String getCLIENT_PTB() {
		return CLIENT_PTB;
	}
	public void setCLIENT_PTB(String cLIENT_PTB) {
		CLIENT_PTB = cLIENT_PTB;
	}
	public String getWORK_PLACE() {
		return WORK_PLACE;
	}
	public void setWORK_PLACE(String wORK_PLACE) {
		WORK_PLACE = wORK_PLACE;
	}
	public String getWORK() {
		return WORK;
	}
	public void setWORK(String wORK) {
		WORK = wORK;
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
	public String getASSESSMENT_TYPE() {
		return ASSESSMENT_TYPE;
	}
	public void setASSESSMENT_TYPE(String aSSESSMENT_TYPE) {
		ASSESSMENT_TYPE = aSSESSMENT_TYPE;
	}
	public float getEMPLOY_DEMAND() {
		return EMPLOY_DEMAND;
	}
	public void setEMPLOY_DEMAND(float eMPLOY_DEMAND) {
		EMPLOY_DEMAND = eMPLOY_DEMAND;
	}
	public float getOUTSOURCE_DEMAND() {
		return OUTSOURCE_DEMAND;
	}
	public void setOUTSOURCE_DEMAND(float oUTSOURCE_DEMAND) {
		OUTSOURCE_DEMAND = oUTSOURCE_DEMAND;
	}
	public int getREPORTCHECK() {
		return REPORTCHECK;
	}
	public void setREPORTCHECK(int rEPORTCHECK) {
		REPORTCHECK = rEPORTCHECK;
	}
	public int getRESULT_REPORT() {
		return RESULT_REPORT;
	}
	public void setRESULT_REPORT(int rESULT_REPORT) {
		RESULT_REPORT = rESULT_REPORT;
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
