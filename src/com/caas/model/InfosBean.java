package com.caas.model;
/**
 * 
 * @author xupiao 2017年4月17日
 *
 */
public class InfosBean extends BaseBean {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1239518593367167321L;

	private String host;
	private String port;

	public String getHost() {
		return host;
	}

	public void setHost(String host) {
		this.host = host;
	}

	public String getPort() {
		return port;
	}

	public void setPort(String port) {
		this.port = port;
	}
}
