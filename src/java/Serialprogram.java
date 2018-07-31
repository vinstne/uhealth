///////////// Made by Seoultech University U-health Lab ///////////////////
// Code Write 20171222, by Lim seokbeen.

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import gnu.io.CommPort;
import gnu.io.CommPortIdentifier;
import gnu.io.SerialPort;
import java.util.Arrays;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Serialprogram {

    final int Usart_Queue_Buffer_Size = 1500;
    static int flag_operate = 0;
    static int flag_average = 0;

    public Serialprogram() {
        super();
    }

    void connect(String portName) throws Exception {
        CommPortIdentifier portIdentifier = CommPortIdentifier.getPortIdentifier(portName);
        if (portIdentifier.isCurrentlyOwned()) {
            System.out.println("Error:Port is currently in use");
        } else {
            //Ŭ���� �̸��� �ĺ��ڷ� ����Ͽ� ��Ʈ ����
            CommPort commPort = portIdentifier.open(this.getClass().getName(), 2000);

            if (commPort instanceof SerialPort) {

                //��Ʈ ����( ��żӵ� ����, �⺻ 9600 ���� ��� )
                SerialPort serialPort = (SerialPort) commPort;
                serialPort.setSerialPortParams(115200, SerialPort.DATABITS_8, SerialPort.STOPBITS_1, SerialPort.PARITY_NONE);

                //Input, Output Stream ���� ���� �� ����
                InputStream in = serialPort.getInputStream();
                OutputStream out = serialPort.getOutputStream();

                //�б�, ���� ������ �۵�
                (new Thread(new SerialReader(in))).start();
                (new Thread(new SerialWriter(out))).start();

            } else {
                System.out.println("Error : Only serial ports are handled by this example");
            }
        }
    }

    /**
     *
     */
    //������ ����
    public static class SerialReader implements Runnable {

        InputStream in;

        public SerialReader(InputStream in) {
            this.in = in;
        }

        public void run() {

            byte[] buffer = new byte[1024];
            int len = -1;
            String[] Temp_data = new String[86]; // String array, ���ۿ� �ִ� ������ �����ϱ� ���� ����.
            char[] Temp_data_char = new char[86]; // Char �迭 , �������� ũ��� ���� �� String �� ������ Char �迭�� �����ϱ� ����.
            char[] Temp_data_char_analysis = new char[86]; // char �м��� ���� �迭.
            //char[] Temp_Data_char_real_buffer = new char[86];
            char[] Temp_Data_char_real_buffer_front = new char[86];
            int i_enqueue = 0;
            int i_char_enqueue = 0;
            boolean Flag_data_full = false; // Temp_data_char �迭�� �����Ͱ� �� á�ٸ� �� �κ��� True�� �ٲپ��ش�.

            try {
                while ((len = this.in.read(buffer)) > -1) // �̰��� Uart Interrupt ������ �Ѵ�. �����Ͱ� ���� �ÿ� Print�� �ϴ� ���̴ϱ�.
                {
                    if (len > 0) {

                        System.out.print(new String(buffer, 0, len)); // Console â�� �����͸� �״�� ���.
                        try {
                            this.file_txt_save_log(new String(buffer, 0, len), "C:\\Users\\User\\Desktop\\java_temp_data_log.txt"); //Console â�� ��µǴ� �����͸� �״�� Txt ���Ϸ� �����.
                        } catch (Exception e) {
                            // TODO Auto-generated catch block
                            e.printStackTrace();
                        }
                    }
                    //// ------ buffer �� ���� �����͸� ���������� ������ �� (Stirng), char �迭�� �ٲپ� ID, Temp data�� �����ϱ� ���� ����Ѵ�.

                    Temp_data[i_enqueue] = new String(buffer, 0, len); // Temp_data�� ���ۿ� ���� �����͸� �����Ѵ�.
                    char[] c_arr = Temp_data[i_enqueue].toCharArray(); // Temp_data�� ����� String�� Char �迭�� �� ��ȯ�Ѵ�.
                    for (int i = 0; i < c_arr.length; i++) { //c_arr�� ����� char �迭�� Total ������ �ϴ� 
                        Temp_data_char[i_char_enqueue] = c_arr[i]; // �̰� Queue ������ ������ �� ��.
                        i_char_enqueue = i_char_enqueue + 1;
                        if (Temp_data_char[i_char_enqueue - 1] == ';') {
                            i_char_enqueue = 0;
                            Flag_data_full = true;
                            System.out.println("Data full! Analysis Activate!!!");
                            for (int j = 0; j < Temp_data_char.length; j++) {     // �����Ͱ� �� ���� �����͸� �� ������ �����Ѵ�.
                                Temp_data_char_analysis[j] = Temp_data_char[j];
                            }
                        }
                    }
                    i_enqueue = i_enqueue + 1;

                    if (i_enqueue == 85) {
                        i_enqueue = 0;
                    }

                    if (Flag_data_full == true) { // �����Ͱ� Full �Ǿ Flag ������ True�� �Ǿ��ٸ�, 
                        // �� IF�� �ȿ��� ����� �� ���� ������ Temp_data_char_analysis�� �м��ϴ� ���� �̷������ �Ѵ�.
                        System.out.println(this.check_date());
                        Flag_data_full = false; //flag�� false�� ������.

                        for (int i = 0; i < Temp_data_char_analysis.length; i++) {

                            // real time variable, array length : 51 (maximum length)
                            for (int k = 85; k > 0; k--) {
                                Temp_Data_char_real_buffer_front[k] = Temp_Data_char_real_buffer_front[k - 1];
                            }
                            Temp_Data_char_real_buffer_front[0] = Temp_data_char_analysis[i];

                            if (Temp_Data_char_real_buffer_front[85] == 'I' && Temp_Data_char_real_buffer_front[84] == 'D' && Temp_Data_char_real_buffer_front[83] == ' ' && Temp_Data_char_real_buffer_front[82] == ':' && Temp_Data_char_real_buffer_front[81] == ' '
                                    && Temp_Data_char_real_buffer_front[51] == ',') {

                                // General (two digit temperature)
                                char[] ID_Array = {Temp_Data_char_real_buffer_front[80],Temp_Data_char_real_buffer_front[79]}; //read the ID
                                String ID=new String(ID_Array);
                                //String ID = "ID" + idNo; //Make the ID String (to query the DB)
                                String tableName = FetchData.getTableName(ID); //Accessing DB to get tableName
                                Databaseaccess Data_ID = new Databaseaccess();
                                String Date_Data_String_ID_03 = this.check_date();
                                Data_ID.Database_Date_data = this.check_date();
                                Data_ID.Database_ID = tableName;

                                float Temperature_Data_ID_03 = 0;
                                String Temperature_Data_string_ID_03 = "";
                                for (int k = 56; k > 51; k--) { // reading the temperature value
                                    Temperature_Data_string_ID_03 += Character.toString(Temp_Data_char_real_buffer_front[k]);
                                }

                                if (Temp_Data_char_real_buffer_front[57] == '+') { //positive temperature
                                    Temperature_Data_ID_03 = Float.parseFloat(Temperature_Data_string_ID_03);
                                    Temperature_Data_string_ID_03 = Temperature_Data_string_ID_03;
                                    Data_ID.Database_Temp_data = Temperature_Data_string_ID_03;
                                }

                                if (Temp_Data_char_real_buffer_front[57] == '-') { // negative temperature
                                    Temperature_Data_ID_03 = Float.parseFloat(Temperature_Data_string_ID_03);
                                    Temperature_Data_ID_03 = Temperature_Data_ID_03 * (-1);
                                    Temperature_Data_string_ID_03 = "-" + Temperature_Data_string_ID_03;
                                    Data_ID.Database_Temp_data = Temperature_Data_string_ID_03;
                                }
                                /*String Temperature_Low_Battery_State_Data_string_ID_03 = "";

                                for (int k = 29; k > 25; k--) { // reading the battery status
                                    Temperature_Low_Battery_State_Data_string_ID_03 += Character.toString(Temp_Data_char_real_buffer_front[k]);
                                }
                                Data_ID.Database_Low_Battery_state_data = Temperature_Low_Battery_State_Data_string_ID_03;*/
                                try {
                                    this.file_txt_save_log_ID(Date_Data_String_ID_03, Temperature_Data_string_ID_03, "C:\\Users\\User\\Desktop\\java_temp_data_log_ID_"+ID+".txt");
                                    Data_ID.Databaseaccess_fun();
                                } catch (Exception e) {// TODO Auto-generated catch block
                                    e.printStackTrace();
                                }

                            } // If the temperature value is single digit
                            else if (Temp_Data_char_real_buffer_front[85] == 'I' && Temp_Data_char_real_buffer_front[84] == 'D' && Temp_Data_char_real_buffer_front[83] == ' ' && Temp_Data_char_real_buffer_front[82] == ':' && Temp_Data_char_real_buffer_front[81] == ' '
                                    && Temp_Data_char_real_buffer_front[52] == ',') {

                                // General (Single Digit temperature)
                                char[] ID_Array = {Temp_Data_char_real_buffer_front[80],Temp_Data_char_real_buffer_front[79]}; //read the ID
                                String ID=new String(ID_Array);
                                //String ID = "ID" + idNo; //Make the ID String (to query the DB)
                                String tableName = FetchData.getTableName(ID); //Accessing DB to get tableName
                                Databaseaccess Data_ID = new Databaseaccess(); //Accessing DB to get tableName
                                String Date_Data_String_ID_03 = this.check_date();
                                Data_ID.Database_Date_data = this.check_date();
                                Data_ID.Database_ID = tableName;

                                float Temperature_Data_ID_03 = 0;
                                String Temperature_Data_string_ID_03 = "";
                                for (int k = 56; k > 52; k--) { // reading the temperature value
                                    Temperature_Data_string_ID_03 += Character.toString(Temp_Data_char_real_buffer_front[k]);
                                }

                                if (Temp_Data_char_real_buffer_front[57] == '+') { //positive temperature
                                    Temperature_Data_ID_03 = Float.parseFloat(Temperature_Data_string_ID_03);
                                    Temperature_Data_string_ID_03 = Temperature_Data_string_ID_03;
                                    Data_ID.Database_Temp_data = Temperature_Data_string_ID_03;
                                }

                                if (Temp_Data_char_real_buffer_front[57] == '-') { // negative temperature
                                    Temperature_Data_ID_03 = Float.parseFloat(Temperature_Data_string_ID_03);
                                    Temperature_Data_ID_03 = Temperature_Data_ID_03 * (-1);
                                    Temperature_Data_string_ID_03 = "-" + Temperature_Data_string_ID_03;
                                    Data_ID.Database_Temp_data = Temperature_Data_string_ID_03;
                                }
                                /*String Temperature_Low_Battery_State_Data_string_ID_03 = "";

                                for (int k = 30; k > 26; k--) { // reading the battery status
                                    Temperature_Low_Battery_State_Data_string_ID_03 += Character.toString(Temp_Data_char_real_buffer_front[k]);
                                }
                                Data_ID.Database_Low_Battery_state_data = Temperature_Low_Battery_State_Data_string_ID_03;*/
                                try {
                                    this.file_txt_save_log_ID(Date_Data_String_ID_03, Temperature_Data_string_ID_03, "C:\\Users\\User\\Desktop\\java_temp_data_log_ID_"+ID+".txt");
                                    Data_ID.Databaseaccess_fun();
                                } catch (Exception e) {// TODO Auto-generated catch block
                                    e.printStackTrace();
                                }
                            }
                        }
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        // Date //	
        public String check_date() {
            Date now = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); //Ư�� ���ڿ� �������� ��¥�� ���ʹٸ� java.text.SimpleDateFormat Ŭ������ �̿��ϸ� �ȴ�.
            String strNow2 = sdf.format(now); //System.out.println(strNow2);
            return strNow2;
        }
        ////////////////

        public double stringtoint_change_temp(char a, char b, char c, char d) {
            if (c == '.') {
                double ten_position = (a - 48) * 10;
                double one_position = (b - 48) * 1;
                double dot_one_position = (d - 48) * 0.1;
                double temp_data = ten_position + one_position + dot_one_position;
                return temp_data;
            }
            return -1;
        }

        public double stringtoint_change_humid(char a, char b, char c, char d) {
            if (c == '.') {
                double ten_position = (a - 48) * 10;
                double one_position = (b - 48) * 1;
                double dot_one_position = (d - 48) * 0.1;
                double humid_data = ten_position + one_position + dot_one_position;
                return humid_data;
            }
            return -1;
        }

        public static double sum(double[] array) { //sum method
            double sum = 0.0;
            for (int i = 0; i < array.length; i++) {
                sum += array[i];
            }
            return sum;
        }

        public static double average(double[] array) {    //average method
            double sum = 0.0;
            for (int i = 0; i < array.length; i++) {
                sum += array[i];
            }
            return sum / array.length;
        }

        public void file_txt_save(String[] array, String[] array2, String[] array3, String ave_tmp, String ave_humid, String var) throws Exception { // ���߿� ����� �������ų�, ���ϸ��� �޸��� ��� String ��ġ�� �ڵ带 Ȱ���Ͽ� �� �� ���� ��.
            //array = temperature data, array2 = Humid data, array3 = Time data, var = Directory data, ave_tmp = average_temperature, ave_humid = average_humidity
            File file = new File(var); //java.io ���� ����.
            FileWriter fw = new FileWriter(file, true);
            //if���� array �����Ͱ� 5���� �����Ǿ��� �� �����Ѵ�. �����Ͱ� �Ϻ��ϰ� ���Դ� �����Ѵ�.
            if (array.length == 5 && array2.length == 5 && array3.length == 5) {
                for (int i = 0; i < array.length; i++) {
                    fw.write(array3[i]);
                    fw.write(",");
                    fw.write("Temp: ");
                    fw.write(array[i]);
                    fw.write("C,");
                    fw.write(" Humid :");
                    fw.write(array2[i]);
                    fw.write("%" + "\r\n");
                }
                fw.write("Average temperature : ");
                fw.write(ave_tmp);
                fw.write("C,");
                fw.write("Average Humidity : ");
                fw.write(ave_humid);
                fw.write("%" + "\r\n");
            }

            fw.flush();
            fw.close();
            System.out.println("������ ����Ǿ����ϴ�.");
        }

        public void file_txt_save_log(String log_Data, String var) throws Exception {
            File file = new File(var);
            FileWriter fw = new FileWriter(file, true);
            //fw.write(this.check_date());fw.write(", ");
            fw.write(log_Data);
            fw.flush();
            fw.close();
        }

        public void file_txt_save_log_ID(String log_Date, String log_Data, String var) throws Exception {
            File file = new File(var);
            FileWriter fw = new FileWriter(file, true);
            fw.write(log_Date);
            fw.write(", ");
            fw.write("Temp: ");
            fw.write(log_Data);
            fw.write("C");
            fw.write("\r\n");
            fw.flush();
            fw.close();
        }
    }

    //������ �۽�
    public static class SerialWriter implements Runnable {

        OutputStream out;

        public SerialWriter(OutputStream out) {
            this.out = out;
        }

        public void run() {
            try {
                int c = 0;
                while ((c = System.in.read()) > -1) {
                    this.out.write(c);
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public static void main(String[] args) {
        System.out.println("Start Serial communication");;

        try {
            (new Serialprogram()).connect("COM4"); //�Է��� ��Ʈ�� ����
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        System.out.println("Success Serial port open");

    }
}
