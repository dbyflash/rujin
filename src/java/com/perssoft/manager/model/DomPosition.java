package com.perssoft.manager.model;

import java.util.List;

import com.perssoft.plugin.activerecord.Model;

public class DomPosition extends Model<DomPosition>{
	public static final DomPosition dao=new DomPosition();
	
	public List<DomPosition> getByAdminid(String adminid){
		String sql="select * from domposition where adminid="+adminid;
		return this.find(sql);
	}
	
	public DomPosition getByAdminidDomid(String adminid,String domid){
       String sql="select * from domposition where adminid="+adminid+" and domid='"+domid+"'";
       return this.findFirst(sql);
    }
}