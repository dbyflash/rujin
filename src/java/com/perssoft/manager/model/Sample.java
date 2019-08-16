package com.perssoft.manager.model;

import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.perssoft.aop.Before;
import com.perssoft.plugin.activerecord.Db;
import com.perssoft.plugin.activerecord.Model;
import com.perssoft.plugin.activerecord.PageData;
import com.perssoft.plugin.activerecord.tx.Tx;

public class Sample extends Model<Sample> {
	public static final Sample dao = new Sample();
  
	public PageData<Sample> pageList(Map<String, String> map) {
		String sql = " from samples where 1=1 ";
		if (StringUtils.isNotBlank(map.get("customerid"))) {
			sql += " and customerid = " + map.get("customerid") + "";
		}
		if (StringUtils.isNotBlank(map.get("s_number"))) {
			sql += " and number like '%" + map.get("s_number") + "%'";
		}
		if (StringUtils.isNotBlank(map.get("s_begin"))) {
			sql += " and dt >= '"+map.get("s_begin")+"' ";
		}
		if (StringUtils.isNotBlank(map.get("s_end"))) {
			sql += " and dt <= '"+map.get("s_end")+"' ";
		}
		return paginate(map, "select *", sql);

	}
	public Sample getByNumber(String number){
		String sql="select * from samples where number='"+number+"' ";
		return this.findFirst(sql);
	}


}
