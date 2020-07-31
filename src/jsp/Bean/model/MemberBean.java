package jsp.Bean.model;
import java.sql.Timestamp;

//데이터의 전달을 담당하는 클래스 - DTO
public class MemberBean 
{
	
	private String ID;            // 아이디
	 private String PASSWORD;     // 비밀번호
	 private String NO;	//사원번호
	 private String PART;	//소속
	 private String TEAM;	//팀
	 private String name;        // 이름
	 private String GMAIL;        // 이메일 
	 private String MOBILE;        // 전화
	 private String ADDRESS;        // 주소
	 private String NOTE;	//비고
	 private String RANK;	//직급
	 
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
		return name;
	}
	public void setNAME(String name) {
		this.name = name;
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
