package com.perssoft.system.controller;

import java.util.List;
import java.util.Set;

import org.apache.commons.lang.StringUtils;

import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.stat.DruidDataSourceStatManager;
import com.perssoft.aop.Before;
import com.perssoft.aop.Clear;
import com.perssoft.common.SysConstants;
import com.perssoft.common.tool.EncryptUtil;
import com.perssoft.core.Controller;
import com.perssoft.ext.interceptor.POST;
import com.perssoft.kit.JsonKit;
import com.perssoft.manager.model.DomPosition;
import com.perssoft.plugin.activerecord.Json;
import com.perssoft.system.model.Admin;
import com.perssoft.system.model.Resource;

/**
 * 登陆
 * 
 * @author wzq
 * 
 */
public class LoginController extends Controller {
	/**
	 * 跳转到欢迎页面或者登陆页面
	 */
	public void index() {
		render("/index.jsp");
	}
	@Clear
	public void console(){
		    Set<DruidDataSource> dataSources = DruidDataSourceStatManager.getDruidDataSourceInstances();
		    this.setAttr("datasource", dataSources);
		    render("/console.jsp");
	}
	
	
	
	public void homepage() {
		Admin admin=getSessionAttr(SysConstants.Session_AdminInfo);
		List<DomPosition> list=DomPosition.dao.getByAdminid(admin.getInt("id")+"");
		setAttr("list", JsonKit.toJson(list));
		render("/homepage.jsp");
	}
	
	//左侧菜单
	public void leftmenu() {
		Admin admin=getSessionUser();
		List<Resource> trees=Resource.dao.getUserResource(admin,getPara("p_id"));
		renderJson(trees);
	}

	/**
	 * 登陆
	 */
	@Clear
	@Before(POST.class) 
	public void login() {
		String loginname = getPara("loginname");
		String password = getPara("password");
		Json json =new Json(Json.STAE_CODE_ERROR,"登录失败");
		Admin admin = Admin.dao.getLoginName(loginname);
		if (admin != null) {
			if (StringUtils.isNotBlank(password)) {
				if (admin.get("pwd").toString().trim().equals(
						EncryptUtil.encrypt(password.trim()))) {
					if ("0".equals(admin.get("isforbidden").toString())) {
						setSessionAttr(SysConstants.Session_AdminInfo, admin);
						 json =new Json(Json.STAE_CODE_SUCCESS,"登录成功");
					} else {
						 json =new Json(Json.STAE_CODE_ERROR,"用户被禁用");
					}

				} else {
					 json =new Json(Json.STAE_CODE_ERROR,"密码错误");
				}
			}
		} else {
			 json =new Json(Json.STAE_CODE_ERROR,"不存在该用户");
		}
		
		renderJson(json);
	}
	
	public Admin getSessionUser(){
		return getSessionAttr(SysConstants.Session_AdminInfo);
	}
	
	
	//显示左侧菜单
	public void showLeft(){
			renderJsp("/leftFrame.jsp");
	}
	//显示顶部frame
	public void showTop(){
		//获取顶层的列表
		Admin admin=getSessionUser();
		List<Resource> toplist=Resource.dao.findMyTopFunc(admin);		
		setAttr("toplist", JsonKit.toJson(toplist));
		renderJsp("/topFrame.jsp");
	}
	
	
	

}
