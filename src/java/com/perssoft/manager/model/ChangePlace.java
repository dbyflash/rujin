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

public class ChangePlace extends Model<ChangePlace> {
	public static final ChangePlace dao = new ChangePlace();
  
	public PageData<ChangePlace> pageList(Map<String, String> map) {
		String sql = " from changeplace c left join buypayapply b on b.changeplacenumber=c.number where 1=1 ";
		if (StringUtils.isNotBlank(map.get("materialid"))) {
			sql += " and c.materialid = " + map.get("materialid") + "";
		}
		if (StringUtils.isNotBlank(map.get("s_number"))) {
			sql += " and c.number like '%" + map.get("s_number") + "%'";
		}
		if (StringUtils.isNotBlank(map.get("s_factory"))) {
			sql += " and c.factory like '%" + map.get("s_factory") + "%'";
		}
		if (StringUtils.isNotBlank(map.get("userid"))) {
			sql += " and c.userid ='" + map.get("userid") + "'";
		}
		sql+=" group by c.id,c.cnumber,c.deal,c.elongation,c.factory,c.materialid,c.materialname,c.number,c.real,c.userid";
		return paginate(map, "select c.id,c.cnumber,c.deal,c.elongation,c.factory,c.materialid,c.materialname,c.number,c.real,c.userid,sum(b.money) as paymoney", sql);

	}
	public ChangePlace getByNumber(String number){
		String sql="select * from changeplace where number='"+number+"' ";
		return this.findFirst(sql);
	}
	public ChangePlace getByNumberId(Map<String, String> map,String number){
		String sql="select * from changeplace where number='"+number+"' ";
		if(!CommonUtility.isBlank(map.get("id"))){
			sql+=" and  id != '"+QueryParser.escapeSql(map.get("id"))+"'";
		}
		return this.findFirst(sql);
	}

}
