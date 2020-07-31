package jsp.sheet.method;

import java.net.URL;
import java.util.List;

import com.google.gdata.client.spreadsheet.SpreadsheetService;
import com.google.gdata.data.spreadsheet.CellEntry;
import com.google.gdata.data.spreadsheet.CellFeed;
import com.google.gdata.data.spreadsheet.SpreadsheetEntry;
import com.google.gdata.data.spreadsheet.SpreadsheetFeed;
import com.google.gdata.data.spreadsheet.WorksheetEntry;

public class sheetBean {
	
	public sheetBean() {}
	
	private String FileName = "SureSoft-PMS";
	


	private SpreadsheetService service;	//
	private SpreadsheetFeed feed;	//
	private SpreadsheetEntry entry;
	private List<SpreadsheetEntry> spreadsheets;
	private List<WorksheetEntry> worksheets;
	private WorksheetEntry worksheet;
//	private URL cellFeedUrl;
//	private CellFeed cellFeed;
//	private CellEntry cell;
	
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
	
	
//	public URL getCellFeedUrl() {
//		return cellFeedUrl;
//	}
//	public void setCellFeedUrl(URL cellFeedUrl) {
//		this.cellFeedUrl = cellFeedUrl;
//	}
//	
//	
//	public CellFeed getCellFeed() {
//		return cellFeed;
//	}
//	public void setCellFeed(CellFeed cellFeed) {
//		this.cellFeed = cellFeed;
//	}
//	
//	
//	public CellEntry getCell() {
//		return cell;
//	}
//	public void setCell(CellEntry cell) {
//		this.cell = cell;
//	}

}
