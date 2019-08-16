package com.perssoft.manager.model;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.perssoft.aop.Before;
import com.perssoft.plugin.activerecord.Db;
import com.perssoft.plugin.activerecord.Model;
import com.perssoft.plugin.activerecord.PageData;
import com.perssoft.plugin.activerecord.tx.Tx;

public class Material extends Model<Material> {
	public static final Material dao = new Material();
  
	public PageData<Material> pageList(Map<String, String> map) {
		String sql = " from material where 1=1 ";
		if (StringUtils.isNotBlank(map.get("s_name"))) {
			sql += " and name like '%" + map.get("s_name") + "%'";
		}
		return paginate(map, "select *", sql);

	}
	public List<Material> getlist(){
		String sql = "select id,name from material where 1=1 ";
		return this.find(sql);
	}


}
