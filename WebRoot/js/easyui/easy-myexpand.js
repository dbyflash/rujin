$.extend($.fn.validatebox.defaults.rules, {  
    minLength: {  
        validator: function(value, param){  
            return value.length >= param[0];  
        },  
        message: '输入长度不得小于 {0}'  
    },
    maxLength:{
        validator: function(value, param){  
            return value.length <= param[0];  
        },  
        message: '输入长度不得大于 {0}'      
    },
    validCombo:{
    	validator:function(value,param){
    		var val = $("#"+param[0]).combo("getValue");
    		var text = $("#"+param[0]).combo("getText");
    		return val!=text;
    	},
    	message:'不是有效的下拉列表值，请重新选择'
    }
     
}); 

// msg
function rightBottom(message) {
	$.messager.show({
				title : '提示信息',
				msg : message,
				showType : 'show'
			});
}
 
function showErrorMsg(msg) {
   
	$.messager.show({
				title : '错误提示',
				msg : msg,
				showType : 'fade',
				timeout:1000
			});
  }
  
function showCenterMsg(title,msg) {
	$.messager.show( {
		title : title,
		msg : msg,
		showType : 'fade',
		timeout:1000,
		style:{
                right:'',
                bottom:''
         }
	 });
   }
 
function getPageArea() {
	if (document.compatMode == 'BackCompat') {
		return {
			width : Math.max(document.body.scrollWidth,
					document.body.clientWidth),
			height : Math.max(document.body.scrollHeight,
					document.body.clientHeight)
		}
	} else {
		return {
			width : Math.max(document.documentElement.scrollWidth,
					document.documentElement.clientWidth),
			height : Math.max(document.documentElement.scrollHeight,
					document.documentElement.clientHeight)
		}
	}
}

$.extend($.fn.datagrid.defaults.editors, {
    combogrid: {
        init: function (container, options) {
            var input = $('<input type="text" class="datagrid-editable-input">').appendTo(container);
            input.combogrid(options);
            return input;
        },
        destroy: function (target) {
            $(target).combogrid('destroy');
        },
        getValue: function (target) {
            return $(target).combogrid('getValue');
        },
        setValue: function (target, value) {
            $(target).combogrid('setValue', value);
        },
        resize: function (target, width) {
            $(target).combogrid('resize', width);
        }
    }
});

$.extend($.fn.datagrid.defaults.view, {
	renderRow: function(target, fields, frozen, rowIndex, rowData) {
		var opts = $.data(target, 'datagrid').options;

		var cc = [];
		if (frozen && opts.rownumbers) {
			var rownumber = rowIndex + 1;
			if (opts.pagination) {
				rownumber += (opts.pageNumber - 1) * opts.pageSize;
			}
			cc.push('<td class="datagrid-td-rownumber"><div class="datagrid-cell-rownumber">' + rownumber + '</div></td>');
		}
		for (var i = 0; i < fields.length; i++) {
			var field = fields[i];
			var col = $(target).datagrid('getColumnOption', field);
			if (col) {
				//start 处理多级数据
                var fieldSp = field.split(".");
                var dta = rowData[fieldSp[0]];
             
                for (var j = 1; j < fieldSp.length; j++) {
                        if(dta){
                         dta = dta[fieldSp[j]];
                        }else {
                          dta="";
                        }
                       
                }
                //end 处理多级数据
				// get the cell style attribute
				var styleValue = col.styler ? (col.styler(dta, rowData, rowIndex) || '') : '';
				var style = col.hidden ? 'style="display:none;' + styleValue + '"' : (styleValue ? 'style="' + styleValue + '"' : '');

				cc.push('<td field="' + field + '" ' + style + '>');

				if (col.checkbox) {
					var style = '';
				} else {
					var style = '';
					//var style = 'width:' + (col.boxWidth) + 'px;';
					style += 'text-align:' + (col.align || 'left') + ';';
					if (!opts.nowrap) {
						style += 'white-space:normal;height:auto;';
					} else if (opts.autoRowHeight) {
						style += 'height:auto;';
					}
				}

				cc.push('<div style="' + style + '" ');
				if (col.checkbox) {
					cc.push('class="datagrid-cell-check ');
				} else {
					cc.push('class="datagrid-cell ' + col.cellClass);
				}
				cc.push('">');

				if (col.checkbox) {
					cc.push('<input type="checkbox" name="' + field + '" value="' + (dta != undefined ? dta : '') + '"/>');
				} else if (col.formatter) {
					cc.push(col.formatter(dta, rowData, rowIndex));
				} else {
					cc.push(dta);
				}

				cc.push('</div>');
				cc.push('</td>');
			}
		}
		return cc.join('');
	}
});



