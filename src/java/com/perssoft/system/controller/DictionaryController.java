package com.perssoft.system.controller;

import java.util.List;

import com.perssoft.aop.Before;
import com.perssoft.framework.GlobalInterceptor;
import com.perssoft.framework.PerssoftController;
import com.perssoft.system.model.Dictionary;

/**
 * BlogController 所有 sql 写在 Model 或 Service 中，不要写在 Controller
 * 中，养成好习惯，有利于大型项目的开发与维护
 */
@Before(GlobalInterceptor.class)
public class DictionaryController extends PerssoftController<Dictionary> {

	public void index() {
		render("/WEB-INF/jsp/system/dictionaryList.jsp");
	}
	
	public void list(){
		List list=Dictionary.dao.pageList(getParaMap());
		renderJson(list);
		//System.out.println(JsonKit.listToJson(list, 1));
	}

	public void edit() {
		super.edit();
		render("/WEB-INF/jsp/system/dictionaryForm.jsp");
	
	}
	
	@Override
	protected boolean doBeforeSave(Dictionary object) {
		if(object.get("id")==null){//新增
			String parentid = getPara("parentid");
			object.set("parentid", parentid);
			object.set("isdelete", 0);
		}
		return super.doBeforeSave(object);
	}
	
	
	
	
	
	
}
