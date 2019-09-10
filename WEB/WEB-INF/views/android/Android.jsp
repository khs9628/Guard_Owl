<%@page import="java.util.ArrayList"%>
<%@page import="org.board.Android.*"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
   
   String returns = "";
   String type = request.getParameter("type"); 
   System.out.print(type);
   if(type == null) return;
   
   else if (type.equals("login_list")){
	   
	   String request_id = request.getParameter("login_list");
	   String request_pw = request.getParameter("pw_list");
	   System.out.println(request_id +"\t" + request_pw);
	   System.out.println(type);
	   
	      System.out.println("값을 리턴합니다.");
	      Login_Board vision_board = Login_Board.getLogin_Board();
	      returns = vision_board.select(request_id, request_pw);
	      out.println(returns);
	     System.out.println(returns);
	   }
   
   else if (type.equals("signUp_write")) {
	   
	   String name = request.getParameter("signUp_write");
	   String id = request.getParameter("id_write");
	   String email = request.getParameter("email_write");
	   String pw = request.getParameter("pw_write");
	   String phone = request.getParameter("phone_write");
	   
       System.out.println("값을받았습니다." +name+ '\t' +id+ '\t' +email+ '\t' +pw+ '\t' +phone);
       SignUp_Write vision_board = SignUp_Write.getWrite();
       returns = vision_board.write(name, id, email, pw, phone);
       out.println(returns);
       System.out.println(returns);
    }
   
   else if (type.equals("signUp_list")) {
	   
	   String id_request = request.getParameter("signUp_list");
	   
       System.out.println("값을 리턴합니다.");
       SignUp_Board vision_board = SignUp_Board.getSignUp_Board();
       returns = vision_board.select(id_request);
       out.println(returns);
      System.out.println(returns);
    }
   
   else if (type.equals("findPw_write")) {
	   
	   String pw = request.getParameter("findPw_write");
	   String id = request.getParameter("id_write");
	   
	      System.out.println(type);  
	      System.out.println("값을받았습니다."+pw+"\t"+id);
	      FindPw_Write vision_board = FindPw_Write.getWrite();
	      returns = vision_board.write(pw, id);
	      out.println(returns);
	      System.out.println(returns);
	      response.sendRedirect("/android/AndroidMailSend?mem_id="+id);
	   }
   
   else if (type.equals("findPw_list")) {
	   
	   String request_id = request.getParameter("findPw_list").trim();
	   String request_name = request.getParameter("name_list").trim();
	   String request_phone = request.getParameter("phone_list").trim();
	   System.out.println();
	   System.out.println(request_id+"/"+request_name+"/"+request_phone);
	      System.out.println(type);
	      System.out.println("값을 리턴합니다.");
	      FindPw_Board vision_board = FindPw_Board.getFindPw_Board();
	      returns = vision_board.select(request_id, request_name, request_phone);
	      out.println(returns);
	     System.out.println(returns);
	   }
   
   else if (type.equals("reviseInfo_list")) {
		  
		  String id_request = request.getParameter("reviseInfo_list"); 
		  
		  System.out.println(type);
	       System.out.println("값을 리턴합니다.");
	       ReviseInfo_Board vision_board = ReviseInfo_Board.getReviseInfo_Board();
	       returns = vision_board.select(id_request);
	       out.println(returns);
	      System.out.println(returns);
	    }
	else if (type.equals("reviseInfo_write")) {
		   
		   String value = request.getParameter("reviseInfo_write");
		   String index = request.getParameter("index_write");
		   String mem_no = request.getParameter("mem_no_write");
		   
		   System.out.println(type);
	       System.out.println("값을받았습니다." +value+ '\t' +index+ '\t' +mem_no);
	       ReviseInfo_Write vision_board = ReviseInfo_Write.getWrite();
	       returns = vision_board.write(value, index, mem_no);
	       out.println(returns);
	       System.out.println(returns);
	    }
   else if (type.equals("inquire_list")) {
	   
	   String request_id = request.getParameter("inquire_list");
	   
	   System.out.println(type);
       System.out.println("값을받았습니다." +request_id);
       Inquire_Board vision_board = Inquire_Board.getInquire_Board();
	   returns = vision_board.select(request_id);
	   out.println(returns);
	   System.out.println(returns);
    }
	else if (type.equals("notification_list")) {
		   
		   String request_id = request.getParameter("notification_list");
		   
		   System.out.println(type);
	       System.out.println("값을받았습니다." +request_id);
	       Notification_Board vision_board = Notification_Board.getNotification_Board();
		   returns = vision_board.select(request_id);
		   out.println(returns);
		   System.out.println(returns);
	    }
	else if (type.equals("free_board_list")) {
		   
		   String request_id = request.getParameter("free_board_list");
		   
		   System.out.println(type);
	       System.out.println("값을받았습니다." +request_id);
	       FreeBoard_Board vision_board = FreeBoard_Board.getFreeBoard_Board();
		   returns = vision_board.select(request_id);
		   out.println(returns);
		   System.out.println(returns);
	    }
	else if (type.equals("board_write")) {
		   
		   String request_id = request.getParameter("board_write");
		   
		   System.out.println(type);
	       System.out.println("값을받았습니다." +request_id);
	       Board_Write vision_board = Board_Write.getWrite();
		   returns = vision_board.write(request_id);
		   out.println(returns);
		   System.out.println(returns);
	    }
	else if (type.equals("comment_list")) {
		   
		   String brd_id = request.getParameter("comment_list");
		   
		   System.out.println(type);
	       System.out.println("값을받았습니다." +brd_id);
	       Comment_Board vision_board = Comment_Board.getComment_Board();
		   returns = vision_board.select(brd_id);
		   out.println(returns);
		   System.out.println(returns);
	    }
	else if (type.equals("comment_write")) {
		   
		   String brd_id = request.getParameter("comment_write");
		   String cmt_writer = request.getParameter("cmt_writer");
		   String cmt_content = request.getParameter("cmt_content");
		   
		   System.out.println(type);
	       System.out.println("값을받았습니다." +brd_id+"\t"+cmt_writer+"\t"+cmt_content);
	       Comment_Write vision_board = Comment_Write.getWrite();
		   returns = vision_board.write(brd_id, cmt_writer, cmt_content);
		   out.println(returns);
		   System.out.println(returns);
	    }
	else if (type.equals("free_board_write")) {
		   
		   String id = request.getParameter("free_board_write");
		   String subject = request.getParameter("subject");
		   String content = request.getParameter("content");
		   
		   System.out.println(type);
	       System.out.println("값을받았습니다." +id+"\t"+subject+"\t"+content);
	       FreeBoard_Write vision_board = FreeBoard_Write.getWrite();
		   returns = vision_board.write(id, subject, content);
		   out.println(returns);
		   System.out.println(returns);
	    }
	else if (type.equals("safe_list")) {
		   
		   String request_id = request.getParameter("safe_list");
		   
		   System.out.println(type);
	       System.out.println("값을받았습니다." +request_id);
	       Safe_Board vision_board = Safe_Board.getReceipt_Board();
		   returns = vision_board.select(request_id);
		   out.println(returns);
		   System.out.println(returns);
	    }
	else if (type.equals("receipt_write")) {
		   
		   String id = request.getParameter("receipt_write");
		   String safe_no = request.getParameter("safe_no");
		   String content = request.getParameter("content");
		   
		   System.out.println(type);
	       System.out.println("값을받았습니다." +id+"\t"+safe_no+"\t"+content);
	       Receipt_Write vision_board = Receipt_Write.getWrite();
		   returns = vision_board.write(id, safe_no, content);
		   out.println(returns);
		   System.out.println(returns);
	    }
	else if (type.equals("receipt_list")) {
		   
		   String request_id = request.getParameter("receipt_list");
		   
		   System.out.println(type);
	       System.out.println("값을받았습니다." +request_id);
	       Receipt_Board vision_board = Receipt_Board.getReceipt_Board();
		   returns = vision_board.select(request_id);
		   out.println(returns);
		   System.out.println(returns);
	    }
	else if (type.equals("keep_write")) {
		   
		   String id = request.getParameter("keep_write");
		   String safe_no = request.getParameter("safe_no");
		   String item_name = request.getParameter("name");
		   String item_class = request.getParameter("class");
		   String item_remark = request.getParameter("remark");
		   String item_content = request.getParameter("content");
		   
		   System.out.println(type);
	       System.out.println("값을받았습니다." +id+"\t"+safe_no+"\t"+item_name+"\t"+item_class+"\t"+item_remark+"\t"+item_content);
	       Keep_Write vision_board = Keep_Write.getWrite();
		   returns = vision_board.write(id, safe_no, item_name, item_class, item_remark, item_content);
		   out.println(returns);
		   System.out.println(returns);
	    }
	else if (type.equals("keep_list")) {
		   
		   String request_id = request.getParameter("keep_list");
		   
		   System.out.println(type);
	       System.out.println("값을받았습니다." +request_id);
	       Keep_Board vision_board = Keep_Board.getKeep_Board();
		   returns = vision_board.select(request_id);
		   out.println(returns);
		   System.out.println(returns);
	    }
	else if (type.equals("record_list")) {
		   
		   String request_id = request.getParameter("record_list");
		   
		   System.out.println(type);
	       System.out.println("값을받았습니다." +request_id);
	       Record_Board vision_board = Record_Board.getRecord_Board();
		   returns = vision_board.select(request_id);
		   out.println(returns);
		   System.out.println(returns);
	    }
	else if (type.equals("record_write")) {
		   
		   String app_no = request.getParameter("record_write");
		   
		   System.out.println(type);
	       System.out.println("값을받았습니다." +app_no);
	       Record_Write vision_board = Record_Write.getWrite();
		   returns = vision_board.write(app_no);
		   out.println(returns);
		   System.out.println(returns);
	    }
	else if (type.equals("service_list")) {
		   
		   String request_id = request.getParameter("service_list");
		   
		   System.out.println(type);
	       System.out.println("값을받았습니다." +request_id);
	       Service_Board vision_board = Service_Board.getService_Board();
		   returns = vision_board.select(request_id);
		   out.println(returns);
		   System.out.println(returns);
	    }
   
 	 else if (type.equals("nfc_list")){		  
 		 
		   String request_id = request.getParameter("nfc_list");
		   
		   System.out.println(type);
		   System.out.println("id: "+request_id);
		   System.out.println("값을 리턴합니다.");
		   NFC_Board vision_board = new NFC_Board();
		   returns = vision_board.run();
		   out.println(returns);
		   System.out.println(returns);
	   }
   
 	else if (type.equals("nfc_write")) {
		   
		   String id = request.getParameter("nfc_write");
		   String app_no = request.getParameter("app_no");
		   
		   System.out.println(type);
	       System.out.println("값을받았습니다." +id);
	       NFC_Write vision_board = NFC_Write.getWrite();
		   returns = vision_board.write(id);
		   out.println(returns);
		   System.out.println(returns);
	    }
%>
   