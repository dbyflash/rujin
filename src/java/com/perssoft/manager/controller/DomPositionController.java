package com.perssoft.manager.controller;

import com.perssoft.common.SysConstants;
import com.perssoft.framework.PerssoftController;
import com.perssoft.manager.model.DomPosition;
import com.perssoft.plugin.activerecord.Json;
import com.perssoft.system.model.Admin;

public class DomPositionController extends PerssoftController<DomPosition>{
	
	
	public void save() {
		Json json = new Json(Json.STAE_CODE_SUCCESS, "保存成功！");
		try {

			DomPosition object = getModel(modelClass);

			if (doBeforeSave(object)) {
				Admin admin=getSessionAttr(SysConstants.Session_AdminInfo);
				String domid=getPara("domid");
				String adminid=admin.getInt("id")+"";
				DomPosition bean=DomPosition.dao.getByAdminidDomid(adminid, domid);
				if (bean == null) {
					object.set("adminid",adminid );
					object.save();
				} else {
					bean.set("positionx", getPara("positionx"));
					bean.set("positiony", getPara("positiony"));
					bean.set("domwidth", getPara("domwidth"));
					bean.set("domheight", getPara("domheight"));
					bean.update();
				}
				if (!doAfterSave(object)) {
					return;
				}

			} else {
				return;
			}

		} catch (Exception e) {
			e.printStackTrace();
			json = new Json(Json.STAE_CODE_ERROR, "保存失败！");
		}
		renderJson(json);
	}

}
