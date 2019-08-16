package com.perssoft.system.model;

import java.util.List;
import java.util.Map;

import com.perssoft.common.tool.CommonUtility;
import com.perssoft.common.tool.QueryParser;
import com.perssoft.plugin.activerecord.Db;
import com.perssoft.plugin.activerecord.Model;
import com.perssoft.plugin.activerecord.PageData;

/**
 */
@SuppressWarnings("serial")
public class Admin extends Model<Admin> {
	public static final Admin dao = new Admin();
	
	/**
	 * 所有 sql 写在 Model 或 Service 中，不要写在 Controller 中，养成好习惯，有利于大型项目的开发与维护
	 */
	public Admin getLoginName(String loginname) {
		return (Admin) findFirst("select * from xt_admin where loginname='"+QueryParser.escapeSql(loginname)+"' order by id desc");
	}
	
	public PageData<Admin> pageList(Map map){
		String sql="from xt_admin where isdelete=0 ";
		if(!CommonUtility.isBlank(map.get("s_loginname"))){
			sql+=" and loginname='"+QueryParser.escapeSql(map.get("s_loginname"))+"'";
		}
		if(!CommonUtility.isBlank(map.get("s_name"))){
			sql+=" and name='"+QueryParser.escapeSql(map.get("s_name"))+"'";
		}
		sql+=" order by id asc";
		
		return paginate(map, "select *", sql);
	}

	public boolean checkAdmin(Integer id, String loginname) {
		String sql="";
		if(id==null){
			 sql="select * from xt_admin where loginname='"+QueryParser.escapeSql(loginname)+"' ";
		}else{
			 sql="select * from xt_admin where loginname='"+QueryParser.escapeSql(loginname)+"' and id !="+id;
		}
		
		List<Admin> list=this.find(sql);
		if(list.size()>0){
			return false;
		}
		return true;
	}

	public void removeAdminRoles(Integer para) {
		String sql="delete from xt_admin_role where adminid="+para;
		Db.update(sql);
	}
	
	 
	

}
