package jsp.Bean.model;

public class TeamBean {
	private String teamName;
	private int teamNum;
	private float FH_targetOrder;	// 상반기 목표 수주
	private float FH_targetSales;	// 상반기 목표 매출
	private float SH_targetOrder;	// 하반기 목표 수주
	private float SH_targetSales;	// 하반기 목표 매출
	
	public String getTeamName() {
		return teamName;
	}
	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}
	public int getTeamNum() {
		return teamNum;
	}
	public void setTeamNum(int teamNum) {
		this.teamNum = teamNum;
	}
	public float getFH_targetOrder() {
		return FH_targetOrder;
	}
	public void setFH_targetOrder(float fH_targetOrder) {
		FH_targetOrder = fH_targetOrder;
	}
	public float getFH_targetSales() {
		return FH_targetSales;
	}
	public void setFH_targetSales(float fH_targetSales) {
		FH_targetSales = fH_targetSales;
	}
	public float getSH_targetOrder() {
		return SH_targetOrder;
	}
	public void setSH_targetOrder(float sH_targetOrder) {
		SH_targetOrder = sH_targetOrder;
	}
	public float getSH_targetSales() {
		return SH_targetSales;
	}
	public void setSH_targetSales(float sH_targetSales) {
		SH_targetSales = sH_targetSales;
	}
	
	
}
