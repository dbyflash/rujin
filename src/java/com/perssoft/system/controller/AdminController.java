package com.perssoft.system.controller;

import java.util.ArrayList;
import java.util.List;

import com.perssoft.aop.Before;
import com.perssoft.common.SysConstants;
import com.perssoft.common.tool.CommonUtility;
import com.perssoft.common.tool.EncryptUtil;
import com.perssoft.framework.GlobalInterceptor;
import com.perssoft.framework.PerssoftController;
import com.perssoft.kit.JsonKit;
import com.perssoft.plugin.activerecord.Db;
import com.perssoft.plugin.activerecord.Json;
import com.perssoft.plugin.activerecord.PageData;
import com.perssoft.system.model.Admin;
import com.perssoft.system.model.Role;

/**
 * AdminController 所有 sql 写在 Model 或 Service 中，不要写在 Controller
 * 中，养成好习惯，有利于大型项目的开发与维护
 */
@Before(GlobalInterceptor.class)
public class AdminController extends PerssoftController<Admin> {

	public void index() {
		render("/WEB-INF/jsp/system/adminList.jsp");
	}
	
	public void list(){
		PageData<Admin> page=Admin.dao.pageList(getParaMap());
		renderJson(page);
	}
	
	@Override
	protected boolean doBeforeSave(Admin object) {
		if(CommonUtility.isBlank(getPara("id"))){
			object.set("pwd", EncryptUtil.encrypt("123"));
			object.set("isdelete", 0);
			
		}
	
		return super.doBeforeSave(object);
	}
	
	@Override
	protected boolean doAfterSave(Admin object) {
		Admin.dao.removeAdminRoles(object.getInt("id"));
		String roleids=getPara("roleids");
		List<String> sqlllist=new ArrayList<String>();
		String[] roleidsArray=roleids.split(",");
		for (int i = 0; roleidsArray != null && i < roleidsArray.length; i++) {
			String sql="insert into xt_admin_role(roleid,adminid) values("+roleidsArray[i]+","+object.getInt("id")+")";
			sqlllist.add(sql);
		}
		Db.batch(sqlllist, 100);
		return super.doAfterSave(object);
	}
	 
    @Override
	public void edit() {
    	createToken();
		Admin admin=null;
		if(getParaToInt("id")==null){
			admin=new Admin();
		}else{
			admin=Admin.dao.findById(getParaToInt("id"));
			List<Role> list=Role.dao.getAdmin_Role(admin.getInt("id"));
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < list.size(); i++) {
				if(i==0){
					sb.append(list.get(i).get("roleid"));
				}else {
					sb.append(","+list.get(i).get("roleid"));
				}
			}
			setAttr("roleids", sb.toString());
		}
		setAttr("bean", admin.getAttrs());
		render("/WEB-INF/jsp/system/adminForm.jsp");
	}

	

	public void delete() {
		Admin.dao.deleteById(getParaToInt());
	}

    public void checkAdmin(){
    	Json json=null;
    	Integer id=getParaToInt("id");
    	String loginname=getPara("loginname");
    	boolean bo=Admin.dao.checkAdmin(id,loginname);
    	if(bo){
    		json = new Json(Json.STAE_CODE_SUCCESS, "ok");
    	}else{
    		json = new Json(Json.STAE_CODE_SUCCESS, "no");
    	}
    	renderJson(json);
    }
    //顶端密码重置
    public void passwordReset() {
    	createToken();
    	Admin admin =(Admin) getSessionAttr(SysConstants.Session_AdminInfo);
    	setAttr("bean", admin.getAttrs());
		render("/WEB-INF/jsp/system/passwordResetForm.jsp");
	}
    //密码重置
    public void passwordResetAction(){
    	boolean bo = validateToken();
		if (!bo) {
			Json json = new Json(Json.STAE_CODE_ERROR, "重复提交！");
			renderJson(json);
			return;
		}
    	Json json=null;
		try {
			String id=getPara("id");
			Admin admin =Admin.dao.findById(id);
			admin.set("pwd",EncryptUtil.encrypt(getPara("pwd")));
			admin.update();
			json=new Json(Json.STAE_CODE_SUCCESS,"重置成功！");
		} catch (Exception e) {
			 e.printStackTrace();
			 json=new Json(Json.STAE_CODE_ERROR,"重置失败！");
		}
    	
		renderJson(json);
    }
  

}
