package com.caas.util;

import java.math.BigDecimal;
import java.text.DecimalFormat;

public class NumUtil {

	/**
	 * @author CD
	 * 2017-5-11		
	 * @param parseNum 需处理的数据
	 * @param size 保留几位小数
	 * @return
	 * 四舍五入 保留 
	 */
	public static double round(double parseNum,int size){
		BigDecimal b = new BigDecimal(parseNum);
		return b.setScale(size, BigDecimal.ROUND_HALF_UP).doubleValue();
	}
	
	/**
	 * @author CD
	 * 2017-5-11		
	 * @param paseObject
	 * @param formatterStr
	 * @return
	 * 返回指定格式的数字类型
	 */
	public static double formatterData(double paseObject,String formatterStr){
		DecimalFormat fmt=new DecimalFormat(formatterStr);
		return  Double.valueOf(fmt.format(paseObject)) ;
	}
	
}
