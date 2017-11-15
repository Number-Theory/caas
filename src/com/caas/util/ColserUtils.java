package com.caas.util;

import java.io.Closeable;
import java.io.IOException;

public class ColserUtils {
	public final static void closeEx(Closeable closeable) throws IOException {
		if(null != closeable){
			closeable.close();
		}
	}
	public final static void close(Closeable closeable) {
		try {
			closeEx(closeable);
		} catch (IOException e) {
		}
	}
}
