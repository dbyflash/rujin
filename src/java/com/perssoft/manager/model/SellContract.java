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

public class SellContract extends Model<SellContract> {
	public static final SellContract dao = new SellContract();
  
	public PageData<SellContract> pageList(Map<String, String> map) {
		String sql = " from sellcontract where 1=1 ";
		if (StringUtils.isNotBlank(map.get("productid"))) {
			sql += " and productid = " + map.get("productid") + "";
		}
		if (StringUtils.isNotBlank(map.get("s_number"))) {
			sql += " and number like '%" + map.get("s_number") + "%'";
		}
		if (StringUtils.isNotBlank(map.get("s_begin"))) {
			sql += " and signdate >= '"+map.get("s_begin")+"' ";
		}
		if (StringUtils.isNotBlank(map.get("s_end"))) {
			sql += " and signdate <= '"+map.get("s_end")+"' ";
		}
		if (StringUtils.isNotBlank(map.get("userid"))) {
			sql += " and userid ='" + map.get("userid") + "'";
		}
		return paginate(map, "select *", sql);

	}
	public SellContract getByNumber(String number){
		String sql="select * from sellcontract where number='"+number+"' ";
		return this.findFirst(sql);
	}
	public SellContract getByNumberId(Map<String, String> map,String number){
		String sql="select * from sellcontract where number='"+number+"' ";
		if(!CommonUtility.isBlank(map.get("id"))){
			sql+=" and  id != '"+QueryParser.escapeSql(map.get("id"))+"'";
		}
		return this.findFirst(sql);
	}
	public SellContract payView(String number){
		String sql="select s1.money,s2.money2,s3.money3,(s3.money3-s1.money) as money4,s5.money5 from sellcontract s1 " +
				"left join (select cnumber,sum(money) as money2 from sellinvoice where cnumber='"+number+"') s2 on s2.cnumber=s1.number " +
				"left join (select cnumber,sum(money) as money3 from sellpay where cnumber='"+number+"') s3 on s3.cnumber=s1.number " +
				"left join (select cnumber,sum(money) as money5 from costs where cnumber='"+number+"') s5 on s5.cnumber=s1.number " +
				"where s1.number='"+number+"' group by s1.money,money4";
		return this.findFirst(sql);
	}
	
}
