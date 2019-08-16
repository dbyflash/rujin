package com.perssoft.manager.controller;

import java.sql.SQLException;
import java.util.Map;

import com.perssoft.aop.Before;
import com.perssoft.framework.PerssoftController;
import com.perssoft.manager.model.BuyContract;
import com.perssoft.manager.model.ChangePlace;
import com.perssoft.manager.model.Receipt;
import com.perssoft.manager.model.SellContract;
import com.perssoft.manager.model.SellPay;
import com.perssoft.manager.model.Storage;
import com.perssoft.manager.model.Worker;
import com.perssoft.plugin.activerecord.Db;
import com.perssoft.plugin.activerecord.DbKit;
import com.perssoft.plugin.activerecord.Json;
import com.perssoft.plugin.activerecord.PageData;
import com.perssoft.plugin.activerecord.tx.Tx;
import com.perssoft.system.model.Admin;

public class StorageController extends PerssoftController<Storage> {

	
	@Override
	public void index() {
		render("/WEB-INF/jsp/manager/storage/storageList.jsp");
	}
	
	@Override
	public void create() {
		super.create();
		render("/WEB-INF/jsp/manager/storage/storageForm.jsp");
	}
	
	@Override
	public void edit() {
		super.edit();
		render("/WEB-INF/jsp/manager/storage/storageForm.jsp");
	}
	
	
	@Override
	public void list() {
		Map map=getParaMap();
		Admin admin=getSessionAttr("ADMININFO");
		boolean check=this.checkAdmin(admin.getInt("id"));
		if(!check){
			map.put("userid", admin.getInt("id")+"");
		}
		PageData<Storage> list=Storage.dao.pageList(map);
		renderJson(list);
	}
	@Override
	public void save() {
		Json json = new Json(Json.STAE_CODE_SUCCESS, "保存成功！");
		boolean check=this.editCheck();
		if(!check){
			json = new Json(Json.STAE_CODE_ERROR, "入库单已存在！");
			renderJson(json);
			return;
		}
		try {

			Storage object = getModel(modelClass);
				
				boolean bo = validateToken();
				if (!bo) {
					json = new Json(Json.STAE_CODE_ERROR, "重复提交！");
					renderJson(json);
					return;
				}
				
				
				if (getParaToInt("id") == null) {
					Admin admin=getSessionAttr("ADMININFO");
					object.set("userid", admin.getInt("id"));
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
	
	public void checkStorage(){
		String snumber=getPara("snumber");
		Storage bean=Storage.dao.getByNumber(snumber);
		if(bean!=null){
			renderJson(true);
		}else{
			renderJson(false);
		}
	}
	public boolean editCheck(){
		String id=getPara("id");
		String number=getPara("number");
		Map map=getParaMap();
		map.put("id", id);
		Storage bean=Storage.dao.getByNumberId(map,number);
		if(bean==null){
			return true;
		}else{
			return false;
		}
	}
	
	
}
