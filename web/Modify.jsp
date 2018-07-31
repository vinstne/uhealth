<%@page contentType="text/html; charset=utf-8" %>
<%@page import="java.sql.*"%>

<HTML>
    <head>
        <TITLE>데이터베이스 연결 및 동적 테이블 출력 실험</TITLE><script src="http://code.jquery.com/jquery-latest.js"></script></HEAD>
</head>
<BODY>
    <%	
    			request.setCharacterEncoding("utf-8");
        		String RefNumber = request.getParameter("RefNumber");
        		
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection(
                            "jdbc:mysql://localhost:3306/information", "vindy", "1234");
                    if (conn == null) {
                        throw new Exception("데이터베이스에 연결할 수 없습니다.<BR>");
                    }
                    
                    String sql="select * from refdata where RefNumber=?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, RefNumber);
                    rs = pstmt.executeQuery();
                    
                    while(rs.next()){
                    String equipment=rs.getString("equipment");
                	String SiteNumber=rs.getString("SiteNumber");
                	String reffredate=rs.getString("reffredate");
                	String ModuleModel=rs.getString("ModuleModel");
                	String ModuleSerialNumber=rs.getString("ModuleSerialNumber");
                	String TypeOfReagent=rs.getString("TypeOfReagent");
                	String Correction=rs.getString("Correction");
                	String date=rs.getString("date");
                	String SettingTemperature=rs.getString("SettingTemperature");
                	String Unit=rs.getString("Unit");
                	String ApplicationPart=rs.getString("ApplicationPart");
                	String Insepctor=rs.getString("Insepctor");
                	String AccessRight=rs.getString("AccessRight");
            %>	
        <form name="frm1" method="post" action="ModifyOK.jsp">

                <style>  
                    .mytable { border-collapse:collapse; }  
                    .mytable th, .mytable td { borders:1px solid black; }
                </style>
                
                <center> 
                 
                <table class='mytable' width ='350' border='1' >  
                    <th colspan='4' width='350' height='100'><font size="5">0000 종합(대학)병원</font></th>                     
                    	<tr>
                        <th align='center' width='200'>냉장/냉동고 번호</th>
                        <td align='center' width='150'><%=RefNumber%><input type="hidden" name="RefNumber" value="<%=RefNumber%>"/></td>
                   		</tr>
                    	<tr>
                        <th align='center' width='200'>적용 기자재</th>
                        <td align='center' width='150'><input type="text" name="equipment" value="<%=equipment%>"/></td>
                        </tr>
                   		<tr>
                        <th align='center' width='200'>Site number</th>
                        <td align='center' width='150'><input type="text" name="SiteNumber" value="<%=SiteNumber%>"/></td>
                        </tr>
                   		<tr>
                        <th align='center' width='200'>검교정 일자(냉장/냉동고)</th>
                        <td align='center' width='150'><input type="text" name="reffredate" value="<%=reffredate%>"/></td>
                        </tr>
                   		<tr>
                        <th align='center' width='150' bgcolor='gray'>온습도 센서</th>
                        <td align='center' width='150'></td>
                        </tr>
                   		<tr>
                        <th align='center' width='200'>Module model</th>
                        <td align='center' width='150'><input type="text" name="ModuleModel" value="<%=ModuleModel%>"/></td>
                        </tr>
                   		<tr>
                        <th align='center' width='200'>Module serial number</th>
                        <td align='center' width='150'><input type="text" name="ModuleSerialNumber" value="<%=ModuleSerialNumber%>"/></td>
                        </tr>
                   		<tr>
                        <th align='center' width='200'>시약 종류</th>
                        <td align='center' width='150'><input type="text" name="TypeOfReagent" value="<%=TypeOfReagent%>"/></td>
                        </tr>
                   		<tr>
                        <th align='center' width='200'>검교정 값</th>
                        <td align='center' width='150' bgcolor='gray'><input type="text" name="Correction" value="<%=Correction%>"/></td>
                        </tr>
                   		<tr>
                        <th align='center' width='200'>검교정 일자</th>
                        <td align='center' width='150'><input type="text" name="date" value="<%=date%>"/></td>
                        </tr>
                   		<tr>
                        <th align='center' width='200'>설정온도(℃)</th>
                        <td align='center' width='150' bgcolor='gray'><input type="text" name="SettingTemperature" value="<%=SettingTemperature%>"/></td>
                        </tr>
                   		<tr>
                        <th align='center' width='200'>Unit</th>
                        <td align='center' width='150'><input type="text" name="Unit" value="<%=Unit%>"/></td>
                        </tr>
                   		<tr>
                        <th align='center' width='200'>부서</th>
                        <td align='center' width='150'><input type="text" name="ApplicationPart" value="<%=ApplicationPart%>"/></td>
                        </tr>
                   		<tr>
                        <th align='center' width='200'>점 검 자</th>
                        <td align='center' width='150'><input type="text" name="Insepctor" value="<%=Insepctor%>"/></td>
                        </tr>
                   		<tr>
                        <th align='center' width='200'>확 인 자</th> 
                        <td align='center' width='150'><input type="text" name="AccessRight" value="<%=AccessRight%>"/></td>
                        </tr>
                        <tr>
                        <th colspan='2'>
                        <input type="button" name="btn1" value="저장" onclick="frm1.submit();"/>
      				 	<input type="button" name="btn2" value="목록" onclick="location.href = 'list.jsp'">
       					<input type="button" name="btn3" value="뒤로가기" onclick="location.href = 'Update.jsp'">
                        </th>
                        </tr>
                    <tbody></tbody>
                </Table> 
                </form>
                
                <%
                }
                    
                    } catch(SQLException se) {
                    	System.out.println(se.getMessage());
                    }finally {
                        try {
                            if(rs!=null) rs.close();
                        	if(pstmt!=null) pstmt.close();
                        	if(conn!=null) conn.close();
                        } catch (SQLException se) {
                        	System.out.println(se.getMessage());
                        } 
                    }
                %>  
<script type="text/javascript">
	function update(){
		document.frm1.submit();
	}
	function list(){
		location.href="Update.jsp";
	}
</script>                         
</BODY>
</HTML>