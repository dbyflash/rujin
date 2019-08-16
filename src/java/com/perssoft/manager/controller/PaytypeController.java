package com.perssoft.manager.controller;

import java.sql.SQLException;

import com.perssoft.aop.Before;
import com.perssoft.framework.PerssoftController;
import com.perssoft.manager.model.Customer;
import com.perssoft.manager.model.Paytype;
import com.perssoft.manager.model.SellContract;
import com.perssoft.manager.model.SellPay;
import com.perssoft.plugin.activerecord.Db;
import com.perssoft.plugin.activerecord.DbKit;
import com.perssoft.plugin.activerecord.Json;
import com.perssoft.plugin.activerecord.PageData;
import com.perssoft.plugin.activerecord.tx.Tx;

public class PaytypeController extends PerssoftController<Paytype> {

	
	@Override
	public void index() {
		render("/WEB-INF/jsp/manager/paytype/paytypeList.jsp");
	}
	
	@Override
	public void create() {
		super.create();
		render("/WEB-INF/jsp/manager/paytype/paytypeForm.jsp");
	}
	
	@Override
	public void edit() {
		super.edit();
		render("/WEB-INF/jsp/manager/paytype/paytypeForm.jsp");
	}
	
	
	@Override
	public void list() {
		PageData<Paytype> list=Paytype.dao.pageList(getParaMap());
		renderJson(list);
	}
	@Override
	public void save() {
		Json json = new Json(Json.STAE_CODE_SUCCESS, "保存成功！");
		try {

			Paytype object = getModel(modelClass);
				
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
