package com.caas.util;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;

/**
 * TODO 生成验证码
 * 
 * @author 29p9g02
 * @version
 */
public class CheckCodeUtil {

	/* 该方法主要作用是获得随机生成的颜色 */
	@SuppressWarnings("unused")
	private static Color getRandColor(int s, int e) {
		Random random = new Random();
		if (s > 255)
			s = 255;
		if (e > 255)
			e = 255;
		int r, g, b;
		r = s + random.nextInt(e - s); // 随机生成RGB颜色中的r值
		g = s + random.nextInt(e - s); // 随机生成RGB颜色中的g值
		b = s + random.nextInt(e - s); // 随机生成RGB颜色中的b值
		return new Color(r, g, b);
	}

	public static void makeCheckCode(HttpServletRequest request, HttpServletResponse response) throws ServletException,
			IOException {
		// 设置不缓存图片
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "No-cache");
		response.setDateHeader("Expires", 0);
		// 指定生成的响应图片,一定不能缺少这句话,否则错误.
		response.setContentType("image/jpeg");
		int width = 86, height = 39; // 指定生成验证码的宽度和高度
		BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB); // 创建BufferedImage对象,其作用相当于一图片
		Graphics g = image.getGraphics(); // 创建Graphics对象,其作用相当于画笔
		// Graphics2D g2d=(Graphics2D)g; //创建Grapchics2D对象
		Random random = new Random();
		Font mfont = new Font("宋体", Font.BOLD, 21); // 定义字体样式
		// g.setColor(getRandColor(200,250)); //背景颜色
		g.fillRect(0, 0, width, height); // 绘制背景
		g.setFont(mfont); // 设置字体
		g.setColor(new Color(73, 128, 192)); // 图片颜色
		g.drawRect(0, 0, width - 1, height - 1); // 图片边线
		/*
		 * for(int i=0;i<50;i++){ int x=random.nextInt(width-1); int
		 * y=random.nextInt(height-1); int x1=random.nextInt(6)+1; int
		 * y1=random.nextInt(12)+1; BasicStroke bs=new
		 * BasicStroke(2f,BasicStroke.CAP_BUTT,BasicStroke.JOIN_BEVEL); //定制线条样式
		 * Line2D line=new Line2D.Double(x,y,x+x1,y+y1); g2d.setStroke(bs);
		 * g2d.draw(line); //绘制直线 }
		 */
		// 输出由英文，数字，和中文随机组成的验证文字，具体的组合方式根据生成随机数确定。
		String sRand = "";
		String ctmp = "";
		int itmp = 0;
		// 制定输出的验证码为四位
		for (int i = 0; i < 4; i++) {
			switch (random.nextInt(3)) {
			case 1: // 生成A-Z的字母
				itmp = random.nextInt(26) + 65;
				ctmp = String.valueOf((char) itmp);
				break;
			/*
			 * case 2: //生成汉字 String[]
			 * rBase={"0","1","2","3","4","5","6","7","8"
			 * ,"9","a","b","c","d","e","f"}; //生成第一位区码 int
			 * r1=random.nextInt(3)+11; String str_r1=rBase[r1]; //生成第二位区码 int
			 * r2; if(r1==13){ r2=random.nextInt(7); }else{
			 * r2=random.nextInt(16); } String str_r2=rBase[r2]; //生成第一位位码 int
			 * r3=random.nextInt(6)+10; String str_r3=rBase[r3]; //生成第二位位码 int
			 * r4; if(r3==10){ r4=random.nextInt(15)+1; }else if(r3==15){
			 * r4=random.nextInt(15); }else{ r4=random.nextInt(16); } String
			 * str_r4=rBase[r4]; //将生成的机内码转换为汉字 byte[] bytes=new byte[2];
			 * //将生成的区码保存到字节数组的第一个元素中 String str_12=str_r1+str_r2; int
			 * tempLow=Integer.parseInt(str_12, 16); bytes[0]=(byte) tempLow;
			 * //将生成的位码保存到字节数组的第二个元素中 String str_34=str_r3+str_r4; int
			 * tempHigh=Integer.parseInt(str_34, 16); bytes[1]=(byte)tempHigh;
			 * ctmp=new String(bytes); break;
			 */
			default:
				itmp = random.nextInt(10) + 48;
				ctmp = String.valueOf((char) itmp);
				break;
			}
			sRand += ctmp;
			// Color color=new
			// Color(20+random.nextInt(110),20+random.nextInt(110),random.nextInt(110));
			// g.setColor(color);
			// 将生成的随机数进行随机缩放并旋转制定角度 PS.建议不要对文字进行缩放与旋转,因为这样图片可能不正常显示
			/*
			 * 将文字旋转制定角度 Graphics2D g2d_word=(Graphics2D)g; AffineTransform
			 * trans=new AffineTransform();
			 * trans.rotate((45)*3.14/180,15*i+8,7);
			 */
			/*
			 * 缩放文字 float scaleSize=random.nextFloat()+0.8f; if(scaleSize>1f)
			 * scaleSize=1f; trans.scale(scaleSize, scaleSize);
			 * g2d_word.setTransform(trans);
			 */
			g.drawString(ctmp, 15 * i + 15, 25);
		}
		HttpSession session = request.getSession(true);
		session.setAttribute("randCheckCode", sRand);
		g.dispose(); // 释放g所占用的系统资源
		ImageIO.write(image, "JPEG", response.getOutputStream()); // 输出图片
	}

	public static void makeCheckCode(HttpServletRequest request, HttpServletResponse response, String checkCodeId)
			throws ServletException, IOException {
		// 设置不缓存图片
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "No-cache");
		response.setDateHeader("Expires", 0);
		// 指定生成的响应图片,一定不能缺少这句话,否则错误.
		response.setContentType("image/jpeg");
		int width = 86, height = 39; // 指定生成验证码的宽度和高度
		BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB); // 创建BufferedImage对象,其作用相当于一图片
		Graphics g = image.getGraphics(); // 创建Graphics对象,其作用相当于画笔
		// Graphics2D g2d=(Graphics2D)g; //创建Grapchics2D对象
		Random random = new Random();
		Font mfont = new Font("宋体", Font.BOLD, 21); // 定义字体样式
		// g.setColor(getRandColor(200,250)); //背景颜色
		g.fillRect(0, 0, width, height); // 绘制背景
		g.setFont(mfont); // 设置字体
		g.setColor(new Color(73, 128, 192)); // 图片颜色
		g.drawRect(0, 0, width - 1, height - 1); // 图片边线
		/*
		 * for(int i=0;i<50;i++){ int x=random.nextInt(width-1); int
		 * y=random.nextInt(height-1); int x1=random.nextInt(6)+1; int
		 * y1=random.nextInt(12)+1; BasicStroke bs=new
		 * BasicStroke(2f,BasicStroke.CAP_BUTT,BasicStroke.JOIN_BEVEL); //定制线条样式
		 * Line2D line=new Line2D.Double(x,y,x+x1,y+y1); g2d.setStroke(bs);
		 * g2d.draw(line); //绘制直线 }
		 */
		// 输出由英文，数字，和中文随机组成的验证文字，具体的组合方式根据生成随机数确定。
		String sRand = "";
		String ctmp = "";
		int itmp = 0;
		// 制定输出的验证码为四位
		for (int i = 0; i < 4; i++) {
			switch (random.nextInt(3)) {
			case 1: // 生成A-Z的字母
				itmp = random.nextInt(26) + 65;
				ctmp = String.valueOf((char) itmp);
				break;
			/*
			 * case 2: //生成汉字 String[]
			 * rBase={"0","1","2","3","4","5","6","7","8"
			 * ,"9","a","b","c","d","e","f"}; //生成第一位区码 int
			 * r1=random.nextInt(3)+11; String str_r1=rBase[r1]; //生成第二位区码 int
			 * r2; if(r1==13){ r2=random.nextInt(7); }else{
			 * r2=random.nextInt(16); } String str_r2=rBase[r2]; //生成第一位位码 int
			 * r3=random.nextInt(6)+10; String str_r3=rBase[r3]; //生成第二位位码 int
			 * r4; if(r3==10){ r4=random.nextInt(15)+1; }else if(r3==15){
			 * r4=random.nextInt(15); }else{ r4=random.nextInt(16); } String
			 * str_r4=rBase[r4]; //将生成的机内码转换为汉字 byte[] bytes=new byte[2];
			 * //将生成的区码保存到字节数组的第一个元素中 String str_12=str_r1+str_r2; int
			 * tempLow=Integer.parseInt(str_12, 16); bytes[0]=(byte) tempLow;
			 * //将生成的位码保存到字节数组的第二个元素中 String str_34=str_r3+str_r4; int
			 * tempHigh=Integer.parseInt(str_34, 16); bytes[1]=(byte)tempHigh;
			 * ctmp=new String(bytes); break;
			 */
			default:
				itmp = random.nextInt(10) + 48;
				ctmp = String.valueOf((char) itmp);
				break;
			}
			sRand += ctmp;
			// Color color=new
			// Color(20+random.nextInt(110),20+random.nextInt(110),random.nextInt(110));
			// g.setColor(color);
			// 将生成的随机数进行随机缩放并旋转制定角度 PS.建议不要对文字进行缩放与旋转,因为这样图片可能不正常显示
			/*
			 * 将文字旋转制定角度 Graphics2D g2d_word=(Graphics2D)g; AffineTransform
			 * trans=new AffineTransform();
			 * trans.rotate((45)*3.14/180,15*i+8,7);
			 */
			/*
			 * 缩放文字 float scaleSize=random.nextFloat()+0.8f; if(scaleSize>1f)
			 * scaleSize=1f; trans.scale(scaleSize, scaleSize);
			 * g2d_word.setTransform(trans);
			 */
			g.drawString(ctmp, 15 * i + 15, 25);
		}
		HttpSession session = request.getSession(true);
		session.setAttribute("randCheckCode", sRand);
//		RedisUtil.set(checkCodeId, sRand, 60 * 10);
		g.dispose(); // 释放g所占用的系统资源
		ImageIO.write(image, "JPEG", response.getOutputStream()); // 输出图片
	}

	/**
	 * 验证是否正确
	 * 
	 * @param request
	 * @return
	 */
	public static boolean check(HttpServletRequest request) {
		String input = request.getParameter("randCheckCode");
		String session = (String) request.getSession(true).getAttribute("randCheckCode");
		if (StringUtils.isNotBlank(session) && StringUtils.isNotBlank(input)
				&& session.trim().equalsIgnoreCase(input.trim())) {
			return true;
		}
		return false;
	}
}
