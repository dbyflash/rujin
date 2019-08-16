package com.perssoft.system.controller;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.perssoft.aop.Before;
import com.perssoft.common.SysConstants;
import com.perssoft.common.bean.ZTreeInfo;
import com.perssoft.framework.GlobalInterceptor;
import com.perssoft.framework.PerssoftController;
import com.perssoft.kit.JsonKit;
import com.perssoft.plugin.activerecord.Db;
import com.perssoft.plugin.activerecord.Json;
import com.perssoft.plugin.activerecord.PageData;
import com.perssoft.system.model.Admin;
import com.perssoft.system.model.Resource;
import com.perssoft.system.model.Role;

/**
 * BlogController 所有 sql 写在 Model 或 Service 中，不要写在 Controller
 * 中，养成好习惯，有利于大型项目的开发与维护
 */
@Before(GlobalInterceptor.class)
public class RoleController extends PerssoftController<Role> {

	public void index() {
		render("/WEB-INF/jsp/system/roleList.jsp");
	}
	
	public void list(){
		PageData<Role> page=Role.dao.pageList(getParaMap());
		renderJson(page);
	}
	
	public void getAllRoles(){
	List<Role> list=Role.dao.getAllRoles();
	renderText(JsonKit.toJson(list));
	}
	
	@Override
	public void edit() {
		super.edit();
		render("/WEB-INF/jsp/system/roleForm.jsp");
	}
	
	
	
	public void leftmenu(){
		Admin admin =getSessionAttr(SysConstants.Session_AdminInfo);
		List<ZTreeInfo> trees=Resource.dao.getUserResource(admin.getInt("id"));
		setAttr("json",  JsonKit.toJson(trees));
		render("/menu.jsp");
	}
	
	/**
	 * 获取右侧资源列表
	 */
	public void resourcelist() {

		Integer roleid = getParaToInt("roleid");
		List<ZTreeInfo> all = Resource.dao.getRightMenuResources(roleid);
		String json = JsonKit.toJson(all);
		setAttr("json", json);
		setAttr("id", roleid);
		render("/WEB-INF/jsp/system/roleMenuset.jsp");
	}
	
	/**
	 * 保存资源列表
	 */
	public void saveResource(){
		Integer roleid=getParaToInt("id");
		String menuids =getPara("resourceids");
		  Json json = new Json(Json.STAE_CODE_SUCCESS, "保存成功！");
		try {
		
		if(StringUtils.isNotBlank(menuids)){
           	//清除其所有权限
			Role.dao.removeAllRight(roleid);
			List<String> sqlllist=new ArrayList<String>();
			String[] menuidsArray=menuids.split(",");
			for (int i = 0; menuidsArray != null && i < menuidsArray.length; i++) {
				String sql="insert into xt_role_resource(roleid,resourceid) values("+roleid+","+menuidsArray[i]+")";
				sqlllist.add(sql);
			}
			Db.batch(sqlllist, 100);
		}else{
			Role.dao.removeAllRight(roleid);
		}
		
		} catch (Exception e) {
			 json = new Json(Json.STAE_CODE_ERROR, "保存失败！");
		}
		 renderJson(json);
	}
	
	
	
	
}
