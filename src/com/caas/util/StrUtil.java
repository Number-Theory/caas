package com.caas.util;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.net.Inet6Address;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.text.DecimalFormat;
import java.util.Enumeration;
import java.util.Random;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class StrUtil {
	
	private static final Logger logger = LoggerFactory.getLogger(StrUtil.class);
	
	private static String ip = "";

	public static boolean isEmpty(Object o){
		if(o instanceof String){
			if(o==null || o.toString().trim().equals("")){
				return true;
			}
		}else{
			if(o==null){
				return true;
			}
		}
		return false;
	}
	
	public static String[] split(String str){
		String [] strArray = null ;
		if(str.contains(",") ){
			strArray = str.split(",");
			return strArray;
		}
		return new String[]{str} ;
	}
	public static String getUUID() {  
        UUID uuid = UUID.randomUUID();  
        String str = uuid.toString();
        String temp = str.substring(0, 8) + str.substring(9, 13) + str.substring(14, 18) + str.substring(19, 23) + str.substring(24);  
        return temp;  
    }  
    //获得指定数量的UUID  
    public static String[] getUUID(int number) {  
        if (number < 1) {  
            return null;  
        }  
        String[] ss = new String[number];  
        for (int i = 0; i < number; i++) {  
            ss[i] = getUUID();  
        }  
        return ss;  
    }
    //获取4位随机数
    public static int getRandom4(){
    	return (int) (Math.random()*9000+1000);
    }
    
 // linux/unix下面获取ip地址通过网卡绑定获取，否则只会获取host文件的ip地址
 	// 如果同一网卡绑定了多个ip地址，程序会不识别使用哪个ip，则最好直接读取配置文件的真实ip的方式
 	// 此处默认获取第一张网卡的第一个ip地址
 	public static String getUnixIP() {
 		if (ip.equals("")) {
 			try {
 				Enumeration<?> e1 = (Enumeration<?>) NetworkInterface.getNetworkInterfaces();
 				while (e1.hasMoreElements()) {
 					NetworkInterface ni = (NetworkInterface) e1.nextElement();
 					Enumeration<?> e2 = ni.getInetAddresses();
 					while (e2.hasMoreElements()) {
 						InetAddress ia = (InetAddress) e2.nextElement();
 						if (ia instanceof Inet6Address)
 							continue;
 						ip = ia.getHostAddress();
 						break;
 					}
 					break;
 				}
 			} catch (SocketException e) {
 				logger.info("获取ip地址错误：", e);
 			}
 		}
 		return ip;
 	}
	
	public static void writeMsg(HttpServletResponse response, String msg,String url){
		if(StrUtil.isEmpty(url)){
			url = "history.go(-1)";
		}else{
			url = "location.href=\""+url+"\"" ;
		}
		StringBuilder sb = new StringBuilder();
		String host = getUnixIP();
		String port = "8080"; //TODO
		sb.append("<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>");
		sb.append("<html xmlns='http://www.w3.org/1999/xhtml'>");
		sb.append("<head>");
		sb.append("<title>提示</title>");
		sb.append("<link rel='stylesheet' type='text/css' href='http://"+host+":"+port+"/resources/css/main/style.css' />");
		sb.append("<script type='text/javascript' href='http://"+host+":"+port+"/resources/js/main/common.js' ></script>");
		sb.append("<script type='text/javascript' href='http://"+host+":"+port+"/resources/js/jquery-1.7.2.js' ></script>");
		sb.append("</head>");
		sb.append("<body>");
		sb.append("<div class='dialog-bg' style='display:block'>&nbsp;</div>");
		sb.append("<div class='dialog-box'  style='display:block'>"+
		      " <div class='delete dialog' style='display:block'>"+
		         " <h6>提示</h6>"+
		      " <p class='p-blue' style='margin-left: 50px;'>"+msg+"</p>"+
		      " <div class='div-btn'>"+
		      " <a href='javascript:void(0)' class='btn-style4 sure' onclick='"+url+"' style='margin-left: 200px;'>确定</a>"+
		      " </div>"+
		      " </div>"+
		      " </div>"+
		      "<script type='text/javascript'>"+
		      "if (navigator.appName === 'Microsoft Internet Explorer') {"+
		      "if (navigator.userAgent.match(/Trident/i) && navigator.userAgent.match(/MSIE 8.0/i)) {"+
		      "var w = $(window).width();"+
		      "var h = $(window).height();"+
		      "var fw = $('.dialog-box').width();"+
		      "var fh = $('.dialog-box').height();"+
		      "var fww = (w - fw - 50)/2;"+
		      "var fhh = (h - fh - 50)/2;"+
		      "$('.dialog-box').css({'left':fww+'px','top':fhh+'px'});"+
		      "}"+
		      "}"+
		      "</script>"+
		      "</body>");
		response.setHeader("Cache-Control", "no-cache");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
			out.println(sb.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
//	public static void writeMsg(HttpServletResponse response, String msg,String url){
//		if(StrUtil.isEmpty(url)){
//			url = "history.go(-1)";
//		}else{
//			url = "location.href=\""+url+"\"" ;
//		}
//		StringBuilder sb = new StringBuilder();
//		String host = SysConfig.getInstance().getProperty("host");
//		sb.append("<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>");
//		sb.append("<html xmlns='http://www.w3.org/1999/xhtml'>");
//		sb.append("<head>");
//		sb.append("<title>提示</title>");
//		sb.append("<link rel='stylesheet' type='text/css' href='http://"+host+"/page/css/style.css' />");
//		sb.append("<link rel='stylesheet' type='text/css' href='http://"+host+"/page/css/form.css' />");
//		sb.append("</head>");
//		sb.append("<body style='padding-left: 30%;padding-top: 10%;background:none;'>");
//		sb.append("<div class='background_box' style='display:block'>&nbsp;</div>");
//		sb.append("<div class='float_box addnum_box'  style='display:block'>"+
//		 " <div class='float_tit'>"+
//		   " <h3>&nbsp;提示</h3>"+
//		 " </div>"+
//		 " <div class='float_ctn'>"+
//		   " <div  class='float_field' style='font-size: 14px;color: #4c4c4c;'>"+msg+"!</div>"+
//		   "<div class='float_btn'>"+
//		      "<input type='button' class='confirm_btn' value='确 定' onclick='"+url+"'>"+
//		   " </div>"+
//		 " </div>"+
//		"</div>");
//		response.setHeader("Cache-Control", "no-cache");
//		response.setContentType("text/html;charset=UTF-8");
//		PrintWriter out = null;
//		try {
//			out = response.getWriter();
//			out.println(sb.toString());
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//	}
	
	//验证手机是否包含js
	public static boolean checkJsForStr(String inputStr){
		//验证是否有成对的<>
		String regex = "[\\s\\S]*<[\\s\\S]*>[\\s\\S]*";
		//验证是否有<或>
		//String regex = "([\\s\\S]*<[\\s\\S]*)|([\\s\\S]*>[\\s\\S]*)"; 
		return check(regex, inputStr);
	}
	//验证邮箱
	public static boolean checkEmailForStr(String inputStr){
//		String regex ="^((([a-z]|\\d|[!#\\$%&'\\*\\+\\-\\/=\\?\\^_`{\\|}~]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])+(\\.([a-z]|\\d|[!#\\$%&'\\*\\+\\-\\/=\\?\\^_`{\\|}~]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])+)*)|((\\x22)((((\\x20|\\x09)*(\\x0d\\x0a))?(\\x20|\\x09)+)?(([\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x7f]|\\x21|[\\x23-\\x5b]|[\\x5d-\\x7e]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])|(\\\\([\\x01-\\x09\\x0b\\x0c\\x0d-\\x7f]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF]))))*(((\\x20|\\x09)*(\\x0d\\x0a))?(\\x20|\\x09)+)?(\\x22)))@((([a-z]|\\d|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])|(([a-z]|\\d|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])([a-z]|\\d|-|\\.|_|~|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])*([a-z]|\\d|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])))\\.)+(([a-z]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])|(([a-z]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])([a-z]|\\d|-|\\.|_|~|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])*([a-z]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])))$";
		String regex ="^([a-zA-Z0-9\\._-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]{2,30}){1,2})$";
		return check(regex, inputStr);
	}
	//验证用户名
	public static boolean checkUserName(String inputStr){
		String regex ="^[a-zA-Z\\d\\u4e00-\\u9fa5]+$";
		return check(regex, inputStr);
	}
	//验证座机
	public static boolean checkFixPhoneForStr(String inputStr){
		String regex ="(^0\\d{2,3}\\d{8}$)";
		return check(regex, inputStr);
	}
	//验证座机和手机
	public static boolean checkPhoneForStr(String inputStr){
		String regex ="(^1[3|4|5|7|8]\\d{9}$)|(^0\\d{2}\\d{8}$)|(^0\\d{3}\\d{8}$)";
		return check(regex, inputStr);
	}
	//验证手机
	public static boolean checkMobileForStr(String inputStr){
		String regex ="(^1[3|4|5|7|8]\\d{9}$)";
		return check(regex, inputStr);
	}
	//验证座机,手机，400
	public static boolean check400PhoneForStr(String inputStr){
		String regex ="(^1[3|4|5|7|8]\\d{9}$)|(^0\\d{2,3}\\d{8}$)|(^400\\d{7}$)";
		return check(regex, inputStr);
	}
	//验证400号码和座机
	public static boolean check400AndFixPhone(String inputStr){
		String regex="(^400\\d{7}$)|(^0\\d{2,3}\\d{8}$)";
		return check(regex, inputStr);
	}
	//验证组织机构号
	public static boolean checkOrgId(String inputStr){
		String regex ="^[a-zA-Z0-9]{8}(-)?[a-zA-Z0-9]$";
		return check(regex, inputStr);
	}
	//验证税务登记号
	public static boolean checkIttsId(String inputStr){
		String regex ="^[a-zA-Z0-9]{15,20}$";
		return check(regex, inputStr);
	}
	//营业执照
	public static boolean checkBsNum(String inputStr){
		String regex ="^[a-zA-Z0-9]{15}$";
		return check(regex, inputStr);
	}
	//验证银行卡号
	public static boolean checkBankNum(String inputStr){
		String regex ="^[0-9]+$";
		return check(regex, inputStr);
	}
	//验证邮编
	public static boolean checkPostNum(String inputStr){
		String regex ="^[0-9][0-9]{5,6}$";
		return check(regex, inputStr);
	}
	//验证是否包含特殊符号
	public static boolean constainsSymbol(String inputStr){
		if(isEmpty(inputStr)){
			return false;
		}
		String [] a = new String []{"@","#","￥","$","%","<", ">","/","!","~","`","^","&","*","(",")","=","+","{","}","?","《","》",",",".","。",":",";"};
	    for (int i=0; i < a.length; i++) {
	        if (inputStr.indexOf(a[i]) >= 0) { 
	            return true; 
	        }
	    }
	    return false;
	}
	//验证纳税人识别号
	public static boolean checkIdentification(String inputStr){
		String regex="(\\d{15})|(\\d{17})|(\\d{18})|(\\d{20})";
		return check(regex, inputStr);
	}
	//验证是否是数字或字符
	public static boolean checkLetterOrNum(String inputStr){
		String regex="^[A-Za-z0-9]+$";
		return check(regex, inputStr);
	}
	//验证是否是数字或"-"
	public static boolean verifyNum_or(String inputStr){
		String regex = "^[0-9\\-]+$";
		return check(regex, inputStr);
	}
	//验证金额
	public static boolean checkMoney(String inputStr){
		String regex="^[1-9]\\d*$";
		return check(regex, inputStr);
	}
	
	//验证金额（有小数点）
	public static boolean verfiyMoneySmall(String inputStr) {
		if (inputStr==null || inputStr.equals("") || inputStr.equals("0")) {
			return false;
		}
		String regex ="^[0-9]+([.]{1}[0-9]{0,6}){0,1}$";
		return check(regex, inputStr);
	}
	
	//数字金额（有小数点），余额提醒可为负数
	public static boolean verfiyMoneySmall_(String inputStr) {
		String regex ="^-?[0-9]+([.]{1}[0-9]{0,4}){0,1}$";
		return check(regex, inputStr);
	}
	
	//验证乱码
	public static boolean checkWrongString(String inputStr){
		String regex ="^[0-9a-zA-Z/.!@#$%^&*()_+=\\-`~/.,——/:[\u4E00-\uFA29]|[\uE7C7-\uE7F3]]+$";
		return check(regex, inputStr);
	}
	
	//验证是否超过n对{}
	public static boolean checkBraces(String inputStr){
		String regex = "([^\\{\\}]*\\{[^\\{\\}]*\\}[^\\{\\}]*){0,}";
		return check(regex, inputStr);
	}
	
	/**
	*	判断是否为合法IP
	*	@returntheip
	*/
	public static boolean isIp(String ipAddress){
		String regex="([1-9]|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])(\\.(\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])){3}";
		return check(regex, ipAddress);
	}
	
	/**
	*	判断字符串是否为半角
	*/
	public static boolean isHalfAngle(String str){
		String regex="^[\\u0000-\\u00FF]+$";
		return check(regex, str);
	}
	
	/**
	*	判断ivr文件名：英文+“.”+wav/mp3
	*/
	public static boolean isRightIvrName(String str){
		String regex="^[a-zA-Z]+[.][mp3|wav|pcm]+$";
		return check(regex, str);
	}
	
	private static boolean check(String regex,String inputStr){
		if(isEmpty(inputStr)){
			return false;
		}
		boolean boo = Pattern.matches(regex, inputStr);
		if(boo){
			return true;
		}
		return false;
	}
	public static boolean checkPwd(String inputStr){
		if(inputStr==null){
			return false;
		}
		String regex="^([A-Za-z]+\\d+|\\d+[A-Za-z]+)[A-Za-z\\d]*$";
		boolean boo = Pattern.matches(regex, inputStr);
		if(boo){
			return true;
		}
		return false;
	}
	public static String checkStrArray(String...str){
		String msg  = null ;
		for(String s : str){
			if(StrUtil.isEmpty(s)){
				msg = "false" ;
				break;
			}
		}
		return msg ;
	}
	public static String random8(){
		long a = (long)(Math.random()*90000000+10000000);
		return a+"" ;
	}
	public static boolean validationBracket(String str){
		String [] a = {"【","】","[","]"};
		boolean boo = false;
		if(StrUtil.isEmpty(str)){
			return boo;
		}
	    for (int i=0; i < a.length; i++) {
	        if (str.indexOf(a[i]) >= 0) {
	        	boo = true;
	        	break;
	        }
	    }
	    return boo;
	}
	public static String getClientIP(HttpServletRequest request) {
		String ip = request.getHeader("X-Real-IP");
		if (ip == null || ip.equals("")) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
	public static String getStringNoEnter(String str,String ff) {
        if(str!=null && !"".equals(str)) {      
            Pattern p = Pattern.compile("\\r|\\n");      
            Matcher m = p.matcher(str);      
            String strNoBlank = m.replaceAll(ff);
            String ss = strNoBlank.replaceAll(ff+ff,ff);
            return ss;      
        }else {      
            return str;      
        }           
    }
	
	public static String getPoint4(String str){
		String s[] = str.split("\\,");
		if(s.length>5){
			String a="";
			for(int i=0;i<s.length;i++){
				if(i%5==0&&i!=0)a=a+"<br>";
				a = a+s[i]+",";
			}
			return a;
		}else return str;
	}
	
	//获取字符串长度，包含中文，一个汉字长度*2
	public static int getWordCount(String s){
        int length = 0;  
        for(int i = 0; i < s.length(); i++)  
        {  
            int ascii = Character.codePointAt(s, i);  
            if(ascii >= 0 && ascii <=255)  
                length++;  
            else  
                length += 2;  
                  
        }  
        return length;  
          
    }
	
	//获取字符串长度，包含中文，一个汉字长度*3
	public static int getWordLength(String s){
        int length = 0;  
        for(int i = 0; i < s.length(); i++)  
        {  
            int ascii = Character.codePointAt(s, i);  
            if(ascii >= 0 && ascii <=255)  
                length++;  
            else  
                length += 3;  
                  
        }  
        return length;  
          
    }
	
	//检查汉字
	public static boolean isChineseName(String s) {
		Pattern pattern = Pattern.compile("([\u4E00-\uFA29]|[\uE7C7-\uE7F3])\\S*");
		Matcher matcher = pattern.matcher(s);
		if(matcher.find()){
			return true;
		}
		return false;
	}
	
	/**
	 * 得到浏览器名称
	 * */
	public static String getBrowserName(HttpServletRequest request) {
		String agent=request.getHeader("User-Agent").toLowerCase();
		if(agent.indexOf("msie")>0){
			return "ie";
		}else if(agent.indexOf("gecko")>0 && agent.indexOf("rv:11")>0){
			return "ie";
		}else{
			return "Others";
		}
	}
	
	
	/**
	 * 获取当前网络ip
	 * @param request
	 * @return
	 */
	public static String getIp(HttpServletRequest request){
		String ipAddress = request.getHeader("x-forwarded-for");
			if(ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
				ipAddress = request.getHeader("Proxy-Client-IP");
			}
			if(ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
				ipAddress = request.getHeader("WL-Proxy-Client-IP");
			}
			if(ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
				ipAddress = request.getRemoteAddr();
				if(ipAddress.equals("127.0.0.1") || ipAddress.equals("0:0:0:0:0:0:0:1")){
					//根据网卡取本机配置的IP
					InetAddress inet=null;
					try {
						inet = InetAddress.getLocalHost();
						ipAddress= inet.getHostAddress();
					} catch (UnknownHostException e) {
						e.printStackTrace();
					}
				}
			}
			//对于通过多个代理的情况，第一个IP为客户端真实IP,多个IP按照','分割
			if(ipAddress!=null && ipAddress.length()>15){ //"***.***.***.***".length() = 15
				if(ipAddress.indexOf(",")>0){
					ipAddress = ipAddress.substring(0,ipAddress.indexOf(","));
				}
			}
			return ipAddress; 
	}
	
	/**
	 * 判断小数点右边的位数是否大于输入值。
	 * 
	 * @param 小数，位数
	 * 
	 * @author JasonHe
	 * 
	 * @return 不大于输入值：true ; 大于输入值：false
	 */
	public static boolean checkDecimalDigit(double decimal,int digit){
		try {
			logger.debug("decimal(入参：小数)={},digit(判断的小数点位数)={}",Double.toString(decimal),digit);
			String format="0.#";
			if(digit>0){
				for(int i=0;i<digit+10;i++){
					format=format+"#";
				}
			}
			DecimalFormat decimalFormat = new DecimalFormat(format);//格式化设置  
	        String s = decimalFormat.format(decimal);
	        logger.debug("将double转换后的字符串="+s);
			int index = s.indexOf(".");
			if(index>-1){
				int length = s.substring(index+1).length();
				logger.debug("小数点右边字符串的长度="+length);
				if(digit<length){
					logger.debug("小数{}，小数点后位数超过{}位",decimal,digit);
					return false;
				}
			}
			logger.debug("小数{}，小数点后位数不超过{}位",decimal,digit);
			return true;
		} catch (Exception e) {
			return false;
		}
	}
	
	/**
	 * 判断小数点左边的位数是否大于输入值。
	 * 
	 * @param 小数，位数
	 * 
	 * @author JasonHe
	 * 
	 * @return 不大于输入值：true ; 大于输入值：false
	 */
	public static boolean checkDecimalInt(double decimal,int digit){
		try{
			logger.debug("decimal(入参：小数)={},digit(判断的小数点位数)={}",Double.toString(decimal),digit);
			String format="0.#";
			if(digit>0){
				for(int i=0;i<digit+10;i++){
					format=format+"#";
				}
			}
			DecimalFormat decimalFormat = new DecimalFormat(format);//格式化设置  
	        String s = decimalFormat.format(decimal);
	        logger.debug("将double转换后的字符串="+s);
			int index = s.indexOf(".");
			int length=0;
			if(index==-1){
				length = s.length();
			}else{
				String sleft = s.substring(0, index);
				logger.debug("小数点左边的字符串="+sleft);
				length = sleft.length();
			}
			logger.debug("小数点左边字符串的长度="+length);
			if(digit<length){
				logger.debug("小数{}，小数点后位数超过{}位",decimal,digit);
				return false;
			}
			logger.debug("小数{}，小数点后位数不超过{}位",decimal,digit);
			return true;
		} catch (Exception e) {
			return false;
		}
	}
	
	/** 
     * double 乘法 
     * @param d1 
     * @param d2 
     * @return 
     */ 
    public static double mul(double d1,int d2){ 
        BigDecimal bd1 = new BigDecimal(Double.toString(d1)); 
        BigDecimal bd2 = new BigDecimal(Integer.toString(d2)); 
        return bd1.multiply(bd2).doubleValue(); 
    } 
    
    /**
     * 获得中文
     * */
    public static String getChinese() {
		String str = null;
		int highPos, lowPos;
		Random random = new Random();
		highPos = (176 + Math.abs(random.nextInt(71)));//区码，0xA0打头，从第16区开始，即0xB0=11*16=176,16~55一级汉字，56~87二级汉字
		random=new Random();
		lowPos = 161 + Math.abs(random.nextInt(94));//位码，0xA0打头，范围第1~94列

		byte[] bArr = new byte[2];
		bArr[0] = (new Integer(highPos)).byteValue();
		bArr[1] = (new Integer(lowPos)).byteValue();
		try {
			str = new String(bArr, "GB2312");	//区位码组合成汉字
		} catch (Exception e) {
			e.printStackTrace();
		}
		return str;
	}
    
    public static String getRandomChineseName(){
    	Random random=new Random(System.currentTimeMillis());
		/* 598 百家姓 */
		String[] Surname= {"赵","钱","孙","李","周","吴","郑","王","冯","陈","褚","卫","蒋","沈","韩","杨","朱","秦","尤","许",
				  "何","吕","施","张","孔","曹","严","华","金","魏","陶","姜","戚","谢","邹","喻","柏","水","窦","章","云","苏","潘","葛","奚","范","彭","郎",
				  "鲁","韦","昌","马","苗","凤","花","方","俞","任","袁","柳","酆","鲍","史","唐","费","廉","岑","薛","雷","贺","倪","汤","滕","殷",
				  "罗","毕","郝","邬","安","常","乐","于","时","傅","皮","卞","齐","康","伍","余","元","卜","顾","孟","平","黄","和",
				  "穆","萧","尹","姚","邵","湛","汪","祁","毛","禹","狄","米","贝","明","臧","计","伏","成","戴","谈","宋","茅","庞","熊","纪","舒",
				  "屈","项","祝","董","梁","杜","阮","蓝","闵","席","季","麻","强","贾","路","娄","危","江","童","颜","郭","梅","盛","林","刁","钟",
				  "徐","邱","骆","高","夏","蔡","田","樊","胡","凌","霍","虞","万","支","柯","昝","管","卢","莫","经","房","裘","缪","干","解","应",
				  "宗","丁","宣","贲","邓","郁","单","杭","洪","包","诸","左","石","崔","吉","钮","龚","程","嵇","邢","滑","裴","陆","荣","翁","荀",
				  "羊","于","惠","甄","曲","家","封","芮","羿","储","靳","汲","邴","糜","松","井","段","富","巫","乌","焦","巴","弓","牧","隗","山",
				  "谷","车","侯","宓","蓬","全","郗","班","仰","秋","仲","伊","宫","宁","仇","栾","暴","甘","钭","厉","戎","祖","武","符","刘","景",
				  "詹","束","龙","叶","幸","司","韶","郜","黎","蓟","溥","印","宿","白","怀","蒲","邰","从","鄂","索","咸","籍","赖","卓","蔺","屠",
				  "蒙","池","乔","阴","郁","胥","能","苍","双","闻","莘","党","翟","谭","贡","劳","逄","姬","申","扶","堵","冉","宰","郦","雍","却",
				  "璩","桑","桂","濮","牛","寿","通","边","扈","燕","冀","浦","尚","农","温","别","庄","晏","柴","瞿","阎","充","慕","连","茹","习",
				  "宦","艾","鱼","容","向","古","易","慎","戈","廖","庾","终","暨","居","衡","步","都","耿","满","弘","匡","国","文","寇","广","禄",
				  "阙","东","欧","殳","沃","利","蔚","越","夔","隆","师","巩","厍","聂","晁","勾","敖","融","冷","訾","辛","阚","那","简","饶","空",
				  "曾","毋","沙","乜","养","鞠","须","丰","巢","关","蒯","相","查","后","荆","红","游","郏","竺","权","逯","盖","益","桓","公","仉",
				  "督","岳","帅","缑","亢","况","郈","有","琴","归","海","晋","楚","闫","法","汝","鄢","涂","钦","商","牟","佘","佴","伯","赏","墨",
				  "哈","谯","篁","年","爱","阳","佟","言","福","南","火","铁","迟","漆","官","冼","真","展","繁","檀","祭","密","敬","揭","舜","楼",
				  "疏","冒","浑","挚","胶","随","高","皋","原","种","练","弥","仓","眭","蹇","覃","阿","门","恽","来","綦","召","仪","风","介","巨",
				  "木","京","狐","郇","虎","枚","抗","达","杞","苌","折","麦","庆","过","竹","端","鲜","皇","亓","老","是","秘","畅","邝","还","宾",
				  "闾","辜","纵","侴"};
		
		int index=random.nextInt(Surname.length-1);		
		String name = Surname[index]; //获得一个随机的姓氏
		
		int i=random.nextInt(3);
		/* 从常用字中选取一个或两个字作为名 */
		if(i==0){
			name+=getChinese()+getChinese()+getChinese();
		}else if(i==1){
			name+=getChinese()+getChinese();
		}else {
			name+=getChinese();
		}
		return name;
    }
	
	//生成十位随机数字字符串
	public static String random10(){
		long a = (long)(Math.random()*9000000000L+1000000000L);
		return a+"" ;
	}
	
	//保留两位小数，最后一位小数采用进一法
	public static String getNumber(Double a){
		BigDecimal num = new BigDecimal(String.valueOf(a));
		BigDecimal hundred = new BigDecimal("100");
		BigDecimal percentile = new BigDecimal("0.01");
		
		num = num.multiply(hundred);
		Double b = Double.valueOf(num.toString());
		b = Math.ceil(b);
		num = new BigDecimal(String.valueOf(b));
		num = num.multiply(percentile);
		
		
		return String.format("%.2f", Double.valueOf(num.toString()));
	}
	
	public static void main(String[] args) {
		System.out.println(StrUtil.checkMobileForStr("15986821308"));
	}
	
}
