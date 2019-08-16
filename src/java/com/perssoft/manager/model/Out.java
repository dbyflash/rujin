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

public class Out extends Model<Out> {
	public static final Out dao = new Out();
  
	public PageData<Out> pageList(Map<String, String> map) {
		String sql = " from outroom where 1=1 ";
		if (StringUtils.isNotBlank(map.get("productid"))) {
			sql += " and productid = " + map.get("productid") + "";
		}
		if (StringUtils.isNotBlank(map.get("s_number"))) {
			sql += " and number like '%" + map.get("s_number") + "%'";
		}
		if (StringUtils.isNotBlank(map.get("s_snumber"))) {
			sql += " and snumber like '%" + map.get("s_snumber") + "%'";
		}
		if (StringUtils.isNotBlank(map.get("s_begin"))) {
			sql += " and dt >= '"+map.get("s_begin")+"' ";
		}
		if (StringUtils.isNotBlank(map.get("s_end"))) {
			sql += " and dt <= '"+map.get("s_end")+"' ";
		}
		if (StringUtils.isNotBlank(map.get("userid"))) {
			sql += " and userid ='" + map.get("userid") + "'";
		}
		return paginate(map, "select *", sql);

	}
	public Out getByNumber(String number){
		String sql="select * from outroom where number='"+number+"' ";
		return this.findFirst(sql);
	}
	public Out getByNumberId(Map<String, String> map,String number){
		String sql="select * from outroom where number='"+number+"' ";
		if(!CommonUtility.isBlank(map.get("id"))){
			sql+=" and  id != '"+QueryParser.escapeSql(map.get("id"))+"'";
		}
		return this.findFirst(sql);
	}

}
