package com.perssoft.manager.model;

import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.perssoft.aop.Before;
import com.perssoft.plugin.activerecord.Db;
import com.perssoft.plugin.activerecord.Model;
import com.perssoft.plugin.activerecord.PageData;
import com.perssoft.plugin.activerecord.tx.Tx;

public class SellPay extends Model<SellPay> {
	public static final SellPay dao = new SellPay();
  
	public PageData<SellPay> pageList(Map<String, String> map) {
		String sql = " from sellpay where 1=1 ";
		if (StringUtils.isNotBlank(map.get("s_unitname"))) {
			sql += " and unitname like '%" + map.get("s_unitname") + "%'";
		}
		if (StringUtils.isNotBlank(map.get("s_number"))) {
			sql += " and number like '%" + map.get("s_number") + "%'";
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
		return paginate(map, "select *", sql);

	}
	


}
