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

public class BuyPayApply extends Model<BuyPayApply> {
	public static final BuyPayApply dao = new BuyPayApply();
  
	public PageData<BuyPayApply> pageList(Map<String, String> map) {
		String sql = " from buypayapply where 1=1 ";
		if (StringUtils.isNotBlank(map.get("s_applyman"))) {
			sql += " and applyman like '%" + map.get("s_applyman") + "%'";
		}
		if (StringUtils.isNotBlank(map.get("s_number"))) {
			sql += " and number like '%" + map.get("s_number") + "%'";
		}
		if (StringUtils.isNotBlank(map.get("s_cnumber"))) {
			sql += " and changeplacenumber like '%" + map.get("s_cnumber") + "%'";
		}
		
		return paginate(map, "select *", sql);

	}
	public BuyPayApply getByNumber(String number){
		String sql="select * from buypayapply where number='"+number+"' ";
		return this.findFirst(sql);
	}
	public BuyPayApply getByNumberId(Map<String, String> map,String number){
		String sql="select * from buypayapply where number='"+number+"' ";
		if(!CommonUtility.isBlank(map.get("id"))){
			sql+=" and  id != '"+QueryParser.escapeSql(map.get("id"))+"'";
		}
		return this.findFirst(sql);
	}

}
