package jsp.Bean.model;

import java.sql.Timestamp;

//데이터의 전달을 담당하는 클래스 - DTO
public class MemberBean {

	private String ID; // 아이디
	private String PASSWORD; // 비밀번호
	private String NO; // 사원번호
	private String PART; // 소속
	private String TEAM; // 팀
	private String NAME; // 이름
	private String GMAIL; // 이메일
	private String MOBILE; // 전화
	private String ADDRESS; // 주소
	private String NOTE; // 비고
	private String RANK; // 직급
	private String Position; // 직책
	private String comDate; // 입사일
	private String outDate;	// 퇴사일
	private String career; // 커리어
	private int level; // 관리자 일정 정렬 순서
	private String permission; // 권한
	private String saveAttr; // 프로젝트 속성탭 저장값
	private int workEx; // 경력

	public int getWorkEx() {
		return workEx;
	}

	public void setWorkEx(int workEx) {
		this.workEx = workEx;
	}

	public String getSaveAttr() {
		return saveAttr;
	}

	public void setSaveAttr(String saveAttr) {
		this.saveAttr = saveAttr;
	}

	private String[] P_career;

	public String[] getP_career() {
		this.P_career = career.split("\n");
		return P_career;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public String getPermission() {
		return permission;
	}

	public void setPermission(String permission) {
		this.permission = permission;
	}

	public String getCareer() {
		return career;
	}

	public void setCareer(String career) {
		this.career = career;
	}

	public String getOutDate() {
		return outDate;
	}

	public void setOutDate(String outDate) {
		this.outDate = outDate;
	}

	public String getComDate() {
		return comDate;
	}

	public void setComDate(String comDate) {
		this.comDate = comDate;
	}

	public String getPosition() {
		return Position;
	}

	public void setPosition(String position) {
		Position = position;
	}

	public String getRANK() {
		return RANK;
	}

	public void setRANK(String rANK) {
		RANK = rANK;
	}

	public String getID() {
		return ID;
	}

	public void setID(String iD) {
		ID = iD;
	}

	public String getPASSWORD() {
		return PASSWORD;
	}

	public void setPASSWORD(String pASSWORD) {
		PASSWORD = pASSWORD;
	}

	public String getNO() {
		return NO;
	}

	public void setNO(String nO) {
		NO = nO;
	}

	public String getPART() {
		return PART;
	}

	public void setPART(String pART) {
		PART = pART;
	}

	public String getTEAM() {
		return TEAM;
	}

	public void setTEAM(String tEAM) {
		TEAM = tEAM;
	}

	public String getNAME() {
		return NAME;
	}

	public void setNAME(String name) {
		this.NAME = name;
	}

	public String getGMAIL() {
		return GMAIL;
	}

	public void setGMAIL(String gMAIL) {
		GMAIL = gMAIL;
	}

	public String getMOBILE() {
		return MOBILE;
	}

	public void setMOBILE(String mOBILE) {
		MOBILE = mOBILE;
	}

	public String getADDRESS() {
		return ADDRESS;
	}

	public void setADDRESS(String aDDRESS) {
		ADDRESS = aDDRESS;
	}

	public String getNOTE() {
		return NOTE;
	}

	public void setNOTE(String nOTE) {
		NOTE = nOTE;
	}

}
