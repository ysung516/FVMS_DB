package jsp.Bean.model;

public class WorkPlaceBean {
	private int no;
	private String place;
	private String color;
	private int cost;
	public int getCost() {
		return cost;
	}
	public void setCost(int cost) {
		this.cost = cost;
	}
	public int getNo() {
		return no;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
}
