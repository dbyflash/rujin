<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<script type="text/javascript">
$(function(){
	

});
 
</script>


	<table class="table">
		<tr>
			<td align="right">销售合同金额合计：</td>
			<td>
				<input name="money" id="money" size="25" class="easyui-validatebox" value="${bean.money}" />
			</td>
		</tr>
		<tr>
		 <td align="right">销售发票金额合计：</td>
			<td>
				<input name="money1" id="money1" size="25" class="easyui-validatebox" value="${bean.money2}"  />
			</td>
		</tr>
		<tr>
		 <td align="right">成本费用金额合计：</td>
			<td>
				<input name="money5" id="money5" size="25" class="easyui-validatebox" value="${bean.money5}"  />
			</td>
		</tr>
		<tr>
		 <td align="right">货款回收金额合计：</td>
			<td>
				<input name="money2" id="money2" size="25" class="easyui-validatebox" value="${bean.money3}"  />
			</td>
			
		</tr>
		<tr>
		 <td align="right">货款回收完成情况：</td>
			<td>
				<input name="state" id="state" size="25" class="easyui-validatebox" value="${bean.money4}"  />
			</td>
			
		</tr>
		
	</table>


