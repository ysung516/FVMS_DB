package jsp.Bean.model;

import java.util.List;

import com.google.gdata.client.spreadsheet.SpreadsheetService;
import com.google.gdata.data.spreadsheet.SpreadsheetEntry;
import com.google.gdata.data.spreadsheet.SpreadsheetFeed;
import com.google.gdata.data.spreadsheet.WorksheetEntry;

public class backUpBean {
	
	public backUpBean() {}
	
	private String FileName = "주간보고서백업";
	


	private SpreadsheetService service;	//
	private SpreadsheetFeed feed;	//
	private SpreadsheetEntry entry;
	public String getFileName() {
		return FileName;
	}
	public void setFileName(String fileName) {
		FileName = fileName;
	}
	public SpreadsheetService getService() {
		return service;
	}
	public void setService(SpreadsheetService service) {
		this.service = service;
	}
	public SpreadsheetFeed getFeed() {
		return feed;
	}
	public void setFeed(SpreadsheetFeed feed) {
		this.feed = feed;
	}
	public SpreadsheetEntry getEntry() {
		return entry;
	}
	public void setEntry(SpreadsheetEntry entry) {
		this.entry = entry;
	}
	public List<SpreadsheetEntry> getSpreadsheets() {
		return spreadsheets;
	}
	public void setSpreadsheets(List<SpreadsheetEntry> spreadsheets) {
		this.spreadsheets = spreadsheets;
	}
	public List<WorksheetEntry> getWorksheets() {
		return worksheets;
	}
	public void setWorksheets(List<WorksheetEntry> worksheets) {
		this.worksheets = worksheets;
	}
	public WorksheetEntry getWorksheet() {
		return worksheet;
	}
	public void setWorksheet(WorksheetEntry worksheet) {
		this.worksheet = worksheet;
	}

	private List<SpreadsheetEntry> spreadsheets;
	private List<WorksheetEntry> worksheets;
	private WorksheetEntry worksheet;
}
