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
        <!--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">-->
        <!--<META HTTP-EQUIV="refresh" CONTENT="60">--> 
        <title>Temperature Information</title>

        <style>
            body {
                background-color: lightblue;
                background-image: url("background1.jpg");
                background-size:cover;
                
            }

            .img-wrap, h1{
                
                text-align: center;
                color: white;

            }
            .img-wrap, h2{
                text-align: center;
                color: white;
            }
            .img-wrap a img{
                display:block;
            }
            .img-wrap > a{
                display:inline-block;
                vertical-align: middle;
                border: 1px solid #555
            }

            .strokeme
            {
                color: white;
                text-shadow:
                    -2px -2px 0 #000,
                    2px -2px 0 #000,
                    -2px 2px 0 #000,
                    2px 2px 0 #000;  
            }

            .copyright {
                float: right;
                color: white;
                font-size: 20px;
                color: white;
                text-shadow:
                    -1px -1px 0 #000,
                    1px -1px 0 #000,
                    -1px 1px 0 #000,
                    1px 1px 0 #000; 
            }

        </style>

    </head>
    <body>
        </br>
        <h1 style="font-size:60px;" class="strokeme">냉장/냉동고 온도 모니터링 시스템</h1></br>
        <h1 style="font-size:50px;" class="strokeme">영동세브란스 임상병리과</h1></br>

        <h2  style="font-size:30px;" class="strokeme">냉장고/냉동고 온도 정보</h2></br>
        <div class="img-wrap">
            <a href="list.jsp" target="_blank">
                <img src="tables.jpg" width="120" height="120" alt="tables"/>
            </a>
            </br>
            </br>
            <a href="test.jsp" target="_blank">
                <img src="graphs.jpg" width="120" height="120" alt="graphs"/>
            </a>
        </div>

        <footer>
            <p class="copyright"><b>Developed By - SeoulTech</b></p></br>
            </br>
            </br>
            </br>
            <a class="copyright" href="http://en.seoultech.ac.kr/" target="_blank"><img class="copyright" src="Seoultech_LOGO.png" width="100" height="100" alt="Seoultech_LOGO"/></a>
        </footer>


    </body>
</html> 


