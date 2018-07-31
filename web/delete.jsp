<%@page contentType="text/html; charset=utf-8" %>
<%@page import="java.sql.*"%>
   <% 
   request.setCharacterEncoding("utf-8");
   
   String RefNumber = request.getParameter("RefNumber");
   if (RefNumber==null)
      RefNumber="";
   
   Connection conn = null;
   PreparedStatement pstmt1 = null;
   PreparedStatement pstmt2 = null;
   PreparedStatement pstmt3 = null;
   
   try
   {
      conn = DriverManager.getConnection(
             "jdbc:mysql://localhost:3306/information","vindy","1234");
      if(conn == null)
          throw new Exception("데이터베이스에 연결할 수 없습니다.<BR>");
      
      String sql = "drop table " + RefNumber;
       pstmt1 = conn.prepareStatement(sql);
       pstmt1.executeUpdate();
       
      String sql1 = "delete from refdata where RefNumber=?";
       pstmt2 = conn.prepareStatement(sql1);
       pstmt2.setString(1,RefNumber);
       pstmt2.executeUpdate();
       
       String sql2="delete from beaconid(TableName) VALUES('"+RefNumber+"')";
        pstmt3 = conn.prepareStatement(sql2);
      pstmt3.executeUpdate();
       
      pstmt1.close();
      pstmt2.close();
      pstmt3.close();
      conn.close();
   }
   
   catch(ClassNotFoundException e)
   {
      out.println(e);
   }
   catch(SQLException e)
   {
      out.println(e);
   }
    response.sendRedirect("list.jsp");
   %>