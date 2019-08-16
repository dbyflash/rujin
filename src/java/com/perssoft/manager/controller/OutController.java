package com.perssoft.manager.controller;

import java.sql.SQLException;
import java.util.Map;

import com.perssoft.aop.Before;
import com.perssoft.framework.PerssoftController;
import com.perssoft.manager.model.BuyContract;
import com.perssoft.manager.model.ChangePlace;
import com.perssoft.manager.model.Out;
import com.perssoft.manager.model.Receipt;
import com.perssoft.manager.model.SellContract;
import com.perssoft.manager.model.SellPay;
import com.perssoft.manager.model.Send;
import com.perssoft.manager.model.Worker;
import com.perssoft.plugin.activerecord.Db;
import com.perssoft.plugin.activerecord.DbKit;
import com.perssoft.plugin.activerecord.Json;
import com.perssoft.plugin.activerecord.PageData;
import com.perssoft.plugin.activerecord.tx.Tx;
import com.perssoft.system.model.Admin;

public class OutController extends PerssoftController<Out> {

	
	@Override
	public void index() {
		render("/WEB-INF/jsp/manager/out/outList.jsp");
	}
	
	@Override
	public void create() {
		super.create();
		render("/WEB-INF/jsp/manager/out/outForm.jsp");
	}
	
	@Override
	public void edit() {
		super.edit();
		render("/WEB-INF/jsp/manager/out/outForm.jsp");
	}
	public void view() {
		super.edit();
		render("/WEB-INF/jsp/manager/out/outView.jsp");
	}
	
	@Override
	public void list() {
		Map map=getParaMap();
		Admin admin=getSessionAttr("ADMININFO");
		boolean check=this.checkAdmin(admin.getInt("id"));
		if(!check){
			map.put("userid", admin.getInt("id")+"");
		}
		PageData<Out> list=Out.dao.pageList(map);
		renderJson(list);
	}
	@Override
	public void save() {
		Json json = new Json(Json.STAE_CODE_SUCCESS, "保存成功！");
		boolean check=this.editCheck();
		if(!check){
			json = new Json(Json.STAE_CODE_ERROR, "出库单已存在！");
			renderJson(json);
			return;
		}
		try {

			Out object = getModel(modelClass);
				
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
	public boolean editCheck(){
		String id=getPara("id");
		String number=getPara("number");
		Map map=getParaMap();
		map.put("id", id);
		Out bean=Out.dao.getByNumberId(map,number);
		if(bean==null){
			return true;
		}else{
			return false;
		}
	}
	
	
	
}
