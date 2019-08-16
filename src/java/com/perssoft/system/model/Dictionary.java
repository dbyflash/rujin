package com.perssoft.system.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.perssoft.common.bean.TreeInfo;
import com.perssoft.plugin.activerecord.Model;

@SuppressWarnings("serial")
public class Dictionary extends Model<Dictionary> {
	public static final Dictionary dao = new Dictionary();

	public List<TreeInfo> pageList(Map<String, String> map) {
	
		String sql="";
		String node=(String)map.get("node");
		int flag=0;
		if (StringUtils.isNotBlank(node) && !"null".equals(node)) {
			flag=1;
			 sql="select * from xt_dictionary where parentid="+node+" and isdelete=0 order by id asc";
		}else{
			 sql="select * from xt_dictionary where parentid is null and isdelete=0 order by id asc";
		}
		List treeList = new ArrayList();  
		List<Dictionary> list=this.find(sql);
        for (Dictionary bean : list) {
        	 Map<String,Object> tree = new HashMap<String,Object>();
    	     tree.put("id", bean.getInt("id"));
    	     tree.put("name", bean.get("name"));
    	     tree.put("descn", bean.get("descn"));
    	     tree.put("_parentId", bean.get("parentid"));
    	     if(flag==1){
    	    	 tree.put("state", "open");
    	     }else{
    	    	 tree.put("state", "closed");
    	     }
    		 treeList.add(tree);
		}    
		return treeList;
	}
	 
    
	 
	

}
