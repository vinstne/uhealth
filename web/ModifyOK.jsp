<%@page contentType="text/html; charset=utf-8" %>
<%@page import="java.sql.*"%>
	<html>
	<head>
	</head>
	<body>
	<% 
	request.setCharacterEncoding("utf-8");
	
	String RefNumber = request.getParameter("RefNumber");
	if (RefNumber==null)
		RefNumber="";
	String equipment = request.getParameter("equipment");
	if (equipment==null)
		equipment="";
	String SiteNumber = request.getParameter("SiteNumber");
	if (SiteNumber==null)
		SiteNumber="";
	String reffredate = request.getParameter("reffredate");
	if (reffredate==null)
		reffredate="";
	String ModuleModel = request.getParameter("ModuleModel");
	if (ModuleModel==null)
		ModuleModel="";
	String ModuleSerialNumber = request.getParameter("ModuleSerialNumber");
	if (ModuleSerialNumber==null)
		ModuleSerialNumber="";
	String TypeOfReagent = request.getParameter("TypeOfReagent");
	if (TypeOfReagent==null)
		TypeOfReagent="";
	String Correction = request.getParameter("Correction");
	if (Correction==null)
		Correction="";
	String date = request.getParameter("date");
	if (date==null)
		date="";
	String SettingTemperature = request.getParameter("SettingTemperature");
	if (SettingTemperature==null)
		SettingTemperature="";
	String Unit = request.getParameter("Unit");
	if (Unit==null)
		Unit="";
	String ApplicationPart = request.getParameter("ApplicationPart");
	if (ApplicationPart==null)
		ApplicationPart="";
	String Insepctor = request.getParameter("Insepctor");
	if (Insepctor==null)
		Insepctor="";
	String AccessRight = request.getParameter("AccessRight");
	if (AccessRight==null)
		AccessRight="";
    
	Connection conn = null;
	PreparedStatement pstmt = null;
	int n=0;
	
	try
	{
		conn = DriverManager.getConnection(
				 "jdbc:mysql://localhost:3306/information","vindy","1234");
		if(conn == null)
			 throw new Exception("데이터베이스에 연결할 수 없습니다.<BR>");
		while(true){
		String sql = "update refdata set equipment='"+ equipment + "', SiteNumber='"+ SiteNumber + "', reffredate='"+ reffredate + "', ModuleModel='"+ ModuleModel + "', ModuleSerialNumber='"+ ModuleSerialNumber + "', TypeOfReagent='"+ TypeOfReagent + "', Correction='"+ Correction + "', date='"+ date + "', SettingTemperature='"+ SettingTemperature + "', Unit='"+ Unit + "', ApplicationPart='"+ ApplicationPart + "', Insepctor='"+ Insepctor + "', AccessRight='"+ AccessRight + "' where RefNumber='"+ RefNumber + "'";
		System.out.println(sql);
		pstmt = conn.prepareStatement(sql);
		n = pstmt.executeUpdate();
		pstmt.close();
		conn.close();
		}
	}

	catch(ClassNotFoundException e)
	{
		out.println(e);
	}
	catch(SQLException e)
	{
		out.println(e);
	}
	%>
	<script type="text/javascript">
	if(<%=n%> > 0){
		alert("수정되었습니다.");
		location.href="Update.jsp";
	}else{
		alert("수정 실패");
		location.href="Update.jsp";
	}
	</script>
	</body>
	</html>