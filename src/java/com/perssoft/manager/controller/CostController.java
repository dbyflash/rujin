package com.perssoft.manager.controller;

import java.sql.SQLException;

import com.perssoft.aop.Before;
import com.perssoft.framework.PerssoftController;
import com.perssoft.manager.model.BuyContract;
import com.perssoft.manager.model.ChangePlace;
import com.perssoft.manager.model.Cost;
import com.perssoft.manager.model.Receipt;
import com.perssoft.manager.model.Sample;
import com.perssoft.manager.model.SellContract;
import com.perssoft.manager.model.SellPay;
import com.perssoft.manager.model.Send;
import com.perssoft.manager.model.Worker;
import com.perssoft.plugin.activerecord.Db;
import com.perssoft.plugin.activerecord.DbKit;
import com.perssoft.plugin.activerecord.Json;
import com.perssoft.plugin.activerecord.PageData;
import com.perssoft.plugin.activerecord.tx.Tx;

public class CostController extends PerssoftController<Cost> {

	
	@Override
	public void index() {
		render("/WEB-INF/jsp/manager/cost/costList.jsp");
	}
	public void specialJSP() {
		render("/WEB-INF/jsp/manager/cost/specialList.jsp");
	}
	
	@Override
	public void create() {
		super.create();
		render("/WEB-INF/jsp/manager/cost/costForm.jsp");
	}
	public void createSpecial() {
		super.create();
		render("/WEB-INF/jsp/manager/cost/specialForm.jsp");
	}
	
	@Override
	public void edit() {
		super.edit();
		render("/WEB-INF/jsp/manager/cost/costForm.jsp");
	}
	public void editSpecial() {
		super.edit();
		render("/WEB-INF/jsp/manager/cost/specialForm.jsp");
	}
	
	@Override
	public void list() {
		PageData<Cost> list=Cost.dao.pageList(getParaMap());
		renderJson(list);
	}
	@Override
	public void save() {
		Json json = new Json(Json.STAE_CODE_SUCCESS, "保存成功！");
		try {

			Cost object = getModel(modelClass);
				
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
				if (!doAfterSave(object)) {
					return;
				}


		} catch (Exception e) {
			e.printStackTrace();
			json = new Json(Json.STAE_CODE_ERROR, "保存失败！");
		}
		renderJson(json);
	}
	public void saveSpecial() {
		Json json = new Json(Json.STAE_CODE_SUCCESS, "保存成功！");
		try {

			Cost object = getModel(modelClass);
				
				boolean bo = validateToken();
				if (!bo) {
					json = new Json(Json.STAE_CODE_ERROR, "重复提交！");
					renderJson(json);
					return;
				}
				
				
				if (getParaToInt("id") == null) {
					object.set("type", 1);
					object.save();
					
				} else {
					object.update();
				}
				if (!doAfterSave(object)) {
					return;
				}


		} catch (Exception e) {
			e.printStackTrace();
			json = new Json(Json.STAE_CODE_ERROR, "保存失败！");
		}
		renderJson(json);
	}
	
	
	
}
