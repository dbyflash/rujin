package com.perssoft.framework;

import java.lang.reflect.ParameterizedType;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.perssoft.core.Controller;
import com.perssoft.plugin.activerecord.Json;
import com.perssoft.plugin.activerecord.Model;
import com.perssoft.system.model.Role;
@SuppressWarnings("unchecked")
public abstract class PerssoftController<T extends Model> extends Controller {
	protected Class<T> modelClass;

	@Override
	public void init(HttpServletRequest request,
			HttpServletResponse response, String urlPara) {
		super.init(request, response, urlPara);
		modelClass = (Class<T>) ((ParameterizedType) getClass()
				.getGenericSuperclass()).getActualTypeArguments()[0];
	}

	public void index() {

	}

	public void list() {

	}

	public void create() {
		edit();
	}

	
	public void edit() {
		createToken();
		T object = null;
		if (getParaToInt("id") == null) {
			try {
				object = modelClass.newInstance();
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			object = (T) getModel(modelClass).findById(getParaToInt("id"));
		}
		setAttr("bean", object.getAttrs());
	}

	public void save() {
		Json json = new Json(Json.STAE_CODE_SUCCESS, "保存成功！");
		try {

			T object = getModel(modelClass);

			if (doBeforeSave(object)) {
				
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

			} else {
				return;
			}

		} catch (Exception e) {
			e.printStackTrace();
			json = new Json(Json.STAE_CODE_ERROR, "保存失败！");
		}
		renderJson(json);
	}

	protected boolean doBeforeSave(T object) {

		return true;
	}

	protected boolean doAfterSave(T object) {

		return true;
	}

	public void delete() {
		Json json = new Json(Json.STAE_CODE_SUCCESS, "删除成功！");
		try {
			getModel(modelClass).deleteById(getParaToInt("id"));
		} catch (Exception e) {
			json = new Json(Json.STAE_CODE_ERROR, "删除失败！");
		}
		renderJson(json);
	}

	public void isdelete() {
		Json json = new Json(Json.STAE_CODE_SUCCESS, "删除成功！");
		try {
			T object = getModel(modelClass);
			object.set("isdelete", 1);
			object.update();
		} catch (Exception e) {
			json = new Json(Json.STAE_CODE_ERROR, "删除失败！");
		}
		renderJson(json);
	}
	public boolean checkAdmin(int adminid){
		List<Role> rolelist=Role.dao.getAdmin_Role(adminid);
		for(int i=0;i<rolelist.size();i++){
			if(rolelist.get(i).getInt("roleid")==1){
				return true;
			}
		}
		return false;
	}

}
