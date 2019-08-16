package com.perssoft.common.tool;

import java.util.Vector;

import org.apache.commons.lang.StringEscapeUtils;

/**
 * 查询解析类, where子句需把固定条件写到最后如where a = ? and status = 0
 * 
 * @author shibo
 */
public class QueryParser {

	private static final String[] DB_FUNCTION = new String[] { "to_char",
			"to_date" };

	/** 符号"AND" id */
	private static final int TKN_AND = 110;

	/** 符号"OR" id */
	private static final int TKN_OR = 111;

	/** 符号"?" id */
	private static final int TKN_HOST = 120;

	/** 符号"(" id */
	private static final int TKN_BEGIN = 121;

	/** 符号")" id */
	private static final int TKN_BEGIN_END = 122;

	/** 符号")" id */
	private static final int TKN_END = 123;

	/** 关键字where */
	private static final String STR_WHERE = "WHERE";

	/** 关键字and */
	private static final String STR_AND = "AND";

	/** 关键字or */
	private static final String STR_OR = "OR";

	/** 符号( */
	private static final String STR_BEGIN = "(";

	/** 符号) */
	private static final String STR_END = ")";

	/** 符号id */
	private int m_tokenID = 0;

	/** 查询语句 */
	private String m_query = null;

	/** 大写字符串 */
	private String m_upperStr = null;

	/** where子句 */
	private String m_where = null;

	/** 变量数组 */
	private Vector m_args = null;

	/**
	 * 根据select语句得到count语句
	 * 
	 * @param selectstr select语句
	 * @return count语句
	 */
	public static String getCountHQLBySelect(String selectstr) {
		String countHQL = null;
		String countstr = "Select count(*) ";
		selectstr = selectstr.trim();
		String upperStr = selectstr.toUpperCase();
		int selectindex = upperStr.indexOf("SELECT ");
		int fromindex = upperStr.indexOf("FROM ");
		int orderindex = upperStr.indexOf(" ORDER ");
		StringBuffer sb = new StringBuffer();
		if (fromindex == 0) {
			sb.append(countstr);
		} else if (selectindex == 0) {
			sb.append("select ");
			sb.append("count(");
			sb.append(selectstr.substring(6, fromindex - 1) + ") ");
		}

		if (-1 != orderindex) {
			sb.append(selectstr.substring(fromindex, orderindex));
		} else {
			sb.append(selectstr.substring(fromindex));
		}
		countHQL = sb.toString();

		return countHQL;
	}

	public QueryParser(String s, Vector params) {
		init(s, params);
	}

	private void init(String s, Vector params) {
		m_query = s;
		m_upperStr = s.toUpperCase();
		m_args = params;
	}

	public void clear() {
		m_tokenID = 0;
		m_query = null;
		m_upperStr = null;
		m_where = null;
		m_args = null;
	}

	/**
	 * 根据完整的select语句和参数列表得到非空参数组合的查询语句
	 * 
	 * @return 非空参数组合的查询语句
	 */
	public String getQuery() {
		if (m_query.indexOf('?') == -1) {
			return m_query;
		}
		int m_whereBegin = getTokenPos(STR_WHERE, 0);
		String m_result = m_query.substring(0, m_whereBegin);
		m_where = "";
		if (m_whereBegin == -1) {
			return m_result;
		}
		int whereindex = parseWhere(m_whereBegin + STR_WHERE.length());
		if (m_where.length() > 0) {
			m_result = m_result.concat("where ");
			m_result = m_result.concat(m_where);
		}
		m_result = m_result.concat(m_query.substring(whereindex));

		Vector params = new Vector();
		for (int i = 0; i < m_args.size(); i++) {
			if (m_args.elementAt(i) != null
					&& m_args.elementAt(i).toString().length() != 0) {
				if (isDbFunction(m_args.elementAt(i).toString())) {
					params.add(m_args.elementAt(i));
				} else {
					params.add("'" + m_args.elementAt(i) + "'");
				}
			}
		}
		String resultstr = StringUtility.formatStr(m_result, params);
		return resultstr;
	}

	/**
	 * 解析where子句
	 * 
	 * @param i
	 * @return
	 */
	private int parseWhere(int i) {
		StringBuffer wheresb = new StringBuffer();
		String tokenstr = null;

		int tokenflag = -1;
		int startPos = i;
		int paramsnum = 0;

		boolean flag = true;

		int flagindex = 0;
		do {
			// 取得从startPos开始的第一个符号
			flagindex = getToken(startPos);
			if (flagindex == -1) {
				break;
			}
			flagindex++;
			if (m_tokenID == TKN_BEGIN) {
				tokenflag = TKN_BEGIN;
				startPos = flagindex;
				continue;
			}
			if (m_tokenID == TKN_AND) {
				if (flag == true) {
					tokenstr = STR_AND;
				}
				startPos = flagindex + 3;
				continue;
			}
			if (m_tokenID == TKN_OR) {
				if (flag == true) {
					tokenstr = STR_OR;
				}
				startPos = flagindex + 2;
				continue;
			}
			if (m_tokenID == TKN_END) {
				if (tokenflag == TKN_BEGIN_END) {
					wheresb.append(STR_END);
				} else {
					tokenstr = null;
				}
				flag = true;
				startPos = flagindex;
				tokenflag = -1;
				continue;
			}
			if (m_args.elementAt(paramsnum) != null
					&& m_args.elementAt(paramsnum).toString().length() != 0) {
				if (wheresb.length() == 0) {
					tokenstr = null;
					wheresb.append("");
				}
				if (tokenstr != null) {
					wheresb.append(" ");
					wheresb.append(tokenstr);
					wheresb.append(" ");
				}
				if (tokenflag == TKN_BEGIN) {
					wheresb.append(STR_BEGIN);
					tokenflag = TKN_BEGIN_END;
					flag = true;
				}
				wheresb.append(m_query.substring(startPos, flagindex));
				wheresb.append(" ");
			} else {
				if (tokenflag == TKN_BEGIN) {
					flag = false;
				}
			}
			paramsnum++;
			startPos = flagindex;
			if (paramsnum < m_args.size()) {
				continue;
			}
			flagindex = getToken(startPos);
			if (m_tokenID == TKN_END) {
				if (tokenflag == TKN_BEGIN_END) {
					wheresb.append(STR_END);
				}
				startPos = flagindex + 1;
				if (wheresb.length() == 0) {
					flagindex = getToken(startPos);
					if (m_tokenID == TKN_AND) {
						wheresb.append(" ");
						startPos = flagindex + 3;
					} else if (m_tokenID == TKN_OR) {
						wheresb.append(" ");
						startPos = flagindex + 2;
					}
				}
			} else if (m_tokenID == TKN_AND) {
				if (wheresb.length() == 0) {
					startPos = flagindex + 3;
					wheresb.append(" ");
				}
			} else if (m_tokenID == TKN_END) {
				if (wheresb.length() == 0) {
					startPos = flagindex + 2;
					wheresb.append(" ");
				}
			} else if (m_tokenID == TKN_END) {
				startPos = flagindex + 1;
			}
			break;
		} while (true);
		if (wheresb.length() != 0) {
			m_where = wheresb.toString();
		}
		return startPos;
	}

	/**
	 * 从第i个字符起取得关键字s的位置
	 * 
	 * @param s
	 * @param i
	 * @return
	 */
	private int getTokenPos(String token, int i) {
		int startpos = i;
		int tokenlen = token.length();
		startpos = m_upperStr.indexOf(token, startpos);

		while (startpos != -1) {
			if (Character.isWhitespace(m_upperStr.charAt(startpos - 1))
					&& Character.isWhitespace(m_upperStr.charAt(startpos
							+ tokenlen))) {
				return startpos;
			}
			startpos += token.length();
			startpos = m_upperStr.indexOf(token, startpos);
		}

		return -1;
	}

	/**
	 * 取得从i开始的第一个符号
	 * 
	 * @param i
	 * @return
	 */
	private int getToken(int i) {
		for (int j = i; j < m_query.length(); j++) {
			switch (m_upperStr.charAt(j)) {
			default:
				break;

			case 'A': // 'A'
				if (m_upperStr.charAt(j + 1) == 'N'
						&& m_upperStr.charAt(j + 2) == 'D'
						&& Character.isWhitespace(m_upperStr.charAt(j - 1))
						&& Character.isWhitespace(m_upperStr.charAt(j + 3))) {
					m_tokenID = TKN_AND;
					return j;
				}
				break;

			case 'O': // 'O'
				if (m_upperStr.charAt(j + 1) == 'R'
						&& Character.isWhitespace(m_upperStr.charAt(j - 1))
						&& Character.isWhitespace(m_upperStr.charAt(j + 2))) {
					m_tokenID = TKN_OR;
					return j;
				}
				break;

			case '?': // '?'
				m_tokenID = TKN_HOST;
				return j;

			case '(': // '('
				m_tokenID = TKN_BEGIN;
				return j;

			case ')': // ')'
				m_tokenID = TKN_END;
				return j;
			}
		}

		m_tokenID = -1;
		return i;
	}

	private boolean isDbFunction(String param) {
		String function = "";

		for (int i = 0; i < DB_FUNCTION.length; i++) {
			function = DB_FUNCTION[i];

			if (param.toLowerCase().startsWith(function.toLowerCase())) {
				return true;
			}
		}

		return false;
	}
	
	/**
	 * 转译,防止sql注入和报错
	 * 
	 * @param org
	 * @return
	 */
	public static String escapeSql(Object org) {
		if (org == null) {
			return "";
		}
		
		return StringEscapeUtils.escapeSql(org.toString());
	}
}