import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Databaseaccess {
	
	 //�ܺο��� �� ���� �������ְ� Ŭ������ ������ ��.
	
	 String Database_ID = "";
	 //String Database_ID_ref = "";
	 String Database_Temp_data = "";
	 String Database_Date_data = ""; 
         String Database_Low_Battery_state_data = "";
	 
         
	  
	 public void Databaseaccess_fun() throws Exception{
		// JDBC driver name and database URL
	      final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
	      final String DB_URL="jdbc:mysql://localhost:3306/information?autoReconnect=true&useSSL=false";

	      //  Database credentials
	      final String USER = "vindy";
	      final String PASS = "1234";
              
	      System.out.println("Database access class Databaseaccess_fun function here!!!!");
	      // Set response content type     
	      
	         
	      try {
	         // Register JDBC driver
	         Class.forName(JDBC_DRIVER);
	         Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
	         if(conn == null)
	        	 throw new Exception("�����ͺ��̽��� ������ �� �����ϴ�.");
	        
                 System.out.println("Connected to the DB from Saving Data Part");
	         // Execute SQL query
	         Statement stmt = null;
	         stmt = conn.createStatement();
	         String sql;
	         sql = "insert "+Database_ID+" "+"(Number, Date, Temp, BatteryState) values('"+Database_ID+"', '"+Database_Date_data+"', '"+Database_Temp_data+"', '"+Database_Low_Battery_state_data+"');";
	         System.out.println(sql);
                 int rowNum = stmt.executeUpdate(sql);
	         // Extract data from result set
	         if(rowNum<1)
	        	 throw new Exception("�����͸� DB�� �Է��� �� �����ϴ�.");
	         
	         stmt.close();
	         conn.close();
	      }catch(ClassNotFoundException e) {
	    	  e.printStackTrace();
	    	  System.out.println("Db Drvier Error!");
	    	  }
	      catch(SQLException se) {
	    	  se.printStackTrace();
	    	  System.out.println("DB Conncetion Error!");
	      }

}
}

