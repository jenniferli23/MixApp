import java.net.URL;
import java.net.HttpURLConnection;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.*;
import java.io.File;

public class LoadGenForMixApp{
	static int count=0;

	public static void main(String args[]) throws Exception{
		String javaBaseURL = "http://192.168.99.100:8080/TechStack/";
		String phpBaseURL = "http://192.168.99.100/";
		String addr = "";
		for(int j=1;;j++){	
				//Java URLs		
				addr = javaBaseURL + "php.httpbackendservlet?address=http://192.168.99.100/info.php";
				callHttpClient(addr);
				addr = javaBaseURL + "python.httpbackendservlet?address=http://192.168.99.100:9000/wave/abc";
				callHttpClient(addr);
				addr = javaBaseURL + "nodejs.httpbackendservlet?address=http://192.168.99.100:3000";
				callHttpClient(addr);
				
				//PHP URLs
				addr = phpBaseURL + "callPythonApp.php";
				callHttpClient(addr);
				addr = phpBaseURL + "callNodejsApp.php";
				callHttpClient(addr);
				addr = phpBaseURL + "callJavaApp.php";
				callHttpClient(addr);
				
				//Python URLs
				addr = "http://192.168.99.100:9000/http?url=http://192.168.99.100:8080/TechStack/i.pojoservlet";
				callHttpClient(addr);
				addr = "http://192.168.99.100:9000/http?url=http://192.168.99.100/info.php";
				callHttpClient(addr);
				addr = "http://192.168.99.100:9000/http?url=http://192.168.99.100:3000";
				callHttpClient(addr);
				
				//NodeJS URLs
				addr = "http://192.168.99.100:3000/crosspython";
				callHttpClient(addr);
				addr = "http://192.168.99.100:3000/crossjava";
				callHttpClient(addr);
				addr = "http://192.168.99.100:3000/crossphp";
				callHttpClient(addr);
		}						
	}

	public static void callHttpClient(String address) {
        try{
			
		URL serverAddress = new URL(address);
		System.out.println(address);
                HttpURLConnection connection = null;
                connection = (HttpURLConnection) serverAddress.openConnection();
                connection.setRequestMethod("GET");
			//	connection.setRequestProperty("ApicaGUID", "835adskn789534c");
			//	connection.setRequestProperty("appdynamicssnapshotenabled", "false");
                connection.setDoOutput(true);
                connection.setReadTimeout(100000);
                //connection.setReadTimeout(1000);

                connection.connect();


                BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
				//System.out.println(">>>>>>>>>>>>>REQUEST COUNT <<<<<<<<<<<<<<<<<<< "+ (++count));
				connection.disconnect();			
				Thread.sleep(2000);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
