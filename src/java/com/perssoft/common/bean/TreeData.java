package com.perssoft.common.bean;

import java.util.List;
import java.util.Map;

public class TreeData {
	public static final String TREE_DATA_STATE_OPEN = "open";
	public static final String TREE_DATA_STATE_CLOSE = "close";
	
	private Integer id;
	
	private String text;
	
	private String state=TREE_DATA_STATE_CLOSE;
	
	private boolean checked;
	
	private Map<String, Object> attributes;
	
	private List<TreeData> children;
	
	private String iconCls;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public boolean isChecked() {
		return checked;
	}

	public void setChecked(boolean checked) {
		this.checked = checked;
	}

	public Map<String, Object> getAttributes() {
		return attributes;
	}

	public void setAttributes(Map<String, Object> attributes) {
		this.attributes = attributes;
	}

	public List<TreeData> getChildren() {
		return children;
	}

	public void setChildren(List<TreeData> children) {
		this.children = children;
	}

	public String getIconCls() {
		return iconCls;
	}

	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}
	
	
}
