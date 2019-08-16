package com.perssoft.manager.model;

import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.perssoft.aop.Before;
import com.perssoft.plugin.activerecord.Db;
import com.perssoft.plugin.activerecord.Model;
import com.perssoft.plugin.activerecord.PageData;
import com.perssoft.plugin.activerecord.tx.Tx;

public class Cost extends Model<Cost> {
	public static final Cost dao = new Cost();
  
	public PageData<Cost> pageList(Map<String, String> map) {
		String sql = " from costs where 1=1 ";
		if (StringUtils.isNotBlank(map.get("s_name"))) {
			sql += " and name like '%" + map.get("s_name") + "%'";
		}
		if (StringUtils.isNotBlank(map.get("s_cnumber"))) {
			sql += " and cnumber like '%" + map.get("s_cnumber") + "%'";
		}
		if (StringUtils.isNotBlank(map.get("s_begin"))) {
			sql += " and dt >= '"+map.get("s_begin")+"' ";
		}
		if (StringUtils.isNotBlank(map.get("s_end"))) {
			sql += " and dt <= '"+map.get("s_end")+"' ";
		}
		if (StringUtils.isNotBlank(map.get("type"))) {
			sql += " and type = '" + map.get("type") + "'";
		}
		return paginate(map, "select *", sql);

	}
	


}
