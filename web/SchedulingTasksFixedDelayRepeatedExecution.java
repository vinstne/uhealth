import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.TimeUnit;
import java.sql.*;
public class SchedulingTasksFixedDelayRepeatedExecution {
	private static SimpleDateFormat dateFormatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss.SSS");

	public static void main(String argc[]) throws InterruptedException {
		String currentThreadName = Thread.currentThread().getName();
	
		ScheduledExecutorService execService = Executors.newSingleThreadScheduledExecutor(new NamedThreadsFactory());
			
		//ScheduledFuture<?> scheduleWithFixedDelay(Runnable, long initialDelay, long delay, TimeUnit unit)
		ScheduledFuture<?> schedFuture = execService.scheduleWithFixedDelay(new ScheduledRunnableTask(0), 0, 5, TimeUnit.SECONDS);
		
	}
}

class NamedThreadsFactory implements ThreadFactory {
	
	private static int count = 0;
	private static String Name = "MyThread-";

	@Override
	public Thread newThread(Runnable r) {
		return new Thread(r, Name + ++count);
	}
}

class ScheduledRunnableTask implements Runnable {	
	private static int count = 0;
	private long sleepTime;
	private String taskId;
	private SimpleDateFormat dateFormatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss.SSS");

	@Override
	public void run(){
		Date startTime = new Date();
		String currentThreadName = Thread.currentThread().getName();

		for(int i = 0; i<5; i++) {
			try {
				TimeUnit.MICROSECONDS.sleep(sleepTime);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		
		Connection conn = null;
	    Statement stmt = null;
	    Statement stmt2 = null;
	    PreparedStatement pstmt = null;
	    try {
	        Class.forName("com.mysql.jdbc.Driver");
	        conn = DriverManager.getConnection(
	                "jdbc:mysql://localhost:3306/information?useSSL=false", "vindy", "1234");
	        if (conn == null) {
	            throw new Exception("데이터베이스에 연결할 수 없습니다.<BR>");
	        }
	        stmt = conn.createStatement();
	        stmt2 = conn.createStatement();
	        ResultSet rs = stmt.executeQuery("select * from refdata;");
	        while (rs.next()) {
	        	String RefN = rs.getString("RefNumber");
	        	ResultSet rs2 = stmt2.executeQuery("Select date from " + RefN + " order by date desc limit 1;");
	        	while (rs2.next()) {
	        		String Date = rs2.getString("Date");
	        		Date curDate = new Date();
	        		SimpleDateFormat dateFormat = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");  
	        		//요청시간을 Date로 parsing 후 time가져오기 

	        		Date reqDate = dateFormat.parse(Date); 
	        		long reqDateTime = reqDate.getTime();  
	        		//현재시간을 요청시간의 형태로 format 후 time 가져오기
	        		curDate = dateFormat.parse(dateFormat.format(curDate)); 
	        		long curDateTime = curDate.getTime();  
	        		//분으로 표현 
	        		long minute = (curDateTime - reqDateTime) / 60000;
	        		
	        		System.out.println("요청시간 : " + reqDate); 
	        		System.out.println("현재시간 : " + curDate); 
	        		System.out.println(minute);
	        		if ( minute > 100 ){
	        			String missing = "insert into missingdatatime values('" + RefN + "', CURRENT_TIMESTAMP)";
	        			System.out.println(missing);
	        			pstmt = conn.prepareStatement(missing);
	        			pstmt.executeUpdate();
	        	}
	        	
	        	}
	        }
	       
	        stmt.close();
	        stmt2.close();
	        pstmt.close();
	        conn.close();
	    } catch (SQLException se1) {
	        se1.printStackTrace();
	    } catch (Exception ex) {
	        ex.printStackTrace();
	    } finally {
	        try {
	            if (stmt != null)
	                stmt.close();
	        } catch (SQLException se2) {
	        }
	        try {
	            if (conn != null)
	                conn.close();
	        } catch (SQLException se) {
	            se.printStackTrace();
	        }
	    }  	
	}
	
	
	public ScheduledRunnableTask(long sleepTime) {
		this.sleepTime = sleepTime;
		this.taskId = "ScheduledRunnableTask-" + count++;
	}
}
