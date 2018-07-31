<!--<author - Vindhya>-->

<%@page import="java.io.FileWriter"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <!--<body bgcolor="#E5E8E8"></body>-->

    <head>
        <script src="plotly-latest.min.js"></script>
        <script src="jquery-3.2.1.min.js"></script>
       <meta name="viewport" 
      content="width=device-width, maximum-scale=1.5">
        <title>Temperature Graphs</title>

        <style>


            html, body {
                margin: 0;
                padding: 0;
                background: #E8ECEF;
                height: 100%;
                width: 100%;
                text-align: center;
            }
            h1{
                font: 400 60px roboto, "Open Sans", Helvetica, sans-serif;
                text-transform: uppercase;
            }
            h2{
                font: 300 40px roboto, "Open Sans", Helvetica, sans-serif;
                text-transform: uppercase;
            }



            /* Align the content inside the tab */
            DIV {text-align: center}


            /* Style the tab */
            div.tab {
                overflow: hidden;
                border: 1px solid #ccc;
                background-color: #f1f1f1;
            }

            /* Style the buttons inside the tab */
            div.tab button {
                background-color: inherit;
                float: left;
                border: none;
                outline: none;
                cursor: pointer;
                padding: 14px 16px;
                transition: 0.3s;
                font-size: 17px;
            }

            /* Change background color of buttons on hover */
            div.tab button:hover {
                background-color: #ddd;
            }

            /* Create an active/current tablink class */
            div.tab button.active {
                background-color: #002b80;
                color: white;
            }

            /* Style the tab content */
            .tabcontent {
                display: none;
                padding: 8px 12px;
                border: 1px solid #ccc;
                border-top: none;
            }

            .button {
                background-color: #002b80;
                border: none;
                color: white;
                padding: 7px 16px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 15px;
                margin: 4px 2px;
                cursor: pointer;
                font-weight: bold;
            }

        </style>

    </head>
    <body>
        <h1>온도 그래프</h1> 
        <input class="button" type="button" value="표 보기" OnClick="location.href = 'list.jsp'">

        <p><font size="5">해당 부서를 클릭하십시오:</font></p>

        <div class="tab">
            <button class="tablinks" onclick="openDepartment(event, 'Department A')">혈청학</button>
            <button class="tablinks" onclick="openDepartment(event, 'Department B')">면역학</button>
            <button class="tablinks" onclick="openDepartment(event, 'Department C')">생화학</button>
            <button class="tablinks" onclick="openDepartment(event, 'Department D')">미생물학</button>
            <button class="tablinks" onclick="openDepartment(event, 'Department E')">분자유전학</button>
            <button class="tablinks" onclick="openDepartment(event, 'Department F')">혈액은행</button>
            <button class="tablinks" onclick="openDepartment(event, 'Department G')">혈액학</button>
            <button class="tablinks" onclick="openDepartment(event, 'All Refrigerators')" id="defaultOpen">모든 냉장/동고</button>
        </div>

        <Script>
            function getData(number) {
                var timeList = new Array();
                var tempList = new Array();
                $(document).ready(function ()
                 {
                    $.get('PopulateTable', function (responseJson) {          //AJAX call is mamde to the servlet and response is stored in a  
                        if (responseJson !== null) {                              //JSONarray object called responsejson 
                            for (j = 0; j < responseJson.length; j++) {
                                var obj = responseJson[j];
                                if (obj.id == number) {
                                    var x = obj.time;
                                    var xx = JSON.parse(JSON.stringify(x));
                                    timeList.push(xx);
                                    var y = obj.temp;
                                    var yy = JSON.stringify(y);
                                    tempList.push(JSON.parse(yy));
                                }
                            }
                        }
                                });    
                });
                var trace1 = {x: timeList, y: tempList, name: number};
                return trace1;
            }
        </script>

        <script>
            function plotFig(e, tempRange) {
                var tR = tempRange.split("~");
                var min = tR[0];
                var max = tR[1];
                var layout1 = {
                    title: e,
                    xaxis: {title: 'time'},
                    yaxis: {title: 'temperature'}, 'shapes': [{'type': 'rect',
                            'xref': 'paper',
                            'yref': 'y',
                            'x0': 0,
                            'y0': min,
                            'x1': 1,
                            'y1': max,
                            'fillcolor': '#80b3ff',
                            'opacity': 0.2,
                            'line': {'width': 0, }}]};

                var data1 = getData(e);
                Plotly.plot(e, [data1], layout1, {margin: {t: 0}});

                var cnt = 0;

                var interval = setInterval(function () {

                    var tR = tempRange.split("~");
                var min = tR[0];
                var max = tR[1];
                var layout1 = {
                    title: e,
                    xaxis: {title: 'time'},
                    yaxis: {title: 'temperature'}, 'shapes': [{'type': 'rect',
                            'xref': 'paper',
                            'yref': 'y',
                            'x0': 0,
                            'y0': min,
                            'x1': 1,
                            'y1': max,
                            'fillcolor': '#80b3ff',
                            'opacity': 0.2,
                            'line': {'width': 0, }}]};

                var data1 = getData(e);
                Plotly.newPlot(e, [data1], layout1, {margin: {t: 0}});

                    if (cnt === 100)
                        clearInterval(interval);
                }, 10000);
            }
        </Script>

        <p id="plotAllFig"></p>
        <script>
            function plotAllFig(e, div) {
                var dataR = new Array();
                var f = e.replace(/\]|\[/g, "");
                var d = f.split(", ");
                var layout1 = {
                    xaxis: {title: 'time'},
                    yaxis: {title: 'temperature'}};
                for (i = 0; i < d.length; i++) {
                    var data1 = getData(d[i]);
                    dataR.push(data1);
                }
                //var dataR1=[{x: [1,2,3,4,5],y: [2,5,4,7,6]}];
                Plotly.plot(div, dataR, layout1, {margin: {t: 0}});
            }
        </Script>

        <%
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

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/information", "vindy", "1234");
                if (conn == null) {
                    throw new Exception("Can't connect to the DB.<BR>");
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
                ResultSet rs1 = stmt1.executeQuery("select * from refdata where applicationpart='Serology';");
                ResultSet rs2 = stmt2.executeQuery("select * from refdata where applicationpart='Immunology';");
                ResultSet rs3 = stmt3.executeQuery("select * from refdata where applicationpart='Biochemistry';");
                ResultSet rs4 = stmt4.executeQuery("select * from refdata where applicationpart='Microbiology';");
                ResultSet rs5 = stmt5.executeQuery("select * from refdata where applicationpart='MolecularG';");
                ResultSet rs6 = stmt6.executeQuery("select * from refdata where applicationpart='Blood Bank';");
                ResultSet rs7 = stmt7.executeQuery("select * from refdata where applicationpart='Hematology';");
                ResultSet rs8 = stmt8.executeQuery("select * from refData where SUBSTRING(refNumber,1,3)='ref';");
                ResultSet rs9 = stmt9.executeQuery("select * from refData where SUBSTRING(refNumber,1,3)='fre';");
        %>

        <div id="Department A" class="tabcontent">
            <h3>Temperature Data</h3>
            <p>Refrigerators of Department A</p>
            <%
                while (rs1.next()) {
                    String divName = rs1.getString("refNumber");
                    String tempRange = rs1.getString("settingTemperature");
            %>
            <div id="<%=divName%>" style="display: inline-block; width:600px;height:350px; border:1px solid lightgrey;"></div>            
            <script>
                plotFig("<%=divName%>", "<%=tempRange%>");
            </script>
            <% } %>
        </div>

        <div id="Department B" class="tabcontent">
            <h3>Temperature Data</h3>
            <p>Refrigerators of Department B</p>
            <%
                while (rs2.next()) {
                    String divName = rs2.getString("refNumber");
                    String tempRange = rs2.getString("settingTemperature");
            %>
            <div id="<%=divName%>" style="display: inline-block; width:600px;height:350px; border:1px solid lightgrey;"></div>            
            <script>
                plotFig("<%=divName%>", "<%=tempRange%>");
            </script>
            <% } %>
        </div>

        <div id="Department C" class="tabcontent">
            <h3>Temperature Data</h3>
            <p>Refrigerators of Department C</p>
            <%
                while (rs3.next()) {
                    String divName = rs3.getString("refNumber");
                    String tempRange = rs3.getString("settingTemperature");
            %>
            <div id="<%=divName%>" style="display: inline-block; width:600px;height:350px; border:1px solid lightgrey;"></div>            
            <script>
                plotFig("<%=divName%>", "<%=tempRange%>");
            </script>
            <% } %>
        </div>

        <div id="Department D" class="tabcontent">
            <h3>Temperature Data</h3>
            <p>Refrigerators of Department D</p>
            <%
                while (rs4.next()) {
                    String divName = rs4.getString("refNumber");
                    String tempRange = rs4.getString("settingTemperature");
            %>
            <div id="<%=divName%>" style="display: inline-block; width:600px;height:350px; border:1px solid lightgrey;"></div>            
            <script>
                plotFig("<%=divName%>", "<%=tempRange%>");
            </script>
            <% } %>
        </div>

        <div id="Department E" class="tabcontent">
            <h3>Temperature Data</h3>
            <p>Refrigerators of Department E</p>
            <%
                while (rs5.next()) {
                    String divName = rs5.getString("refNumber");
                    String tempRange = rs5.getString("settingTemperature");
            %>
            <div id="<%=divName%>" style="display: inline-block; width:600px;height:350px; border:1px solid lightgrey;"></div>            
            <script>
                plotFig("<%=divName%>", "<%=tempRange%>");
            </script>
            <% } %>
        </div>

        <div id="Department F" class="tabcontent">
            <h3>Temperature Data</h3>
            <p>Refrigerators of Department F</p>
            <%
                while (rs6.next()) {
                    String divName = rs6.getString("refNumber");
                    String tempRange = rs6.getString("settingTemperature");
            %>
            <div id="<%=divName%>" style="display: inline-block; width:600px;height:350px; border:1px solid lightgrey;"></div>            
            <script>
                plotFig("<%=divName%>", "<%=tempRange%>");
            </script>
            <% } %>
        </div>

        <div id="Department G" class="tabcontent">
            <h3>Temperature Data</h3>
            <p>Refrigerators of Department G</p>
            <%
                while (rs7.next()) {
                    String divName = rs7.getString("refNumber");
                    String tempRange = rs7.getString("settingTemperature");
            %>
            <div id="<%=divName%>" style="display: inline-block; width:600px;height:350px; border:1px solid lightgrey;"></div>            
            <script>
                plotFig("<%=divName%>", "<%=tempRange%>");
            </script>
            <% } %>
        </div>

        <div id="All Refrigerators" class="tabcontent">
            <h3>Temperature Data</h3>
            <p>All Refrigerators and Freezers</p>
            <div id="figureAllR"  style="display: inline-block; width:800px;height:500px; border:1px solid lightgrey;">All Refrigerators</div>
            <%
                List<String> rN = new ArrayList<>();
                while (rs8.next()) {
                    rN.add(rs8.getString("refNumber"));
                }
            %>
            <script>
                plotAllFig("<%=rN%>", "figureAllR");
            </script>

            <div id="figureAllF" style="display: inline-block; width:800px;height:500px; border:1px solid lightgrey;" >All Freezers</div>
            <%
                List<String> fN = new ArrayList<>();
                while (rs9.next()) {
                    fN.add(rs9.getString("refNumber"));
                }
            %>
            <script>
                plotAllFig("<%=fN%>", "figureAllF");
            </script>
        </div>

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
                } catch (Exception ignored) {
                }
                try {
                    conn.close();
                } catch (Exception ignored) {

                }
            }
        %>

        <script>
            function openDepartment(evt, DepartmentName) {

                var i, tabcontent, tablinks;

                tabcontent = document.getElementsByClassName("tabcontent");

                for (i = 0; i < tabcontent.length; i++) {
                    tabcontent[i].style.display = "none";
                }
                tablinks = document.getElementsByClassName("tablinks");
                for (i = 0; i < tablinks.length; i++) {
                    tablinks[i].className = tablinks[i].className.replace(" active", "");
                }
                document.getElementById(DepartmentName).style.display = "block";
                evt.currentTarget.className += " active";
            }
            document.getElementById("defaultOpen").click();
        </script>
    </body>
</html> 


