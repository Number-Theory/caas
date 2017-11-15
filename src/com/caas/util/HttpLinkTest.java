package com.caas.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

public class HttpLinkTest {
	public static void linkTest(String strUrl,String content){
		try{
		InputStream ins = null;
		BufferedReader l_reader = null;
		URL url = new URL(strUrl);
		URLConnection connection = url.openConnection();
		connection.setConnectTimeout(4000);
		connection.setReadTimeout(4000);
		connection.connect();
		ins = connection.getInputStream();
		l_reader = new BufferedReader(new InputStreamReader(ins, "utf-8"));
		StringBuffer result = new StringBuffer();
		String line = "";
		while ((line = l_reader.readLine()) != null) {
			result.append(line);
			result.append("\r\n");
		}
		l_reader.close();
		ins.close();
		System.out.println(result);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public static void main(String[] args){
		StringBuffer str = new StringBuffer();
		JSONObject rstJson = new JSONObject();
		rstJson.put("keySecret", "1233456");
		rstJson.put("facnPublicIp", "113.31.89.131");
		rstJson.put("facnPrivateIp", "10.10.89.131");
		rstJson.put("timeStamp", "20170317155640");
		rstJson.put("user_id", 47);
		List<Map> pingList = new ArrayList<Map>();
		Map test = new HashMap();
		Map map = null;
		for(int i=0;i<4;i++){
			map = new HashMap();
			map.put("pingIP", "10.10.89.12"+i*2);
			map.put("pingIpType", 0);
			map.put("loseRate", (i+1)*10+"%");
			map.put("rttAvgTime", (i+1)*0.4);
			pingList.add(map);
//			Gson gson = new Gson();
//			String json = gson.toJson(map);
//			System.out.println(json);
//			test = JSONObject.fromObject(json);
//			System.out.println(test.toString());
			
		}
		
		rstJson.put("pingIpList", pingList);
		System.out.println(rstJson.toString());
//		comTest();
		linkTest("http://172.16.2.165:8060/pkgLossRate?dd="+URLEncoder.encode(rstJson.toString()),"");
	}
	public static void comTest(){
		String time = "2017:03:18 10:19:25";
		System.out.println(time.substring(11,19));
	}
}
