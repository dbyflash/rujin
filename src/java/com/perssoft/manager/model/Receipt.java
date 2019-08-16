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

public class Receipt extends Model<Receipt> {
	public static final Receipt dao = new Receipt();
  
	public PageData<Receipt> pageList(Map<String, String> map) {
		String sql = " from receipt where 1=1 ";
		if (StringUtils.isNotBlank(map.get("materialid"))) {
			sql += " and materialid = " + map.get("materialid") + "";
		}
		if (StringUtils.isNotBlank(map.get("s_number"))) {
			sql += " and number like '%" + map.get("s_number") + "%'";
		}
		if (StringUtils.isNotBlank(map.get("providerid"))) {
			sql += " and providerid = " + map.get("providerid") + "";
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
	public Receipt getByNumber(String number){
		String sql="select * from receipt where number='"+number+"' ";
		return this.findFirst(sql);
	}
	public Receipt getByNumberId(Map<String, String> map,String number){
		String sql="select * from receipt where number='"+number+"' ";
		if(!CommonUtility.isBlank(map.get("id"))){
			sql+=" and  id != '"+QueryParser.escapeSql(map.get("id"))+"'";
		}
		return this.findFirst(sql);
	}

}
