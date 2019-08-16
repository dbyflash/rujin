package com.perssoft.manager.model;

import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.perssoft.aop.Before;
import com.perssoft.common.tool.CommonUtility;
import com.perssoft.common.tool.QueryParser;
import com.perssoft.plugin.activerecord.Db;
import com.perssoft.plugin.activerecord.Model;
import com.perssoft.plugin.activerecord.PageData;
import com.perssoft.plugin.activerecord.tx.Tx;

public class SellInvoice extends Model<SellInvoice> {
	public static final SellInvoice dao = new SellInvoice();
  
	public PageData<SellInvoice> pageList(Map<String, String> map) {
		String sql = " from sellinvoice where 1=1 ";
		if (StringUtils.isNotBlank(map.get("productid"))) {
			sql += " and productid = " + map.get("productid") + "";
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
	public SellInvoice getByNumberId(Map<String, String> map,String number){
		String sql="select * from sellinvoice where number='"+number+"' ";
		if(!CommonUtility.isBlank(map.get("id"))){
			sql+=" and  id != '"+QueryParser.escapeSql(map.get("id"))+"'";
		}
		return this.findFirst(sql);
	}


}
