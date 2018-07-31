<%@page contentType="text/html; charset=euc-kr" %>
<%@page import="java.sql.*"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title> 점검 시간</title>
</head>
<body>
<%
Connection conn = null;
Statement stmt1 = null;
Statement stmt2 = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/information?useSSL=false", "vindy", "1234");
            if (conn == null) {
                throw new Exception("데이터베이스에 연결할 수 없습니다.<BR>");
            }
            stmt1 = conn.createStatement();
            stmt2 = conn.createStatement();
            %>
            <form name="form">
            <style>  
                .mytable { border-collapse:collapse; }  
                .mytable th, .mytable td { borders:1px solid black; }
            </style>
            
            <table class='mytable' align='center' border="0">
            <tr><th><font size='6'>점검 시간</font></th></tr> <input class="button" type="button" value="뒤로가기" OnClick="location.href = 'list.jsp'">
			</table>
            <table class='mytable' border='1' align='center'> 
            <tr>
            		<th align='center' width='200' text-align='center'></th>
                    <th align='center' width='200' text-align='center'>점 검 자</th>
                    <th align='center' width='200' text-align='center'>확 인 자</th>
            </tr>
            <tr> 
            		<th align='center' width='200'>Time</th>
              
                           
                    <td valign='top' width='150' text-align='center'>
                        <table border="1" text-align='center'>    
                         <%  ResultSet rs1 = stmt1.executeQuery("select * from checktime where Name='Inspector';");
                            while (rs1.next()) {
                                String Name = rs1.getString("Name");
                                String Date = rs1.getString("Date");
                                System.out.println(Name);
                                if (Name == "Insepctor"){
                                	%>         
                                    <tr><td><%=Date%></td></tr>   
                                    <%
                                }
                                %>         
                                <tr><td><%=Date%></td></tr>   
                                <%    
                           }      
                           %>          
                        </table>
                    </td>
                    <td valign='top' width='150' text-align='center'>
                        <table border="1" text-align='center'>    
                         <%  ResultSet rs2 = stmt2.executeQuery("select * from checktime where Name='Checker';");
                            while (rs2.next()) {
                                String Name = rs2.getString("Name");
                                String Date = rs2.getString("Date");
                                if (Name == "AccessRight"){
                                	%>         
                                    <tr><td><%=Date%></td></tr>   
                                    <%   
                                }
                                %>         
                                <tr><td><%=Date%></td></tr>   
                                <%  
                           }      
                           %>          
                        </table>
                    </td>
                </tr>
                </table>
<%      
        }finally {
            try {
                stmt1.close();
                stmt2.close();
                } 
            catch (Exception ignored) {
                }
                try {
                    conn.close();
                } catch (Exception ignored) {

                }
            }
        %>
            
</body>
</html>