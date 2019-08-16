package com.perssoft.manager.model;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.perssoft.aop.Before;
import com.perssoft.plugin.activerecord.Db;
import com.perssoft.plugin.activerecord.Model;
import com.perssoft.plugin.activerecord.PageData;
import com.perssoft.plugin.activerecord.tx.Tx;

public class Customer extends Model<Customer> {
	public static final Customer dao = new Customer();
  
	public PageData<Customer> pageList(Map<String, String> map) {
		String sql = " from customer where 1=1 ";
		if (StringUtils.isNotBlank(map.get("s_name"))) {
			sql += " and name like '%" + map.get("s_name") + "%'";
		}
		return paginate(map, "select *", sql);

	}
	public List<Customer> getlist(){
		String sql = "select id,name from customer where 1=1 ";
		return this.find(sql);
	}


}
