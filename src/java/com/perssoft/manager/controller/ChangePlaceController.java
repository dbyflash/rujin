package com.perssoft.manager.controller;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.Map;

import com.perssoft.aop.Before;
import com.perssoft.framework.PerssoftController;
import com.perssoft.kit.JsonKit;
import com.perssoft.manager.model.BuyContract;
import com.perssoft.manager.model.ChangePlace;
import com.perssoft.manager.model.SellContract;
import com.perssoft.manager.model.SellPay;
import com.perssoft.plugin.activerecord.Db;
import com.perssoft.plugin.activerecord.DbKit;
import com.perssoft.plugin.activerecord.Json;
import com.perssoft.plugin.activerecord.PageData;
import com.perssoft.plugin.activerecord.tx.Tx;
import com.perssoft.system.model.Admin;

public class ChangePlaceController extends PerssoftController<ChangePlace> {

	
	@Override
	public void index() {
		render("/WEB-INF/jsp/manager/changeplace/changeplaceList.jsp");
	}
	
	@Override
	public void create() {
		super.create();
		render("/WEB-INF/jsp/manager/changeplace/changeplaceForm.jsp");
	}
	
	@Override
	public void edit() {
		super.edit();
		render("/WEB-INF/jsp/manager/changeplace/changeplaceForm.jsp");
	}
	
	
	@Override
	public void list() {
		Map map=getParaMap();
		Admin admin=getSessionAttr("ADMININFO");
		boolean check=this.checkAdmin(admin.getInt("id"));
		if(!check){
			map.put("userid", admin.getInt("id")+"");
		}
		PageData<ChangePlace> list=ChangePlace.dao.pageList(map);
		renderJson(list);
	}
	@Override
	public void save() {
		Json json = new Json(Json.STAE_CODE_SUCCESS, "保存成功！");
		boolean check=this.editCheck();
		if(!check){
			json = new Json(Json.STAE_CODE_ERROR, "坯布流转已存在！");
			renderJson(json);
			return;
		}
		BuyContract buycontract=BuyContract.dao.getByNumber(getPara("cnumber"));
		BigDecimal bd=new BigDecimal(getPara("real"));
		bd=bd.setScale(2, BigDecimal.ROUND_HALF_UP); 
		if(buycontract!=null){
			if(bd.compareTo(buycontract.getBigDecimal("mount"))!=0){
				json = new Json(Json.STAE_CODE_ERROR, "实际数量必须与合同中的数量相同！");
				renderJson(json);
				return;
			}
		}
		try {

			ChangePlace object = getModel(modelClass);
				
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
	protected boolean doAfterSave(ChangePlace object) {
		//将坯布流转编号写入对应的合同
		if(getPara("cnumber")!=null&&!"".equals(getPara("cnumber"))){
			BuyContract bean=BuyContract.dao.getByNumber(getPara("cnumber"));
			bean.set("changeplacenumber", getPara("number"));
			bean.update();
		}
		return super.doAfterSave(object);
	}
	public void checkReplace(){
		String changeplacenumber=getPara("changeplacenumber");
		ChangePlace bean=ChangePlace.dao.getByNumber(changeplacenumber);
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
		ChangePlace bean=ChangePlace.dao.getByNumberId(map,number);
		if(bean==null){
			return true;
		}else{
			return false;
		}
	}
	
	
}
