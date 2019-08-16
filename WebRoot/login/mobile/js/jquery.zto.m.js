/**
 * Created by ping on 14-12-1.
 */

/*去除空格*/
String.prototype.trim = function () {
    return this.replace(/(^\s*)|(\s*$)/g, "");
};
/*基于layer的消息弹窗*/
function dialogMessage(content){
    layer.open({
        content: content,
        style: 'background:rgba(0,0,0,0.6); border:none; color:#fff',
        time: 3
    });
}
