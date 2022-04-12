package co.kr.teamb.dto;

import java.sql.Timestamp;

public class NoticeDTO {
  private int id;
  private String subject;
  private String writer;
  private String content;
  private Timestamp regdate;
  private int readcount;
  private String intent;
  
public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public String getSubject() {
	return subject;
}
public void setSubject(String subject) {
	this.subject = subject;
}
public String getWriter() {
	return writer;
}
public void setWriter(String writer) {
	this.writer = writer;
}
public String getContent() {
	return content;
}
public void setContent(String content) {
	this.content = content;
}
public Timestamp getRegdate() {
	return regdate;
}
public void setRegdate(Timestamp regdate) {
	this.regdate = regdate;
}
public int getReadcount() {
	return readcount;
}
public void setReadcount(int readcount) {
	this.readcount = readcount;
}
public String getIntent() {
	return intent;
}
public void setIntent(String intent) {
	this.intent = intent;
}
  
 
  
  
}
