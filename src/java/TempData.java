

/**
 *
 * @author Vindhya
 */
public class TempData {
    
        public TempData(String id, String time, String temp, String dept) {
        this.setId(id);
        this.setTime(time);
        this.setTemp(temp);
        this.setDept(dept);        
    }

    public TempData() {

    }
    private String id;
    private String time;
    private String temp;
    private String dept;

    
    public void setId(String id) {
        this.id = id;
    }
    
    public void setTime(String time) {
        this.time = time;
    }

    public void setTemp(String temp) {
        this.temp = temp;
    }
    
    public void setDept(String dept) {
        this.dept = dept;
    }

}
