package com.caas.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.caas.util.AuthorityUtils;

/**
 * 
 * @author xupiao 2017年2月4日
 *
 */
@Component
public class AuthorityFilter implements Filter {
	private static final Logger logger = LoggerFactory.getLogger(AuthorityFilter.class);
	private String[] excludeEqualUrls; // 等于此路径不需要控制
	private String[] excludeStartUrls; // 以此路径开始不需要控制

	/**
	 * 检查是否有访问权限
	 * 
	 * @param request
	 * @return
	 */
	private boolean check(HttpServletRequest request, HttpServletResponse response) {
		String reqUrl = request.getServletPath();
		
		if (reqUrl.indexOf('.') > -1) {// url包含.且不是.action，直接跳过
			if (reqUrl.endsWith(".action")) {
				reqUrl = reqUrl.substring(0, reqUrl.length() - 7);
			} else {
				return true;
			}
		}
		for (String excludeUrl : excludeStartUrls) { // 以此路径开始不需要控制，直接跳过
			if (reqUrl.startsWith(excludeUrl)) {
				return true;
			}
		}
		for (String excludeUrl : excludeEqualUrls) { // 等于此路径不需要控制，直接跳过
			if (reqUrl.equals(excludeUrl)) {
				return true;
			}
		}

		if (AuthorityUtils.isLogin(request) && !"/".equals(reqUrl)) {
			return true;
		}
		logger.debug("没有访问权限：reqUrl={}", reqUrl);
		return false;
	}

	@Override
	public void doFilter(ServletRequest paramServletRequest, ServletResponse paramServletResponse,
			FilterChain paramFilterChain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) paramServletRequest;
		HttpServletResponse response = (HttpServletResponse) paramServletResponse;
		if (check(request, response)) {
			String host = request.getRemoteAddr();
			request.getSession().setAttribute("host", host);
			paramFilterChain.doFilter(paramServletRequest, paramServletResponse);
			return;
		}
		response.sendRedirect("/homePage/portal");
		return;
	}

	@Override
	public void init(FilterConfig paramFilterConfig) throws ServletException {
		ServletContext servletContext = paramFilterConfig.getServletContext();
		servletContext.setAttribute("ctx", servletContext.getContextPath());
		logger.info("set ctx = " + servletContext.getContextPath());

		String exclude = paramFilterConfig.getInitParameter("excludeEqualUrls");
		if (exclude != null) {
			excludeEqualUrls = exclude.split(",");
		}

		exclude = paramFilterConfig.getInitParameter("excludeStartUrls");
		if (exclude != null) {
			excludeStartUrls = exclude.split(",");
		}
	}

	@Override
	public void destroy() {
	}
}
