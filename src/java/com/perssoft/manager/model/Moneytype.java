package com.perssoft.manager.model;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.perssoft.aop.Before;
import com.perssoft.plugin.activerecord.Db;
import com.perssoft.plugin.activerecord.Model;
import com.perssoft.plugin.activerecord.PageData;
import com.perssoft.plugin.activerecord.tx.Tx;

public class Moneytype extends Model<Moneytype> {
	public static final Moneytype dao = new Moneytype();
  
	public PageData<Moneytype> pageList(Map<String, String> map) {
		String sql = " from moneytype where 1=1 ";
		if (StringUtils.isNotBlank(map.get("s_name"))) {
			sql += " and name like '%" + map.get("s_name") + "%'";
		}
		return paginate(map, "select *", sql);

	}
	public List<Moneytype> getlist(){
		String sql="select id,name from moneytype where 1=1";
		return this.find(sql);
	}


}
