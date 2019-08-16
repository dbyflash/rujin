package com.perssoft.manager.controller;

import java.sql.SQLException;
import java.util.List;

import com.perssoft.aop.Before;
import com.perssoft.framework.PerssoftController;
import com.perssoft.manager.model.Customer;
import com.perssoft.manager.model.Provider;
import com.perssoft.manager.model.SellContract;
import com.perssoft.manager.model.SellPay;
import com.perssoft.plugin.activerecord.Db;
import com.perssoft.plugin.activerecord.DbKit;
import com.perssoft.plugin.activerecord.Json;
import com.perssoft.plugin.activerecord.PageData;
import com.perssoft.plugin.activerecord.tx.Tx;

public class ProviderController extends PerssoftController<Provider> {

	
	@Override
	public void index() {
		render("/WEB-INF/jsp/manager/provider/providerList.jsp");
	}
	
	@Override
	public void create() {
		super.create();
		render("/WEB-INF/jsp/manager/provider/providerForm.jsp");
	}
	
	@Override
	public void edit() {
		super.edit();
		render("/WEB-INF/jsp/manager/provider/providerForm.jsp");
	}
	
	
	@Override
	public void list() {
		PageData<Provider> list=Provider.dao.pageList(getParaMap());
		renderJson(list);
	}
	public void getlist() {
		List<Provider> list=Provider.dao.getlist();
		renderJson(list);
	}
	@Override
	public void save() {
		Json json = new Json(Json.STAE_CODE_SUCCESS, "保存成功！");
		try {

			Provider object = getModel(modelClass);
				
				boolean bo = validateToken();
				if (!bo) {
					json = new Json(Json.STAE_CODE_ERROR, "重复提交！");
					renderJson(json);
					return;
				}
				
				
				if (getParaToInt("id") == null) {
					
					object.save();
				} else {
					object.update();
				}


		} catch (Exception e) {
			e.printStackTrace();
			json = new Json(Json.STAE_CODE_ERROR, "保存失败！");
		}
		renderJson(json);
	}
	
	
	
	
}
