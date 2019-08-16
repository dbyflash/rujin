package com.perssoft.framework;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.perssoft.handler.Handler;

public class URLHandler extends Handler {

	public void handle(String target, HttpServletRequest request,
			HttpServletResponse response, boolean[] isHandled) {
		String[] targetarr=target.split("[?]");
		if (targetarr[0].endsWith(".do")){
			target = target.substring(0,target.length()-3);
			System.out.println(target);
			nextHandler.handle(target, request, response, isHandled);
		}
	}
}
