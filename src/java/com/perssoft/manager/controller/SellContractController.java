package com.perssoft.manager.controller;

import java.sql.SQLException;
import java.util.Map;

import com.perssoft.aop.Before;
import com.perssoft.framework.PerssoftController;
import com.perssoft.manager.model.SellContract;
import com.perssoft.manager.model.Worker;
import com.perssoft.plugin.activerecord.Db;
import com.perssoft.plugin.activerecord.DbKit;
import com.perssoft.plugin.activerecord.Json;
import com.perssoft.plugin.activerecord.PageData;
import com.perssoft.plugin.activerecord.tx.Tx;
import com.perssoft.system.model.Admin;

public class SellContractController extends PerssoftController<SellContract> {

	
	@Override
	public void index() {
		render("/WEB-INF/jsp/manager/sellcontract/sellcontractList.jsp");
	}
	
	@Override
	public void create() {
		super.create();
		render("/WEB-INF/jsp/manager/sellcontract/sellcontractForm.jsp");
	}
	
	@Override
	public void edit() {
		super.edit();
		render("/WEB-INF/jsp/manager/sellcontract/sellcontractForm.jsp");
	}
	public void selectProduct(){
		render("/WEB-INF/jsp/system/selectProduct.jsp");
	}
	public void selectCustomer(){
		render("/WEB-INF/jsp/system/selectCustomer.jsp");
	}
	
	@Override
	public void list() {
		Map map=getParaMap();
		Admin admin=getSessionAttr("ADMININFO");
		boolean check=this.checkAdmin(admin.getInt("id"));
		if(!check){
			map.put("userid", admin.getInt("id")+"");
		}
		PageData<SellContract> list=SellContract.dao.pageList(map);
		renderJson(list);
	}
	@Override
	public void save() {
		Json json = new Json(Json.STAE_CODE_SUCCESS, "保存成功！");
		boolean check=this.editCheck();
		if(!check){
			json = new Json(Json.STAE_CODE_ERROR, "合同已存在！");
			renderJson(json);
			return;
		}
		try {

			SellContract object = getModel(modelClass);
				
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


		} catch (Exception e) {
			e.printStackTrace();
			json = new Json(Json.STAE_CODE_ERROR, "保存失败！");
		}
		renderJson(json);
	}
	public void checkContract(){
		String cnumber=getPara("cnumber");
		SellContract bean=SellContract.dao.getByNumber(cnumber);
		if(bean!=null){
			renderJson(true);
		}else{
			renderJson(false);
		}
	}
	/*public void checkAgain(){
		String number=getPara("number");
		SellContract bean=SellContract.dao.getByNumber(number);
		if(bean==null){
			renderJson(true);
		}else{
			renderJson(false);
		}
	}*/
	public boolean editCheck(){
		String id=getPara("id");
		String number=getPara("number");
		Map map=getParaMap();
		map.put("id", id);
		SellContract bean=SellContract.dao.getByNumberId(map,number);
		if(bean==null){
			return true;
		}else{
			return false;
		}
	}
	public void checkPay(){
		String number=getPara("number");
		SellContract bean=SellContract.dao.payView(number);
		setAttr("bean", bean);
		renderJsp("/WEB-INF/jsp/manager/sellcontract/sellcontractView.jsp");
	}
	
	
}
