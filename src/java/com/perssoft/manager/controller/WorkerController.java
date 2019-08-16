package com.perssoft.manager.controller;

import java.sql.SQLException;

import com.perssoft.aop.Before;
import com.perssoft.framework.PerssoftController;
import com.perssoft.manager.model.Worker;
import com.perssoft.plugin.activerecord.Db;
import com.perssoft.plugin.activerecord.DbKit;
import com.perssoft.plugin.activerecord.PageData;
import com.perssoft.plugin.activerecord.tx.Tx;

public class WorkerController extends PerssoftController<Worker> {

	
	@Override
	public void index() {
		render("/WEB-INF/jsp/manager/worker/workerList.jsp");
	}
	
	@Override
	public void create() {
		super.create();
		render("/WEB-INF/jsp/manager/worker/workerForm.jsp");
	}
	
	@Override
	public void edit() {
		super.edit();
		render("/WEB-INF/jsp/manager/worker/workerForm.jsp");
	}
	
	
	@Override
	public void list() {
		PageData<Worker> list=Worker.dao.pageList(getParaMap());
		renderJson(list);
	}
	
	@Override
	protected boolean doAfterSave(Worker object) {
		System.out.println("id2="+object.getInt("id"));
		return super.doAfterSave(object);
	}
	
	
	
	
	public void test() {
		 
		Worker worker=enhance(Worker.class);
		
		worker.test3();
		
		
		 
	}
	
	@Before(Tx.class)
	public void test1(){
		
		try {
			Worker.dao.test();
			Worker.dao.test1();
			
			 
			
			
		} catch (Exception e) {
			try {
				DbKit.getConfig().getThreadLocalConnection().rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
		
	
		
		
	}
	
	
	
	
}
