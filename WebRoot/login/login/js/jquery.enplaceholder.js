/**
 * jQuery EnPlaceholder plug
 * EnPlaceholder是一个跨浏览器实现placeholder效果的jQuery插件
 * version 1.0
 * by Frans.Lee <dmon@foxmail.com>  http://www.ifrans.cn
 */
; (function ($) {
    $.fn.extend({
        "placeholder": function (options) {
            options = $.extend({
                placeholderColor: '#ACA899',
                isUseSpan: false, //是否使用插入span标签模拟placeholder的方式,默认false,默认使用value模拟
                onInput: true  //使用标签模拟(isUseSpan为true)时，是否绑定onInput事件取代focus/blur事件
            }, options);

            $(this).each(function () {
                var _this = this;
                var supportPlaceholder = 'placeholder' in document.createElement('input');
                if (!supportPlaceholder) {
                    var defaultValue = $(_this).attr('placeholder');
                    var defaultColor = $(_this).css('color');
                    if (options.isUseSpan == false) {
                        $(_this).focus(function () {
                            var pattern = new RegExp("^" + defaultValue + "$|^$");
                            pattern.test($(_this).val()) && $(_this).val('').css('color', defaultColor);
                        }).blur(function () {
                            if ($(_this).val() == defaultValue) {
                                $(_this).css('color', defaultColor);
                            } else if ($(_this).val().length == 0) {
                                $(_this).val(defaultValue).css('color', options.placeholderColor)
                            }
                        }).trigger('blur');
                    } else {
                        var $imitate = $('<span class="wrap-placeholder" style="position:absolute; display:inline-block; overflow:hidden; color:' + options.placeholderColor + '; width:' + $(_this).outerWidth() + 'px; height:' + $(_this).outerHeight() + 'px;">' + defaultValue + '</span>');
                        $imitate.css({
                            'margin-left': $(_this).css('margin-left'),
                            'margin-top': $(_this).css('margin-top'),
                            'font-size': $(_this).css('font-size'),
                            'font-family': $(_this).css('font-family'),
                            'font-weight': $(_this).css('font-weight'),
                            'padding-left': parseInt($(_this).css('padding-left')) + 25 + 'px',
                            'line-height': _this.nodeName.toLowerCase() == 'textarea' ? $(_this).css('line-weight') : $(_this).outerHeight() + 'px',
                            'padding-top': _this.nodeName.toLowerCase() == 'textarea' ? parseInt($(_this).css('padding-top')) + 2 : 0
                        });
                        $(_this).before($imitate.click(function () {
                            $(_this).trigger('focus');
                        }));

                        $(_this).val().length != 0 && $imitate.hide();

                        if (options.onInput) {
                            //绑定oninput/onpropertychange事件
                            var inputChangeEvent = typeof (_this.oninput) == 'object' ? 'input' : 'propertychange';
                            $(_this).bind(inputChangeEvent, function () {
                                $imitate[0].style.display = $(_this).val().length != 0 ? 'none' : 'inline-block';
                            });
                        } else {
                            $(_this).focus(function () {
                                $imitate.hide();
                            }).blur(function () {
                                /^$/.test($(_this).val()) && $imitate.show();
                            });
                        }
                    }
                }
            });
            return this;
        }
    });
})(jQuery);




window.onload = function () {
    var i = 1;
    var x = $(window).height();
    var bgHeight = $(document).height();
    if (x < 600 || x > 800) {

        $(".main").height(480);
        $(".nav").css("margin-top", "70px");
        $(".ad").css("top", "79px")
        $(".bgbox").css("height", bgHeight + "px")
    }
    else {
        var mainheight = x - 120 - 70;
        $(".main").height(mainheight);
        $(".nav").css("margin-top", (mainheight - 350) / 2 + "px");
        $(".ad").css("top", (mainheight - 362) / 2 + "px");
        $(".bgbox").css("height", bgHeight + "px")

    }

};


$(".nav li").click(function() {
    var index = $(this).index();

    if (index == 0) {
        $("#logintype").attr("value", "user");
    } else {
        $("#logintype").attr("value", "site");
    }

    $(this).parent().find("i").remove();
    $(this).prepend("<i class=\"jiao\"></i>");
    $(this).parent().find("li").removeClass("curr");
    $(this).addClass("curr");
    var customlist = $(".guest li");
    customlist.hide();
    customlist.eq(index).show();
    if (index == "0") {
        $(".jiao").css("left", "25%");
    } else {
        $(".jiao").css("left", "75%");
    }
    /*$(".main,.login").height($(document).height()-240+"px");*/
});
var i = 1;
//$(".next1").click(function () {
//    $(".bgbox").css("display", "block");
//    $(".show").css("display", "block");
//    $(".contented").css("display", "block");
//});
//$("#ForgetSiteName").bind("blur 

$("#ForgetSiteName,#ForgetUserName,#Email,#Phone").bind('keyup focus blur', function (obj) {
    var id = $(this); 
    if (id.val() == "") {
        id.css("border", "1px solid red");
        //  alert("请输站点名称！");
        return false;
    } else {
        id.css("border", "1px solid #3f7acf");
    }
});

$(".next2").click(function () {
    var ForgetSiteName = $("#ForgetSiteName");
    var ForgetUserName = $("#ForgetUserName");
    if (ForgetSiteName.val() == "") {
        ForgetSiteName.css("border", "1px solid red"); 
        return false;
    } else {
        ForgetSiteName.css("border", "1px solid #3f7acf");
    }
    if (ForgetUserName.val() == "") {
        ForgetUserName.css("border", "1px solid red");
        return false;
    } else {
        ForgetUserName.css("border", "1px solid #3f7acf");
    }
    $(".contented").css("display", "none");
    $(".findway").css("display", "block");
});

$(".next3").click(function () {
    var Email = $("#Email");
    var Phone = $("#Phone");
    if (i == 1) {        
        if (Email.val() == "") {
            Phone.css("border", "1px solid #3f7acf");
            Email.css("border", "1px solid red");
            return false;
        } else {
            Email.css("border", "1px solid #3f7acf");
        }
        //$(".mailway").css("display", "block");
        //$(".phoneway").css("display", "none");
    }
    else if (i == 0) {
        if (Phone.val() == "") {
            Email.css("border", "1px solid #3f7acf");
            Phone.css("border", "1px solid red"); 
            return false;
        } else {
            Phone.css("border", "1px solid #3f7acf");
        }
        //$(".phoneway").css("display", "block");
        //$(".mailway").css("display", "none");
    }
    //else {
        //$(".errorway").css("display", "block");
        //$(".phoneway").css("display", "none");
    //}
    //$(".findway").css("display", "none");
    ForgetPassword();
   
});
$(".last3").click(function () {
    $(".findway").css("display", "none");
    $(".contented").css("display", "block");
});
$(".last4").click(function () {
    $(".errorway").css("display", "none");
    $(".findway").css("display", "block");
});

$(".tu1").click(function () {
    var Phone = $("#Phone");
    Phone.css("border", "1px solid #3f7acf");
    $(".bymail").css("background", "url(/libs/Login/images/5.png) left 3px no-repeat");
    $(".byphone").css("background", "url(/libs/Login/images/6.png) left 3px no-repeat");
    $(".inputed4").attr("value", "");
    i = 1;
});
$(".tu2").click(function () {
    var Email = $("#Email");
    Email.css("border", "1px solid #3f7acf");
    $(".bymail").css("background", "url(/libs/Login/images/6.png) left 3px no-repeat");
    $(".byphone").css("background", "url(/libs/Login/images/5.png) left 3px no-repeat");
    $(".inputed3").attr("value", "");
    i = 0;
});

$(".over").click(function () {
    $(".inputed1,.inputed2,.inputed3,.inputed4,#authVerificationCode").attr("value", "");
    $(".bg").hide();
    $(".findway,.phoneway,.findway,.contented,.show,.bgbox,.errorway").hide();
});












function show() {
    var iWidth = document.documentElement.clientWidth;
    var iHeight = document.documentElement.clientHeight;
    var bgObj = document.createElement("div");
    bgObj.setAttribute("class", "bgbox");
    bgObj.style.width = iWidth + "px";
    bgObj.style.height = Math.max(document.body.clientHeight, iHeight) + "px";
    document.body.appendChild(bgObj);
    var oShow = document.getElementById('show');
    oShow.style.display = 'block';
    oShow.style.left = (iWidth - 562) / 2 + "px";
    oShow.style.top = (iHeight - 327) / 2 + "px";
    function oClose() {
        oShow.style.display = 'none';
        document.body.removeChild(bgObj);
    }
    var oClosebtn = document.createElement("span");
    oClosebtn.innerHTML = "×";
    oShow.appendChild(oClosebtn);
    oClosebtn.onclick = oClose;
    bgObj.onclick = oClose;
}
