package com.perssoft.system.controller;

import java.util.List;

import com.perssoft.common.bean.TreeData;
import com.perssoft.framework.PerssoftController;
import com.perssoft.kit.JsonKit;
import com.perssoft.plugin.activerecord.Db;
import com.perssoft.system.model.Resource;

public class ResourceController extends PerssoftController<Resource> {

	public void index(){
		render("/WEB-INF/jsp/system/menuManageList.jsp");
	}
	
	public void menuManage(){
		render("/WEB-INF/jsp/system/menuManage.jsp");
	}
	
	@Override
	public void edit() {
		super.edit();
		render("/WEB-INF/jsp/system/menuManageForm.jsp");
	}
	
	
	
	
	public void getResourceTree() {
		Integer roleid=getParaToInt("roleid");
	    List<TreeData> list=Resource.dao.getAllResourceByRole(roleid);
		renderText(JsonKit.toJson(list));
	}
	
	
	
	
	@Override
	protected boolean doBeforeSave(Resource object) {
		
		Integer pid=getParaToInt("pid");
		System.out.println("pid:"+pid);
		if(pid!=null && pid==0){
			object.set("pid", null);
		}
		object.set("leaf", 1);
		object.set("restype","url");
		object.set("openType","tab");
		
		return super.doBeforeSave(object);
	}
	
	
	@Override
	protected boolean doAfterSave(Resource object) {
		Integer roleid=getParaToInt("roleid");
		
		Integer pid=object.getInt("pid");
		if(pid!=null){
			Resource parent= Resource.dao.findById(pid);
			Integer leaf=parent.get("leaf");
			if(leaf==null || leaf==1){
				parent.set("leaf", 0);
				parent.update();
			}
		}
		Integer id=getParaToInt("id");
		if(id==null){
			//插入角色_资源关联表
			Resource.dao.insertRole_Resource(roleid,object.getInt("id"));
		}
		
		
		
		return super.doAfterSave(object);
	}
	
	
	
	
}
