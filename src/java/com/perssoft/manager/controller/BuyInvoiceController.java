package com.perssoft.manager.controller;

import java.sql.SQLException;
import java.util.Map;

import com.perssoft.aop.Before;
import com.perssoft.framework.PerssoftController;
import com.perssoft.manager.model.BuyContract;
import com.perssoft.manager.model.BuyInvoice;
import com.perssoft.manager.model.ChangePlace;
import com.perssoft.manager.model.SellContract;
import com.perssoft.manager.model.SellPay;
import com.perssoft.manager.model.Worker;
import com.perssoft.plugin.activerecord.Db;
import com.perssoft.plugin.activerecord.DbKit;
import com.perssoft.plugin.activerecord.Json;
import com.perssoft.plugin.activerecord.PageData;
import com.perssoft.plugin.activerecord.tx.Tx;

public class BuyInvoiceController extends PerssoftController<BuyInvoice> {

	
	@Override
	public void index() {
		render("/WEB-INF/jsp/manager/buyinvoice/buyinvoiceList.jsp");
	}
	
	@Override
	public void create() {
		super.create();
		render("/WEB-INF/jsp/manager/buyinvoice/buyinvoiceForm.jsp");
	}
	
	@Override
	public void edit() {
		super.edit();
		render("/WEB-INF/jsp/manager/buyinvoice/buyinvoiceForm.jsp");
	}
	
	
	@Override
	public void list() {
		PageData<BuyInvoice> list=BuyInvoice.dao.pageList(getParaMap());
		renderJson(list);
	}
	@Override
	public void save() {
		Json json = new Json(Json.STAE_CODE_SUCCESS, "保存成功！");
		boolean check=this.editCheck();
		if(!check){
			json = new Json(Json.STAE_CODE_ERROR, "发票已存在！");
			renderJson(json);
			return;
		}
		try {

			BuyInvoice object = getModel(modelClass);
				
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
	@Override
	protected boolean doAfterSave(BuyInvoice object) {
		//将合同编号写入对应的坯布流转
		if(getPara("changeplacenumber")!=null&&!"".equals(getPara("changeplacenumber"))){
			ChangePlace bean=ChangePlace.dao.getByNumber(getPara("changeplacenumber"));
			bean.set("cnumber", getPara("number"));
			bean.update();
		}
		return super.doAfterSave(object);
	}
	public boolean editCheck(){
		String id=getPara("id");
		String number=getPara("number");
		Map map=getParaMap();
		map.put("id", id);
		BuyInvoice bean=BuyInvoice.dao.getByNumberId(map,number);
		if(bean==null){
			return true;
		}else{
			return false;
		}
	}
	
	
	
}
