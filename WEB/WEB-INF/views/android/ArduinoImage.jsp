<%@page import="java.util.ArrayList"%>
<%@page import="org.board.Android.*"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
	 String saveDir = "/usr/local/tomcat9/upload/Arduino/"; 
    /* String saveDir = "/usr/local/tomcat9/upload/Arduino"; */
	 String downloagURL = "https://ko.wikipedia.org/wiki/%EC%9E%90%EB%B0%94_(%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%98%EB%B0%8D_%EC%96%B8%EC%96%B4)";
	String typeRgx = "(jpg|png|jpeg)";
	
	AuduinoImage.getTypedFileDown(downloagURL, saveDir, typeRgx);
	
	response.sendRedirect("/android/Video");
	
	
%>