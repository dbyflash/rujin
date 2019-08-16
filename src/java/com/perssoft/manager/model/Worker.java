package com.perssoft.manager.model;

import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.perssoft.aop.Before;
import com.perssoft.plugin.activerecord.Db;
import com.perssoft.plugin.activerecord.Model;
import com.perssoft.plugin.activerecord.PageData;
import com.perssoft.plugin.activerecord.tx.Tx;

public class Worker extends Model<Worker> {
	public static final Worker dao = new Worker();
  
	public PageData<Worker> pageList(Map<String, String> map) {
		String sql = " from yw_worker where 1=1 ";
		if (StringUtils.isNotBlank(map.get("s_name"))) {
			sql += " and name like '%" + map.get("s_name") + "%'";
		}
		return paginate(map, "select *", sql);

	}
	
	
	public void test() {
		
		String sql="update xt_admin set name='管理员A' where id=1 ";
		Db.update(sql);
		
		String sql1="INSERT INTO yw_worker(name,age,sex) VALUES ('张三2', '20', '1');";
		Db.update(sql1);
		
	}


	public void test1() {
		Worker worker=new Worker();
		worker.set("name", "张四");
		worker.set("age", 10);
		worker.set("sex", 2);
		worker.save();
		String sql2="INSERT INTO yw_worker VALUES ( '张三3', '20', '1');";
		Db.update(sql2);
	}

	@Before(Tx.class)
	public void test3() {

		String sql="update xt_admin set name='管理员A' where id=1 ";
		Db.update(sql);
		
		String sql1="INSERT INTO yw_worker(name,age,sex) VALUES ('张三2', '20', '1');";
		Db.update(sql1);
		
		Worker worker=new Worker();
		worker.set("name", "张四");
		worker.set("age", 10);
		worker.set("sex", 2);
		worker.save();
		
		String sql2="INSERT INTO yw_worker VALUES ( '张三3', '20', '1');";
		Db.update(sql2);
	}

}
