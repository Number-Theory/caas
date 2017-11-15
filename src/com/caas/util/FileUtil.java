package com.caas.util;

import java.awt.Image;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLConnection;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class FileUtil {
	private static final String[] IMG_TYPE_LIST = {"jpg", "jpeg","gif","png"};
	private static Logger logger = LoggerFactory.getLogger(FileUtil.class);
	
	public static final long SYS_PIC_MAXSIZE=2*1024*1024;

	//创建文件并写入内容
	public static void createFile(String dirName, String fileName,
			String content) throws IOException {
		File file = createEmptyFile(dirName, fileName);
		setFileContent(file, content);
	}
	public static void setFileContent(File file,String content) throws IOException{
		OutputStream out = new FileOutputStream(file);
		out.write(content.getBytes());
		out.flush();
		out.close();
	}
	//创建文件夹
	public static void mkDir(String dirName){
		if (!isExist(dirName)) {
			new File(dirName).mkdirs();
		}
	}
	//根据文件夹名称和文件名创建文件
	public static File createEmptyFile(String dirName,String fileName) throws IOException{
		mkDir(dirName);
		File file1 = new File(dirName+fileName);
		if(!file1.exists()){
			file1.createNewFile();
		}
		return file1;
	}
	//获取目录下面的txt文件的内容
	@SuppressWarnings("unused")
	public static String getFileConToStr(String pathName) throws IOException {
		File file = new File(pathName);
		if(file==null){
			return null ;
		}
		BufferedReader  input = new BufferedReader(new FileReader(file));
		String ct = input.readLine();
		input.close();
		return ct;
	}
	//删除本地文件
	public static void deleteFile(String pathName){
		File file = new File(pathName);
		file.delete();
	}
	//判读文件是否存在
	public static boolean isExist(String fileName){
		File file = new File(fileName);
		if(file.exists()){
			return true ;
		}
		return false;
	}
	//修改文件内容
	public static void updateFileContent(String fileName,String content) throws IOException{
		File file = new File(fileName);
		setFileContent(file, content);
	}
	/**
	 * 下载文件
	 * 
	 * @param path
	 *            文件路径
	 */
	public static void download(String path,HttpServletResponse response) {
		String fileName = path.substring(path.lastIndexOf("/") + 1);
		InputStream in = null;
		OutputStream out = null;
		try {
			in = new FileInputStream(path); // 文件流
			// 设置response的Header
			response.reset();
			response.setCharacterEncoding("GBK");
			response.setHeader("Content-Disposition", "attachment;filename="
					+ new String(fileName.getBytes("GBK"), "ISO-8859-1"));
			response.setContentType(FileContentTypes.getContentType(fileName));
			out = new BufferedOutputStream(response.getOutputStream());
			byte[] buffer = new byte[16 * 1024];
			int len = 0;
			while ((len = in.read(buffer)) > 0) {
				out.write(buffer, 0, len);
			}
			out.flush();
		} catch (Exception e) {
			logger.error("下载文件失败：path=" + path, e);
		} finally {
			try {
				if (in != null) {
					in.close();
				}
				if (out != null) {
					out.close();
				}
			} catch (IOException e) {
				logger.error("关闭文件失败：path=" + path, e);
			}
		}
		logger.debug("下载文件成功：path=" + path);
	}
	public static void baseUpload(File file,String dir,String fileName){
		if(file==null){
			return;
		}
		File toFile = null;
		try {
			toFile = FileUtil.createEmptyFile(dir, fileName);
		} catch (IOException e1) {
			e1.printStackTrace();
			logger.error("------------------------上传图片 生成指定目录空文件失败------------------------");
			logger.error(e1.getMessage());
		}
		//基于myFile创建一个文件输入流  
        InputStream is = null;
		try {
			is = new FileInputStream(file);
		} catch (FileNotFoundException e1) {
			e1.printStackTrace();
			logger.error("------------------------上传图片 创建文件流失败------------------------");
			logger.error(e1.getMessage());
		}  
		
        // 创建一个输出流  
        OutputStream os = null;
		try {
			os = new FileOutputStream(toFile);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			logger.error("------------------------上传图片 创建文件输出流失败------------------------");
			logger.error(e.getMessage());
		}  
  
        //设置缓存  
        byte[] buffer = new byte[1024];  
  
        int length = 0;  
  
        //读取myFile文件输出到toFile文件中  
        try {
        	if(null != is && null != os){
        		while ((length = is.read(buffer)) > 0) {  
    			    os.write(buffer, 0, length);  
    			}
        	}
		} catch (IOException e) {
			e.printStackTrace();
			logger.error("------------------------上传图片 读文件流失败------------------------");
			logger.error(e.getMessage());
		}  
        //关闭入流  
        try {
        	ColserUtils.closeEx(is);
        	ColserUtils.closeEx(os);
		} catch (IOException e) {
			e.printStackTrace();
			logger.error("------------------------上传图片  关闭输入输出流失败------------------------");
			logger.error(e.getMessage());
		}  
	}
	public static String upload(File file,String sid,String path,String suffix){
		// 设置上传文件目录  
		String upDir = path;  
		
		// 设置目标文件  
		String uuid = StrUtil.getUUID();
		String dateDir = System.currentTimeMillis()+"";
//		String suffix = getFileType(file);
		String fileName = "/"+uuid+"_"+dateDir+"."+suffix;
		String dir = upDir+sid;
		String filepath = dir+fileName ;
		baseUpload(file, dir, fileName);
        return filepath; 
       
	}
	public static String uploadRing(File file,String id,String path,String type,String fileType){
        // 设置目标文件  
        String fileName = id+"_"+type+"."+fileType;
		baseUpload(file, path, fileName);
        return fileName; 
       
	}
	
	public static String ringFileName(String id,String type,String fileType){
        // 设置目标文件  
		if(type != null){
			type = "_"+type;
		}else{
			type="";
		}
        String fileName = id+type+"."+fileType;
        return fileName; 
       
	}
	//获取图片后缀
	public static String getFileType(File file){
		String type = null;
		InputStream s = null;
		String mimeType = null;
		try {
			s = new BufferedInputStream(new FileInputStream(file));
			mimeType = URLConnection.guessContentTypeFromStream(s);
			if(mimeType != null) {
				type = mimeType.substring(mimeType.lastIndexOf("/")+1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("------------------------上传图片 获取上传文件的类型失败------------------------");
			logger.error(e.getMessage());
		}
		return type;
	}
	public static String checkFile(File file,long size){
		int rest = checkFileSize(file,size);
		String msg = null ;
		//文件大小超过限制
		if(rest==1){
			msg = "文件大小超过限制" ;
		}else if(rest==2){
			msg = "文件不能为空" ;
		}
		return msg ;
	}
	private static int checkFileSize(File file,long size){
		final long MAX_SIZE = size;
		if(file!=null){
			if(file.length()>MAX_SIZE){
				return 1 ;
			}else{
				return 0 ;
			}
		}else{
			return 2 ;
		}
	}
	public static boolean checkImgType(File file){
		boolean boo = false ;
		if(file==null){
			return false;
		}
		String suffix = getFileType(file);
		String [] imgs = IMG_TYPE_LIST;
		for(String str: imgs){
			if(str.equalsIgnoreCase(suffix)){
				boo = true;
				break;
			}
		}
		if(!isImageByWidthHeight(file)){
			return false;
		}
		return boo ;
	}
	
	/** 
	 * 通过读取文件并获取其width及height的方式，来判断判断当前文件是否图片，这是一种非常简单的方式。 
	 *  
	 * @param imageFile 
	 * @return 
	 */  
	public static boolean isImageByWidthHeight(File imageFile) {
	    if (!imageFile.exists()) {
	        return false;
	    }
	    Image img = null;
	    try {
	        img = ImageIO.read(imageFile);
	        if (img == null || img.getWidth(null) <= 0 || img.getHeight(null) <= 0) {
	            return false;  
	        }
	        return true;
	    } catch (Exception e) {
	        return false;
	    } finally {
	        img = null;
	    }
	}
	
	//将File类型转换为byte
	public static byte[] fileToByte(File f){  
        if (f == null){
            return null;  
        }  
        try{
            FileInputStream stream = new FileInputStream(f);  
            ByteArrayOutputStream out = new ByteArrayOutputStream(1000);
            byte[] b = new byte[1000];  
            int n;  
            while ((n = stream.read(b)) != -1)  
                out.write(b, 0, n);  
                stream.close();  
                out.close();  
            return out.toByteArray();  
        } catch (IOException e){  
            e.printStackTrace();  
        }  
        return null;  
	}  
}
