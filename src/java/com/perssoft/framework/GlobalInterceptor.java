package com.perssoft.framework;

import com.perssoft.aop.Interceptor;
import com.perssoft.aop.Invocation;
import com.perssoft.common.SysConstants;
import com.perssoft.core.Controller;
import com.perssoft.system.model.Admin;

/**
 * Interceptor
 */
public class GlobalInterceptor implements Interceptor {
	
	public void intercept(Invocation ai) {
		 Controller controller=ai.getController();
		 Admin admin =(Admin) controller.getSessionAttr(SysConstants.Session_AdminInfo);
		 if(admin !=null ){
			 ai.invoke();
		 }else{
			 System.out.println("session is null,redirect to logout");
			 controller.redirect("/logout.jsp");
			 
		 }
	}
}
