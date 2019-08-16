package com.perssoft.system.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.perssoft.common.bean.TreeData;
import com.perssoft.common.bean.ZTreeInfo;
import com.perssoft.plugin.activerecord.Db;
import com.perssoft.plugin.activerecord.Model;
import com.perssoft.plugin.activerecord.Record;

/**
 * Resource model.
 */
public class Resource extends Model<Resource> {
	public static final Resource dao = new Resource();
	
	//获取登陆用户资源
	public  List<ZTreeInfo>  getUserResource(Integer adminid){
		
		String sql="select a.resourceid,r.* from " +
				" (select rr.resourceid  from xt_role_resource rr, xt_admin_role ar where  ar.adminid="+adminid+"  and ar.roleid=rr.roleid) a " +
				" left join xt_resource r on r.id=a.resourceid " +
				" order by r.ordernum asc";
		System.out.println(sql);
		List<Resource> list= this.find(sql);
		
	    //制作成ztree节点
        List<ZTreeInfo> treelist=new ArrayList<ZTreeInfo>();
 
        for (Resource re : list) {
			ZTreeInfo ztree = new ZTreeInfo();
			ztree.setId(re.getInt("id"));
			ztree.setName(re.getStr("name"));
			ztree.setTheUrl(re.getStr("resstring"));
			ztree.setOptions(re.getStr("options"));
			ztree.setOpenType(re.getStr("openType"));
  
			if (re.getInt("leaf") == 0) {
				ztree.setisParent(true);
			}
			if (re.getInt("pid") != null) {
				ztree.setpId(re.getInt("pid"));
			}else{
				ztree.setpId(null);
			}
			treelist.add(ztree);
		}
		return treelist;
	}

	public List<Record> getResourceByRole(Integer roleid) {
		String sql="select rr.resourceid as id from xt_role_resource rr where rr.roleid="+roleid;
		return Db.find(sql);
	}

	public List<ZTreeInfo> getAllSysMenu() {
		
		String sql="select * from xt_resource ";
		List<Resource> list=this.find(sql);
		
		List<ZTreeInfo> result = new ArrayList<ZTreeInfo>();
		
		for (Resource resource : list) {
			ZTreeInfo tree = new ZTreeInfo();
			tree.setId(resource.getInt("id"));
			tree.setName(resource.getStr("name"));
			Integer pid=resource.getInt("pid");
			tree.setpId(pid);
			result.add(tree);
		}
		return result;
	}
	
	//获取角色右侧选择菜单
	public List<ZTreeInfo> getRightMenuResources(Integer roleid){
		List<Record> mylist= this.getResourceByRole(roleid);
		List<ZTreeInfo>  result= this.getAllSysMenu() ;
		for (ZTreeInfo info : result) {
			for (Record info2 : mylist) {
				if(info.getId().equals(info2.getInt("id"))){
					info.setChecked(true);
					break;
				}
			}
		}
		return result;
		
	}
	
	
	//////////////////////获取菜单管理 右侧菜单树--easyui tree////////////////////////////////
	
	public List<TreeData> getAllResourceByRole(Integer roleid){
		
		String sql="select rr.resourceid,r.* from " +
		" xt_role_resource rr  " +
		" left join xt_resource r on r.id=rr.resourceid " +
		" where rr.roleid="+roleid+"   order by r.ordernum asc";
		System.out.println(sql);
		List<Resource> resourcelist= this.find(sql);
		
		List<TreeData> list=new ArrayList<TreeData>();	
		TreeData td=new TreeData();
		td.setId(0);
		td.setText("系统菜单");
		List<TreeData> list1=new ArrayList<TreeData>();
		for (Resource resource : resourcelist) {
			if(resource.get("pid")==null){
				TreeData tdd=new TreeData();
				tdd.setId(resource.getInt("id"));
				tdd.setText(resource.getStr("name"));
				Map<String,Object> map=new HashMap<String, Object>();
				map.put("url", resource.get("resstring"));
				map.put("ordernum", resource.get("ordernum"));
				tdd.setAttributes(map);
				tdd.setChildren(getChild(tdd,resourcelist));
				list1.add(tdd);
				
				
			}
		}
		td.setChildren(list1);
		list.add(td);
		return list;
	}
	
	public List<TreeData> getChild(TreeData td,List<Resource> resourcelist){
		List<TreeData> list=new ArrayList<TreeData>();
		for (Resource resource : resourcelist) {
			if(resource.get("pid")!=null){
				
				if(resource.getInt("pid").equals(td.getId())){
					TreeData tdd=new TreeData();
					tdd.setId(resource.getInt("id"));
					tdd.setText(resource.getStr("name"));
					Map<String,Object> map=new HashMap<String, Object>();
					map.put("url", resource.get("resstring"));
					map.put("ordernum", resource.get("ordernum"));
					map.put("pid", resource.getInt("pid"));
					tdd.setAttributes(map);
					tdd.setChildren(getChild(tdd,resourcelist));
					list.add(tdd);
				}
			}
		}
		return list;
	}

	public void insertRole_Resource(Integer roleid, Integer resourceid) {
		String sql="insert into xt_role_resource (roleid,resourceid) values ('"+roleid+"','"+resourceid+"' )";
		Db.update(sql);
	}
	
	//顶部菜单
	public List<Resource> findMyTopFunc(Admin user) {
		String sql="select a.resourceid,r.* from " +
		" (select rr.resourceid  from xt_role_resource rr, xt_admin_role ar where  ar.adminid="+user.getInt("id")+"  and ar.roleid=rr.roleid) a " +
		" left join xt_resource r on r.id=a.resourceid where r.pid is null " +
		" order by r.ordernum asc";
		return this.find(sql);
	}
	
	public List<Resource> getUserResource(Admin user,String p_id) {
		String sql="select a.resourceid,r.* from " +
		" (select rr.resourceid  from xt_role_resource rr, xt_admin_role ar where  ar.adminid="+user.getInt("id")+"  and ar.roleid=rr.roleid) a " +
		" left join xt_resource r on r.id=a.resourceid where r.pid = "+p_id +
		" order by r.ordernum asc";
		return this.find(sql);
	
	}
	
	

}
