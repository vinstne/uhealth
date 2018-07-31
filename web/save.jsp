<%@page contentType="text/html; charset=utf-8" %>
<%@page import="java.sql.*"%>
	<% 
	request.setCharacterEncoding("utf-8");
	
	String RefNumber = request.getParameter("RefNumber"); // input.jsp에서 입력받은 값들을 받아온다.
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
	PreparedStatement pstmt1 = null;
	PreparedStatement pstmt2 = null;
        PreparedStatement pstmt3 = null;
	try
	{
		conn = DriverManager.getConnection(
				 "jdbc:mysql://localhost:3306/information","vindy","1234");
		if(conn == null)
			 throw new Exception("데이터베이스에 연결할 수 없습니다.<BR>");
		
		while(true){
		String sql="insert into refdata(RefNumber,equipment,SiteNumber,reffredate,ModuleModel,ModuleSerialNumber,TypeOfReagent,Correction,date,SettingTemperature,Unit,ApplicationPart,Insepctor,AccessRight) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		pstmt1 = conn.prepareStatement(sql);
		pstmt1.setString(1,RefNumber);
		pstmt1.setString(2,equipment);
		pstmt1.setString(3,SiteNumber);
		pstmt1.setString(4,reffredate);
		pstmt1.setString(5,ModuleModel);
		pstmt1.setString(6,ModuleSerialNumber);
		pstmt1.setString(7,TypeOfReagent);
		pstmt1.setString(8,Correction);
		pstmt1.setString(9,date);
		pstmt1.setString(10,SettingTemperature);
		pstmt1.setString(11,Unit);
		pstmt1.setString(12,ApplicationPart);
		pstmt1.setString(13,Insepctor);
		pstmt1.setString(14,AccessRight);
		pstmt1.executeUpdate(); // sql문 실행
                
                String sql2="INSERT INTO beaconid(TableName) VALUES('"+RefNumber+"')";
                pstmt3 = conn.prepareStatement(sql2);
		pstmt3.executeUpdate();
		
		String sql1="create table " + RefNumber + "(Number varchar(5) DEFAULT NULL, Date varchar(25) DEFAULT NULL, Temp varchar(6) DEFAULT NULL, BatteryState varchar(15) DEFAULT NULL)";
		pstmt2 = conn.prepareStatement(sql1);
		pstmt2.executeUpdate();
                
                
				
		pstmt1.close();
		pstmt2.close();
                pstmt3.close();
		conn.close();
		}
	}
	catch(ClassNotFoundException e) //예외처리
	{
		out.println(e);	
	}
	catch(SQLException e)
	{
		out.println(e);
	}
 	response.sendRedirect("list.jsp");
	%>