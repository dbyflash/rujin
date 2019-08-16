package com.perssoft.manager.controller;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.perssoft.aop.Before;
import com.perssoft.framework.PerssoftController;
import com.perssoft.manager.model.BuyContract;
import com.perssoft.manager.model.ChangePlace;
import com.perssoft.manager.model.SellContract;
import com.perssoft.manager.model.SellPay;
import com.perssoft.manager.model.Worker;
import com.perssoft.plugin.activerecord.Db;
import com.perssoft.plugin.activerecord.DbKit;
import com.perssoft.plugin.activerecord.Json;
import com.perssoft.plugin.activerecord.PageData;
import com.perssoft.plugin.activerecord.tx.Tx;
import com.perssoft.system.model.Admin;
import com.perssoft.system.model.Role;

public class BuyContractController extends PerssoftController<BuyContract> {

	
	@Override
	public void index() {
		render("/WEB-INF/jsp/manager/buycontract/buycontractList.jsp");
	}
	
	@Override
	public void create() {
		super.create();
		render("/WEB-INF/jsp/manager/buycontract/buycontractForm.jsp");
	}
	
	@Override
	public void edit() {
		super.edit();
		render("/WEB-INF/jsp/manager/buycontract/buycontractForm.jsp");
	}
	public void selectMaterial() {
		render("/WEB-INF/jsp/system/selectMaterial.jsp");
	}
	public void selectProvider() {
		render("/WEB-INF/jsp/system/selectProvider.jsp");
	}
	@Override
	public void list() {
		Map map=getParaMap();
		Admin admin=getSessionAttr("ADMININFO");
		boolean check=this.checkAdmin(admin.getInt("id"));
		if(!check){
			map.put("userid", admin.getInt("id")+"");
		}
		PageData<BuyContract> list=BuyContract.dao.pageList(map);
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
		ChangePlace changeplace=ChangePlace.dao.getByNumber(getPara("changeplacenumber"));
		BigDecimal bd=new BigDecimal(getPara("mount"));
		bd=bd.setScale(2, BigDecimal.ROUND_HALF_UP); 
		if(changeplace!=null){
			if(bd.compareTo(changeplace.getBigDecimal("real"))!=0){
				json = new Json(Json.STAE_CODE_ERROR, "数量必须与坯布流转中的实际数量相同！");
				renderJson(json);
				return;
			}
		}
		try {

			BuyContract object = getModel(modelClass);
				
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
	@Override
	protected boolean doAfterSave(BuyContract object) {
		//将合同编号写入对应的坯布流转
		if(getPara("changeplacenumber")!=null&&!"".equals(getPara("changeplacenumber"))){
			ChangePlace bean=ChangePlace.dao.getByNumber(getPara("changeplacenumber"));
			bean.set("cnumber", getPara("number"));
			bean.update();
		}
		return super.doAfterSave(object);
	}
	public void checkContract(){
		String cnumber=getPara("cnumber");
		BuyContract bean=BuyContract.dao.getByNumber(cnumber);
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
		BuyContract bean=BuyContract.dao.getByNumberId(map,number);
		if(bean==null){
			return true;
		}else{
			return false;
		}
	}
	
	
}
