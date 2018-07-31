<%@page import="java.util.regex.Pattern"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html; charset=euc-kr" %>
<%@page import="java.sql.*"%>

<HTML>
    <HEAD>
        <TITLE>데이터베이스 연결 및 동적 테이블 출력 실험</TITLE><script src="http://code.jquery.com/jquery-latest.js"></script></HEAD>

    <table border="0">
    
        <thead>
            <tr>
                <th><font size="18">The Temperature Display of Refrigerators and Freezers</font></th>
            </tr>
        </thead>
        
        <tbody>
            <tr>
                <td><font size="6">Please insert you selection criteria below.</font></td>
            </tr>
            <tr>
                <td>
                <form id="form1" action="Update.jsp">
                        <strong><font size="4">Select a Department:</font></strong>
                        <select id="department" name="department">
                            <option>Serology</option>
                            <option>Immunology</option>
                            <option>Biochemistry</option>
                            <option>Microbiology</option>
                            <option>MolecularG</option>
                            <option>Blood Bank</option>
                            <option>Hematology</option>   
                        </select>
                        <strong><font size="4">Start Time (YYYY-MM-DD HH:MM:SS):</font></strong>
                        <input id="startTime" type="datetime-local" name="startTime">
                        <strong><font size="4">End Time (YYYY-MM-DD HH:MM:SS):</font></strong>
                        <input id="endTime" type="datetime-local" name="endTime">
                        <input id="submit" type="submit" value="Submit" />
                    </form>
                </td>
            </tr>            
        </tbody>
    </table>

    <%	String startTime = request.getParameter("startTime");
        String currentTime = request.getParameter("endTime");
        String department = request.getParameter("department");

        if (department == null || startTime == null || currentTime == null) {
            startTime = startTime();
            currentTime = currentDate();
            department = "Serology";
        }

        Connection conn = null;
        Statement stmt1 = null;
        Statement stmt2 = null;
        Statement stmt3 = null;
        Statement stmt4 = null;
        Statement stmt5 = null;
        Statement stmt6 = null;
        Statement stmt7 = null;
        Statement stmt8 = null;
        Statement stmt9 = null;
        Statement stmt10 = null;
        Statement stmt11 = null;
        Statement stmt12 = null;
        Statement stmt13 = null;
        Statement stmt14 = null;
        Statement stmt15 = null;
        Statement stmt16 = null;
        Statement stmt17 = null;
        Statement stmt18 = null;
        Statement stmt19 = null;
        Statement stmt20 = null;
        Statement stmt21 = null;
        Statement stmt22 = null;
        Statement stmt23 = null;
        Statement stmt24 = null;
        Statement stmt25 = null;
        Statement stmt26 = null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/information?useSSL=false", "vindy", "1234");
            if (conn == null) {
                throw new Exception("데이터베이스에 연결할 수 없습니다.<BR>");
            }
            
            stmt1 = conn.createStatement();
            stmt2 = conn.createStatement();
            stmt3 = conn.createStatement();
            stmt4 = conn.createStatement();
            stmt5 = conn.createStatement();
            stmt6 = conn.createStatement();
            stmt7 = conn.createStatement();
            stmt8 = conn.createStatement();
            stmt9 = conn.createStatement();
            stmt10 = conn.createStatement();
            stmt11 = conn.createStatement();
            stmt12 = conn.createStatement();
            stmt13 = conn.createStatement();
            stmt14 = conn.createStatement();
            stmt15 = conn.createStatement();
            stmt16 = conn.createStatement();
            stmt17 = conn.createStatement();
            stmt18 = conn.createStatement();
            stmt19 = conn.createStatement();
            stmt20 = conn.createStatement();
            stmt21 = conn.createStatement();
            stmt22 = conn.createStatement();
            stmt23 = conn.createStatement();
            stmt24 = conn.createStatement();
            stmt25 = conn.createStatement();
            stmt26 = conn.createStatement();
    %>	 

    <BODY>
    <input type="button" value="목록" OnClick="location.href = 'list.jsp'">
        <form name="form">
            <style>  
                .mytable { border-collapse:collapse; }  
                .mytable th, .mytable td { borders:1px solid black; }
            </style>
            <% //1줄 %> 
            <table class='mytable' width ='1800' border='1' >  
                <th rowspan='2' width='200'>로고 삽입<input type='checkbox'></th> 
                <th colspan='4' rowspan='2' width='1600' height='100'><br><font size="5">0000 종합(대학)병원</font><br><br><div style="text-align:right; font-weight:normal;"><input type='checkbox'>교정 값 적용</div></th> 
                <th width='150' height='30'>작 성</th> 
                <th width='150' height='30'>검 토</th> 
                <th width='150' height='30'>승 인</th>
                <tr>
                    <th align='center' width='150' height='70'>전자결재 <input type='checkbox'></th>
                    <th align='center' width='150' height='70'>전자결재 <input type='checkbox'></th>
                    <th align='center' width='150' height='70'>전자결재 <input type='checkbox'></th>
                </tr>
                <tr>
                    <th colspan='9' align='center' ><font size="20" face="Courier New" ><%=department%></th>
                </tr>                  
                <tr>
                    <th align='center' width='200'>냉장/냉동고 번호</th>
                        <%
                            ResultSet rs13 = stmt13.executeQuery("select refnumber from refdata where applicationPart='" + department + "';");
                            while (rs13.next()) {
                                String RefNumber = rs13.getString("RefNumber");
                        %>
                    <td align='center' width='150'><%=RefNumber%> <a href=Modify.jsp?RefNumber=<%=RefNumber%>>수정</a> <a href=delete.jsp?RefNumber=<%=RefNumber%>>삭제</a> </td>
                    <%
                        }
                    %>
                </tr>
                <tr>
                    <th align='center' width='200'>적용 기자재</th>
                        <%  ResultSet rs14 = stmt14.executeQuery("select equipment from refdata where applicationPart='" + department + "';");
                            while (rs14.next()) {
                                String equipment = rs14.getString("equipment");
                        %>
                    <td align='center' width='150'><%=equipment%></td>
                    <%
                        }
                    %>
                </tr>
                <tr>
                    <th align='center' width='200'>Site number</th>
                        <%  ResultSet rs15 = stmt15.executeQuery("select SiteNumber from refdata where applicationPart='" + department + "';");
                            while (rs15.next()) {
                                String SiteNumber = rs15.getString("SiteNumber");
                        %>
                    <td align='center' width='150'><%=SiteNumber%></td>
                    <%
                        }
                    %>
                </tr>
                <tr>
                    <th align='center' width='200'>검교정 일자(냉장/냉동고)</th>
                        <%  ResultSet rs16 = stmt16.executeQuery("select reffredate from refdata where applicationPart='" + department + "';");
                            while (rs16.next()) {
                                String reffredate = rs16.getString("reffredate");
                        %>
                    <td align='center' width='150'><%=reffredate%></td>
                    <%
                        }
                    %>
                </tr>
                <tr>
                    <th align='center' width='150' bgcolor='gray'>온습도 센서</th>
                    <th></th>
                </tr>
                <tr>
                    <th align='center' width='200'>Module model</th>
                        <%  ResultSet rs17 = stmt17.executeQuery("select ModuleModel from refdata where applicationPart='" + department + "';");
                            while (rs17.next()) {
                                String ModuleModel = rs17.getString("ModuleModel");
                        %>
                    <td align='center' width='150'><%=ModuleModel%></td>
                    <%
                        }
                    %>
                </tr>
                <tr>
                    <th align='center' width='200'>Module serial number</th>
                        <%  ResultSet rs18 = stmt18.executeQuery("select ModuleSerialNumber from refdata where applicationPart='" + department + "';");
                            while (rs18.next()) {
                                String ModuleSerialNumber = rs18.getString("ModuleSerialNumber");
                        %>
                    <td align='center' width='150'><%=ModuleSerialNumber%></td>
                    <%
                        }
                    %>
                <tr>
                    <th align='center' width='200'>시약 종류</th>
                        <%  ResultSet rs19 = stmt19.executeQuery("select TypeOfReagent from refdata where applicationPart='" + department + "';");
                            while (rs19.next()) {
                                String TypeOfReagent = rs19.getString("TypeOfReagent");
                        %>
                    <td align='center' width='150'><%=TypeOfReagent%></td>
                    <%
                        }
                    %>
                </tr>
                <tr>
                    <th align='center' width='200'>검교정 값</th>
                        <%  ResultSet rs20 = stmt20.executeQuery("select Correction from refdata where applicationPart='" + department + "';");
                            while (rs20.next()) {
                                String Correction = rs20.getString("Correction");
                        %>
                    <td align='center' width='150' bgcolor='gray'><%=Correction%></td>
                    <%
                        }
                    %>
                </tr>
                <tr>
                    <th align='center' width='200'>검교정 일자</th>
                        <%  ResultSet rs21 = stmt21.executeQuery("select date from refdata where applicationPart='" + department + "';");
                            while (rs21.next()) {
                                String date = rs21.getString("date");
                        %>
                    <td align='center' width='150'><%=date%></td>
                    <%
                        }
                    %>
                </tr>
                <tr>
                    <th align='center' width='200'>설정온도(℃)</th>
                        <%  ResultSet rs22 = stmt22.executeQuery("select SettingTemperature from refdata where applicationPart='" + department + "';");
                            while (rs22.next()) {
                                String SettingTemperature = rs22.getString("SettingTemperature");
                        %>
                    <td align='center' width='150' bgcolor='gray'><font color='red'><%=SettingTemperature%></td>
                        <%
                            }
                        %>
                </tr>
                <tr>
                    <th align='center' width='200'>Unit</th>
                        <%  ResultSet rs23 = stmt23.executeQuery("select Unit from refdata where applicationPart='" + department + "';");
                            while (rs23.next()) {
                                String Unit = rs23.getString("Unit");
                        %>
                    <td align='center' width='150'><%=Unit%></td>
                    <%
                        }
                    %>
                </tr>
                <tr>
                    <th align='center' width='200'>Average</th>
                        <%
                            ResultSet rs1 = stmt1.executeQuery("Select * from refData where applicationPart='" + department + "';");
                            while (rs1.next()) {
                                String refN = rs1.getString("refNumber");
                                //System.out.println(refN);
                                ResultSet rs2 = stmt2.executeQuery("SELECT AVG(Temp) FROM " + refN + " where date between '" + startTime + "' and '" + currentTime + "';");
                                //System.out.println("SELECT AVG(Temp) FROM " + refN + " where date between '" + startTime + "' and '" + currentTime + "';");
                                while (rs2.next()) {
                                    String refavg = rs2.getString("AVG(Temp)");
                        %>
                    <td align='center' width='150'><%=refavg%></td>
                    <%
                            }
                        }
                    %>
                </tr>
                <tr>
                    <th align='center' width='200'>Maximum</th>
                        <%      ResultSet rs3 = stmt3.executeQuery("Select * from refData where applicationPart='" + department + "';");
                            while (rs3.next()) {
                                String refN = rs3.getString("refNumber");
                                ResultSet rs4 = stmt4.executeQuery("select max(temp) from " + refN + " where date between '" + startTime + "' and '" + currentTime + "';");
                                //System.out.println("select max(temp) from " + refN + " where date between '" + startTime + "' and '" + currentTime + "';");
                                while (rs4.next()) {
                                    String refmax = rs4.getString("max(Temp)");
                        %>
                    <td align='center' width='150'><%=refmax%></td>
                    <%
                            }
                        }
                    %>
                </tr>
                <tr>
                    <th align='center' width='200'>Minimum</th>
                        <%      ResultSet rs5 = stmt5.executeQuery("Select * from refData where applicationPart='" + department + "';");
                            while (rs5.next()) {
                                String refN = rs5.getString("refNumber");
                                ResultSet rs6 = stmt6.executeQuery("select min(temp) from " + refN + " where date between '" + startTime + "' and '" + currentTime + "';");
                                while (rs6.next()) {
                                    String refmin = rs6.getString("min(Temp)");
                        %>
                    <td align='center' width='150'><%=refmin%></td>
                    <%
                            }
                        }
                    %>
                </tr>
                <tr>
                    <th align='center' width='200'>Temperature Data</th>
                        <%
                            ResultSet rs7 = stmt7.executeQuery("Select * from refData where applicationPart='" + department + "';");
                            while (rs7.next()) {
                                String refN = rs7.getString("refNumber");
                                String setTemp = rs7.getString("settingTemperature");
                                String[] tempRange = setTemp.split(Pattern.quote("~"));
                                double min = Double.parseDouble(tempRange[0]);
                                double max = Double.parseDouble(tempRange[1]);
                                ResultSet rs8 = stmt8.executeQuery("select * from " + refN + " where date between '" + startTime + "' and '" + currentTime + "';");
                        %>
                    <td valign='top' width='150'>
                        <table border="1">
                            <thead><tr><th>Time</th><th>Temp</th></tr></thead>
                                        <%                                while (rs8.next()) {
                                                String timer1 = rs8.getString("Date");
                                                String tempr1 = rs8.getString("Temp");
                                                double intTemp = Double.parseDouble(tempr1);
                                                if (intTemp < min || intTemp > max) {
                                        %>
                            <tbody><tr><td align='center' width='100' style="color: red;" ><%=timer1%></td><td align='center' width='50' style="color: red;"><%=tempr1%></td></tr></tbody>
                                        <% } else {
                                        %>
                            <tbody><tr><td align='center' width='100' ><%=timer1%></td><td align='center' width='50' ><%=tempr1%></td></tr></tbody>
                                        <%
                                                }
                                            }
                                        %>
                        </table>
                    </td>
                    <%
                        }
                    %>
                </tr>
                <tr>
                    <th align='center' width='200'>Battery Status</th>          
                        <%
                            ResultSet rs9 = stmt9.executeQuery("Select * from refData where applicationPart='" + department + "';");
                            while (rs9.next()) {
                                String refN = rs9.getString("refNumber");
                                ResultSet rs10 = stmt10.executeQuery("SELECT * FROM " + refN + " ORDER BY date DESC LIMIT 1;");
                                String batteryState = "";
                                while (rs10.next()) {
                                    batteryState = rs10.getString("BatteryState");
                                }
                                if (batteryState.equals("LOWB")) {
                        %>
                    <td valign='top' width='150' style="background-color:#F4765A"><b>Battery Low</b></td>
                    <%
                    } else if (batteryState.equals("GOOD")) {
                    %>
                    <td valign='top' width='150' style="background-color:#8BBF51"></td>
                    <%
                    } else {
                    %>
                    <td valign='top' width='150'>No Information</td>
                    <%
                            }
                        }
                    %>
                </tr>
                <tr>
                    <th align='center' width='200'>Data Out of Range</th>
                        <%
                            ResultSet rs11 = stmt11.executeQuery("Select * from refData where applicationPart='" + department + "';");
                            while (rs11.next()) {
                                String setTemp = rs11.getString("settingTemperature");
                                String[] tempRange = setTemp.split(Pattern.quote("~"));
                                double min = Double.parseDouble(tempRange[0]);
                                double max = Double.parseDouble(tempRange[1]);
                                String refN = rs11.getString("refNumber");
                                ResultSet rs12 = stmt12.executeQuery("select * from " + refN + " where date between '" + startTime + "' and '" + currentTime + "';");
                        %>
                    <td valign='top' width='150'>
                        <table border="1">
                            <thead><tr><th>Time</th><th>Temp</th></tr></thead>
                                        <%                                while (rs12.next()) {
                                                String timer1 = rs12.getString("Date");
                                                String tempr1 = rs12.getString("Temp");
                                                double dTempr1 = Double.parseDouble(tempr1);
                                                if (dTempr1 < min || dTempr1 > max) {
                                        %>
                            <tbody><tr><td align='center' width='100' ><%=timer1%></td><td align='center' width='50' ><%=tempr1%></td></tr></tbody>
                                        <% }
                                            }
                                        %>
                        </table>
                    </td>
                    <%                }
                    %>
                </tr>
              
                <tr>
                    <th align='center' width='200'>Missing Data</th>
                </tr>
                <tr>
                    <th align='center' width='200'>점 검 자</th> 
                        <%  ResultSet rs25 = stmt25.executeQuery("select Insepctor from refdata where applicationPart='" + department + "';");
                            while (rs25.next()) {
                                String Insepctor = rs25.getString("Insepctor");
                        %>
                    <td align='center' width='150'><%=Insepctor%> <input type='checkbox'></td>
                        <%
                            }
                        %>
                </tr>
                <tr>
                    <th align='center' width='200'>확 인 자</th>
                        <%  ResultSet rs26 = stmt26.executeQuery("select AccessRight from refdata where applicationPart='" + department + "';");
                            while (rs26.next()) {
                                String AccessRight = rs26.getString("AccessRight");
                        %>
                    <td align='center' width='150'><%= AccessRight%> <input type='checkbox'></td>
                        <%
                            }
                        %>
                </tr>  
                <tbody></tbody>
            </Table> 
            <%
                } finally {
                    try {
                        stmt1.close();
                        stmt2.close();
                        stmt3.close();
                        stmt4.close();
                        stmt5.close();
                        stmt6.close();
                        stmt7.close();
                        stmt8.close();
                        stmt9.close();
                        stmt10.close();
                        stmt11.close();
                        stmt12.close();
                        stmt13.close();
                        stmt14.close();
                        stmt15.close();
                        stmt16.close();
                        stmt17.close();
                        stmt18.close();
                        stmt19.close();
                        stmt20.close();
                        stmt21.close();
                        stmt22.close();
                        stmt23.close();
                        stmt24.close();
                        stmt25.close();
                        stmt26.close();
                    } catch (Exception ignored) {
                    }
                    try {
                        conn.close();
                    } catch (Exception ignored) {

                    }
                }
            %>
            <%!
                private String toUnicode(String str) {
                    //ISO-8859-1 문자열을 Unicode 문자열로 바꾸는 메서드
                    try {
                        byte[] b = str.getBytes("ISO-8859-1");
                        return new String(b);
                    } catch (java.io.UnsupportedEncodingException uee) {
                        System.out.println(uee.getMessage());
                        return null;
                    }
                }
                public static String currentDate() {
                    Date now = new Date(System.currentTimeMillis());
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    String currentDate = sdf.format(now);
                    //String currentDate = "2018-02-27 18:21:16";
                    return currentDate;
                }
                public static String startTime() {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    Date prev = new Date(System.currentTimeMillis() - 8 * 3600 * 1000);
                    String prevDate = sdf.format(prev);
                    //String prevDate = "2018-02-27 17:39:55";
                    return prevDate;
                }
            %>
            <div style="overflow:scroll; width:4000px; height:150px;">
            </div> 
        </form>
    </BODY>
</HTML>