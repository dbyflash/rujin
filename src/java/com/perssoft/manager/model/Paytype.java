package com.perssoft.manager.model;

import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.perssoft.aop.Before;
import com.perssoft.plugin.activerecord.Db;
import com.perssoft.plugin.activerecord.Model;
import com.perssoft.plugin.activerecord.PageData;
import com.perssoft.plugin.activerecord.tx.Tx;

public class Paytype extends Model<Paytype> {
	public static final Paytype dao = new Paytype();
  
	public PageData<Paytype> pageList(Map<String, String> map) {
		String sql = " from paytype where 1=1 ";
		if (StringUtils.isNotBlank(map.get("s_name"))) {
			sql += " and name like '%" + map.get("s_name") + "%'";
		}
		return paginate(map, "select *", sql);

	}
	


}
