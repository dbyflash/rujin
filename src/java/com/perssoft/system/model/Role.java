package com.perssoft.system.model;

import java.util.List;
import java.util.Map;

import com.perssoft.plugin.activerecord.Db;
import com.perssoft.plugin.activerecord.Model;
import com.perssoft.plugin.activerecord.PageData;

@SuppressWarnings("serial")
public class Role extends Model<Role> {
	public static final Role dao = new Role();

	public PageData<Role> pageList(Map<String, String> map) {
		String sql="from xt_role order by id asc";
		return paginate(map, "select *", sql);
	}
	
	public List<Role> getAllRoles(){
		String sql="select * from xt_role ";
		return this.find(sql);
	}

	public List<Role> getAdmin_Role(int adminid){
		String sql="select r.id as roleid from xt_admin_role  a " +
				" left join xt_role r on r.id=a.roleid " +
				" where a.adminid='"+adminid+"'";
		return this.find(sql);
	}

	public void removeAllRight(Integer xt_roleid) {
		String sql="delete from xt_role_resource where roleid="+xt_roleid;
		Db.update(sql);
	}
	
	 


	 
	

}
