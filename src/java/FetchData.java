
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Vindhya
 */
public class FetchData {

    private static Connection connection = null;

    public static Connection getConnection() {
        if (connection != null) {
            return connection;
        } else {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/information", "vindy", "1234");
            } catch (ClassNotFoundException | SQLException e) {
            }
            return connection;
        }
    }

    public static ArrayList<TempData> getAllData() {
        Connection conn1 = FetchData.getConnection();

        String deptName="Serology";
        ArrayList<TempData> TempRows=new ArrayList<>();
        ArrayList<String> refNames=getRefNames(deptName);
        String [] nameList = refNames.toArray(new String[refNames.size()]);
        String currentTime = currentDate();
        String startTime = startTime();
        
        for (int i = 0; i < nameList.length; i++) {
            try {
                Statement statement1 = conn1.createStatement();
                ResultSet rs1 = statement1.executeQuery("select * from " + nameList[i] + " where date between '" + startTime + "' and '" + currentTime + "'");
                //System.out.println("select * from ref" + i + " where dater" + i + " between '" + startTime + "' and '" + currentTime + "'");

                while (rs1.next()) {
                    TempData row1 = new TempData();
                    row1.setId(rs1.getString("number"));
                    row1.setTime(rs1.getString("date"));
                    row1.setTemp(rs1.getString("temp"));
                    row1.setDept(deptName);
                    TempRows.add(row1);
                }
            } catch (SQLException e) {
            }
        }
        return TempRows;
    }

    
    public static ArrayList<TempData> getTabData() {
        Connection conn1 = FetchData.getConnection();
        ArrayList<String> refNames=new ArrayList<>();

        try {
            Statement stmt = conn1.createStatement();
            ResultSet rs=stmt.executeQuery("Select * from refdata");
            while(rs.next()){
                refNames.add(rs.getString("refNumber"));
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(FetchData.class.getName()).log(Level.SEVERE, null, ex);
        }
        String [] nameList = refNames.toArray(new String[refNames.size()]);
        
        

        ArrayList<TempData> TempRows=new ArrayList<>();
        String currentTime = currentDate();
        String startTime = startTime();
        
        
        for (int i = 0; i < nameList.length; i++) {
            try {
                Statement statement1 = conn1.createStatement();
                ResultSet rs1 = statement1.executeQuery("select * from " + nameList[i] + " where date between '" + startTime + "' and '" + currentTime + "'");

                while (rs1.next()) {
                    TempData row1 = new TempData();
                    row1.setId(rs1.getString("number"));
                    row1.setTime(rs1.getString("date"));
                    row1.setTemp(rs1.getString("temp"));
                    TempRows.add(row1);
                }
            } catch (SQLException e) {
            }
        }
        return TempRows;
    }
    
    public static ArrayList<String> getRefNames(String deptName) {
        Connection conn = FetchData.getConnection();
        ArrayList<String> refNames = new ArrayList<>();
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select refNumber from refData where applicationPart='"+deptName+"'");
            while (rs.next()) {
                refNames.add(rs.getString("refNumber"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(FetchData.class.getName()).log(Level.SEVERE, null, ex);
        }
        return refNames;
    }
    
    public static String getTableName(String ID) {
        Connection conn = FetchData.getConnection();
        int intID=Integer.parseInt(ID);
        String tableName = "";
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select TableName from beaconID where ID="+intID+"");
            while (rs.next()) {
                tableName=rs.getString("TableName");
            }
        } catch (SQLException ex) {
            Logger.getLogger(FetchData.class.getName()).log(Level.SEVERE, null, ex);
        }
        return tableName;
    }

    public static String currentDate() {
        Date now = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String currentDate = sdf.format(now);
        //String currentDate = "2018-02-06 15:59:16";
        return currentDate;
    }

    public static String startTime() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date prev = new Date(System.currentTimeMillis() - 8 * 3600 * 1000);
        String prevDate = sdf.format(prev);
        //String prevDate = "2018-02-06 15:13:19";
        return prevDate;
    }

}
