<%@page contentType="text/html; charset=utf-8" %>
<%@page import="java.sql.*"%>

<HTML>
    <HEAD><TITLE>데이터베이스 연결 및 동적 테이블 출력 실험(추가)</TITLE></HEAD>
            <%		Connection conn = null;

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection(
                            "jdbc:mysql://localhost:3306/information", "vindy", "1234");
                    if (conn == null) {
                        throw new Exception("데이터베이스에 연결할 수 없습니다.<BR>");
                    }

            %>	 
    <BODY>
        <form action="save.jsp" method="post">

            <style>  
                .mytable { border-collapse:collapse; }  
                .mytable th, .mytable td { borders:1px solid black; }
            </style>

            <center>

                <table class='mytable' width ='350' border='1'  >  
                    <th colspan='4' width='350' height='100'><font size="5">0000 종합(대학)병원</font></th> 
                    <center>
                        <tr>
                            <th align='center' width='200'>냉장/냉동고 번호</th>
                            <td align='center' width='150'><input type="text" name="RefNumber" maxlength="12" size="12"></td>
                        </tr>
                        <tr>
                            <th align='center' width='200'>적용 기자재</th>
                            <td align='center' width='150'><input type="text" name="equipment" maxlength="12" size="12"></td>
                        </tr>
                        <tr>
                            <th align='center' width='200'>Site number</th>
                            <td align='center' width='150'><input type="text" name="SiteNumber" maxlength="12" size="12"></td>
                        </tr>
                        <tr>
                            <th align='center' width='200'>검교정 일자(냉장/냉동고)</th>
                            <td align='center' width='150'><input type="text" name="reffredate" maxlength="12" size="12"></td>
                        </tr>
                        <tr>
                            <th align='center' width='200'>Module model</th>
                            <td align='center' width='150'><input type="text" name="ModuleModel" maxlength="12" size="12"></td>
                        </tr>
                        <tr>
                            <th align='center' width='200'>Module serial number</th>
                            <td align='center' width='150'><input type="text" name="ModuleSerialNumber" maxlength="12" size="12"></td>	
                        </tr>
                        <tr>
                            <th align='center' width='200'>시약 종류</th>
                            <td align='center' width='150'><input type="text" name="TypeOfReagent" maxlength="15" size="12"></td>	
                        </tr>
                        <tr>
                            <th align='center' width='200'>검교정 값</th>
                            <td align='center' width='150'><input type="text" name="Correction" maxlength="10" size="12"></td>
                        </tr>
                        <tr>
                            <th align='center' width='200'>검교정 일자</th>
                            <td align='center' width='150'><input type="text" name="date" maxlength="12" size="12"></td>
                        </tr>
                        <tr>
                            <th align='center' width='200'>설정온도(℃)</th>
                            <td align='center' width='150'><font color='red'><input type="text" name="SettingTemperature" maxlength="19" size="12"></font></td>
                        </tr>
                        <tr>
                            <th align='center' width='200'>Unit</th>
                            <td align='center' width='150'><input type="text" name="Unit" maxlength="4" size="12"></td>
                        </tr>
                        <tr>
                            <th align='center' width='200'>부서</th>
                            <td align='center' width='150'><input type="text" name="ApplicationPart" maxlength="15" size="12"></td>
                        </tr>
                        <tr>
                            <th align='center' width='200'>점 검 자</th>
                            <td align='center' width='150'><input type="text" name="Insepctor" maxlength="14" size="12"></td>
                        </tr>
                        <tr>
                            <th align='center' width='200'>확 인 자</th>
                            <td align='center' width='150'><input type="text" name="AccessRight" maxlength="14" size="12"></td>
                        </tr>
                        <tr>
                            <th colspan='2'>
                                <input type="submit" value="저 장">
                                <input type="button" value="뒤로가기" OnClick="location.href = 'list.jsp'">
                            </th>
                        </tr>
                        <tbody></tbody>
                </Table> 
                </div>
                <%                    } finally {
                        try {
                        } catch (Exception ignored) {
                        }
                        try {
                        } catch (Exception ignored) {
                        }
                    }
                %>
                <%!
                    private String toUnicode(String str) {

                        try {
                            byte[] b = str.getBytes("ISO-8859-1");
                            return new String(b);
                        } catch (java.io.UnsupportedEncodingException uee) {
                            System.out.println(uee.getMessage());
                            return null;
                        }
                    }
                %>
        </form>
    </BODY>
</HTML>