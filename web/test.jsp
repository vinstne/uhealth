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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--<META HTTP-EQUIV="refresh" CONTENT="60">--> 
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
        <a href="index.jsp" target="_blank">
            <img src="home.png" width="80" height="80" style="float: right;" alt="Home Page"/>
        </a>
        <input class="button" type="button" value="표 보기" OnClick="window.open('list.jsp')">

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

            <% } %>
        </div>

        <div id="All Refrigerators" class="tabcontent">
            <h3>Temperature Data</h3>
            <p>All Refrigerators and Freezers</p>
            <div id="figureAllR"  style="display: inline-block; width:800px;height:500px; border:1px solid lightgrey;"></div>
            <div id="figureAllF" style="display: inline-block; width:800px;height:500px; border:1px solid lightgrey;" ></div>
            <div id="graph"></div>
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



        <p id="plot"></p>       
        <script type="text/javascript">


            function plotData() {
                //console.log("refreshing");
                $(document).ready(function ()

                 {

                               $.get('PopulateTable', function (responseJson) {          //AJAX call is mamde to the servlet and response is stored in a
                                    if (responseJson !== null) {                              //JSONarray object called responsejson
                            
                            console.log(JSON.stringify(responseJson));
                            var i = 1;
                            var k = 1;

                            //Plotting refrigerator data

                            var dataR = new Array();
                            for (i = 1; i < 21; i++) {
                                var timeList = new Array();
                                var tempList = new Array();
                                var refName = new String();

                                refName = '"ref' + i + '"';

                                for (j = 0; j < responseJson.length; j++) {
                                    var obj = responseJson[j];
                                    var id = new String();
                                    id = JSON.stringify(obj.id);
                                    if (id == refName) {
                                        var x = obj.time;
                                        var xx = JSON.parse(JSON.stringify(x));
                                        timeList.push(xx);
                                        var y = obj.temp;
                                        var yy = JSON.stringify(y);
                                        tempList.push(JSON.parse(yy));
                                    }
                                }

                                var title = 'Refrigerator ' + i;
                                var myDiv1 = 'ref' + i;
                                var trace1 = {
                                    x: timeList,
                                    y: tempList,
                                    name: title,
                                    type: 'scatter'
                                };

                                var layout1 = {
                                    title: title,
                                    xaxis: {title: 'time'},
                                    yaxis: {title: 'temperature'}, 'shapes': [{'type': 'rect',
                                            'xref': 'paper',
                                            'yref': 'y',
                                            'x0': 0,
                                            'y0': 24.5,
                                            'x1': 1,
                                            'y1': 25,
                                            'fillcolor': '#80b3ff',
                                            'opacity': 0.2,
                                            'line': {'width': 0, }}]
                                };

                                Plotly.newPlot(myDiv1, [trace1], layout1, {margin: {t: 0}});

                                var traceR = {
                                    x: timeList,
                                    y: tempList,
                                    type: 'line',
                                    name: refName
                                };

                                dataR.push(traceR);
                            }

                            Plotly.plot('figureAllR', dataR, {title: 'All Regrigerators'}, {margin: {t: 0}});


                            //Plotting freezer data

                            var dataF = new Array();
                            for (k = 1; k < 8; k++) {
                                var timeList1 = new Array();
                                var tempList1 = new Array();
                                var freName = new String();
                                freName = '"fre' + k + '"';

                                for (j = 0; j < responseJson.length; j++) {
                                    var obj = responseJson[j];
                                    var id = new String();
                                    id = JSON.stringify(obj.id);
                                    if (id == freName) {
                                        var x1 = obj.time;
                                        var x1x1 = JSON.parse(JSON.stringify(x1));
                                        timeList1.push(x1x1);
                                        var y1 = obj.temp;
                                        var y1y1 = JSON.stringify(y1);
                                        tempList1.push(JSON.parse(y1y1));
                                    }
                                }
                                var layout2 = 'Freezer ' + k;
                                var myDiv2 = 'fre' + k;
                                Plotly.newPlot(myDiv2, [{x: timeList1, y: tempList1}], {title: layout2}, {margin: {t: 0}});


                                var traceF = {
                                    x: timeList1,
                                    y: tempList1,
                                    type: 'line',
                                    name: freName
                                };
                                dataF.push(traceF);
                            }
                            Plotly.plot('figureAllF', dataF, {title: 'All Freezers'}, {margin: {t: 0}});
                        }           
                                });       
                  });

                var cnt = 0;

                var interval = setInterval(function () {
                    $(document).ready(function ()

                     {

                                   $.get('PopulateTable', function (responseJson) {          //AJAX call is mamde to the servlet and response is stored in a
                                        if (responseJson !== null) {                              //JSONarray object called responsejson
                            
                                console.log(JSON.stringify(responseJson));
                                var i = 1;
                                var k = 1;

                                //Plotting refrigerator data

                                var dataR = new Array();
                                for (i = 1; i < 21; i++) {
                                    var timeList = new Array();
                                    var tempList = new Array();
                                    var refName = new String();

                                    refName = '"ref' + i + '"';

                                    for (j = 0; j < responseJson.length; j++) {
                                        var obj = responseJson[j];
                                        var id = new String();
                                        id = JSON.stringify(obj.id);
                                        if (id == refName) {
                                            var x = obj.time;
                                            var xx = JSON.parse(JSON.stringify(x));
                                            timeList.push(xx);
                                            var y = obj.temp;
                                            var yy = JSON.stringify(y);
                                            tempList.push(JSON.parse(yy));
                                        }
                                    }

                                    var title = 'Refrigerator ' + i;
                                    var myDiv1 = 'ref' + i;
                                    var trace1 = {
                                        x: timeList,
                                        y: tempList,
                                        name: title,
                                        type: 'scatter'
                                    };

                                    var layout1 = {
                                        title: title,
                                        xaxis: {title: 'time'},
                                        yaxis: {title: 'temperature'}, 'shapes': [{'type': 'rect',
                                                'xref': 'paper',
                                                'yref': 'y',
                                                'x0': 0,
                                                'y0': 24.5,
                                                'x1': 1,
                                                'y1': 25,
                                                'fillcolor': '#80b3ff',
                                                'opacity': 0.2,
                                                'line': {'width': 0, }}]
                                    };

                                    Plotly.newPlot(myDiv1, [trace1], layout1, {margin: {t: 0}});

                                    var traceR = {
                                        x: timeList,
                                        y: tempList,
                                        type: 'line',
                                        name: refName
                                    };

                                    dataR.push(traceR);
                                }

                                Plotly.newPlot('figureAllR', dataR, {title: 'All Regrigerators'}, {margin: {t: 0}});


                                //Plotting freezer data

                                var dataF = new Array();
                                for (k = 1; k < 8; k++) {
                                    var timeList1 = new Array();
                                    var tempList1 = new Array();
                                    var freName = new String();
                                    freName = '"fre' + k + '"';

                                    for (j = 0; j < responseJson.length; j++) {
                                        var obj = responseJson[j];
                                        var id = new String();
                                        id = JSON.stringify(obj.id);
                                        if (id == freName) {
                                            var x1 = obj.time;
                                            var x1x1 = JSON.parse(JSON.stringify(x1));
                                            timeList1.push(x1x1);
                                            var y1 = obj.temp;
                                            var y1y1 = JSON.stringify(y1);
                                            tempList1.push(JSON.parse(y1y1));
                                        }
                                    }
                                    var layout2 = 'Freezer ' + k;
                                    var myDiv2 = 'fre' + k;
                                    Plotly.newPlot(myDiv2, [{x: timeList1, y: tempList1}], {title: layout2}, {margin: {t: 0}});


                                    var traceF = {
                                        x: timeList1,
                                        y: tempList1,
                                        type: 'line',
                                        name: freName
                                    };
                                    dataF.push(traceF);
                                }
                                Plotly.newPlot('figureAllF', dataF, {title: 'All Freezers'}, {margin: {t: 0}});
                            }           
                                    });       
                      });
                    if (cnt === 100)
                        clearInterval(interval);
                }, 15000);
            }
            y = plotData();
            document.getElementById("plot").innerHTML = y;

        </script>
    </body>
</html> 


