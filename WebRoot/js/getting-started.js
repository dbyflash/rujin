// 文件上传
jQuery(function() {

    var $ = jQuery,
        $list = $('#thelist'),//文件列表  
        $btn = $('#ctlBtn'),//开始上传按钮 
        state = 'pending',//初始按钮状态 
        uploader;//uploader对象  
    var fileMd5;  //文件唯一标识  
    
    /******************下面的参数是自定义的*************************/  
    var fileName;//文件名称  
    var oldJindu;//如果该文件之前上传过 已经上传的进度是多少  
    var count=0;//当前正在上传的文件在数组中的下标，一次上传多个文件时使用  
    var filesArr=new Array();//文件数组：每当有文件被添加进队列的时候 就push到数组中  
    var map={};//key存储文件id，value存储该文件上传过的进度 
    
     /***************************************************** 监听分块上传过程中的三个时间点 start ***********************************************************/  
    WebUploader.Uploader.register({    
        "before-send-file":"beforeSendFile",//整个文件上传前  
        "before-send":"beforeSend",  //每个分片上传前  
        "after-send-file":"afterSendFile",  //分片上传完毕  
    },  
    {    
        //时间点1：所有分块进行上传之前调用此函数    
        beforeSendFile:function(file){  
            var deferred = WebUploader.Deferred();    
            //1、计算文件的唯一标记fileMd5，用于断点续传  如果.md5File(file)方法里只写一个file参数则计算MD5值会很慢 所以加了后面的参数：10*1024*1024  
            (new WebUploader.Uploader()).md5File(file,0,10*1024*1024).progress(function(percentage){  
                $('#'+file.id ).find('p.state').text('正在读取文件信息...');  
            })    
            .then(function(val){    
                $('#'+file.id ).find("p.state").text("成功获取文件信息...");    
                fileMd5=val;    
                //获取文件信息后进入下一步    
                deferred.resolve();  // 改变deferred对象的执行状态  
            });    
              
            fileName=file.name; //为自定义参数文件名赋值  
            return deferred.promise();    
        },    
        //时间点2：如果有分块上传，则每个分块上传之前调用此函数    
        beforeSend:function(block){  
            var deferred = WebUploader.Deferred();    
            $.ajax({    
                type:"POST",    
                url:context+"/manager/upload/mergeOrCheckChunks.do?param=checkChunk",  //ajax验证每一个分片  
                data:{    
                    fileName : fileName,  
                    jindutiao:$("#jindutiao").val(),
                    fileMd5:fileMd5,  //文件唯一标记    
                    chunk:block.chunk,  //当前分块下标    
                    chunkSize:block.end-block.start//当前分块大小    
                },    
                cache: false,  
                async: false,  // 与js同步  
                timeout: 1000, //todo 超时的话，只能认为该分片未上传过  
                dataType:"json",    
                success:function(response){    
                    if(response.ifExist){  
                        //分块存在，跳过    
                        deferred.reject();    
                    }else{    
                        //分块不存在或不完整，重新发送该分块内容    
                        deferred.resolve();    
                    }    
                }    
            });    
                               
            this.owner.options.formData.fileMd5 = fileMd5;    
            deferred.resolve();    
            return deferred.promise();    
        },    
        //时间点3：所有分块上传成功后调用此函数    
        afterSendFile:function(){  
            //如果分块上传成功，则通知后台合并分块    
            $.ajax({    
                type:"POST",    
                url:context+"/manager/upload/mergeOrCheckChunks.do?param=mergeChunks",  //ajax将所有片段合并成整体  
                data:{    
                    fileName : fileName,  
                    fileMd5:fileMd5,  
                },    
                success:function(data){  
                    count++; //每上传完成一个文件 count+1  
                    if(count<=filesArr.length-1){  
                        uploader.upload(filesArr[count].id);//上传文件列表中的下一个文件  
                    }  
                     //合并成功之后的操作  
                }    
            });    
        }    
    });  
    /***************************************************** 监听分块上传过程中的三个时间点 end **************************************************************/  



    //初始化WebUploader
    uploader = WebUploader.create({
        auto:false,//选择文件后是否自动上传 
        chunked: true,//开启分片上传  
        chunkSize:10*1024*1024,// 如果要分片，分多大一片？默认大小为5M  
        chunkRetry: 3,//如果某个分片由于网络问题出错，允许自动重传多少次  
        threads: 3,//上传并发数。允许同时最大上传进程数[默认值：3]  
        duplicate : false,//是否重复上传（同时选择多个一样的文件），true可以重复上传  
        prepareNextFile: true,//上传当前分片时预处理下一分片  
        fileSizeLimit:6*1024*1024*1024,//6G 验证文件总大小是否超出限制, 超出则不允许加入队列  
        fileSingleSizeLimit:3*1024*1024*1024,  //3G 验证单个文件大小是否超出限制, 超出则不允许加入队列
        // 不压缩image
        resize: false,
        // swf文件路径
        swf: context+'/js/Uploader.swf',
        // 文件接收服务端。
        server: context+'/manager/upload/fileSave.do',
        // 选择文件的按钮。可选。
        // 内部根据当前运行是创建，可能是input元素，也可能是flash.
        pick: '#picker'
    });

     //当有文件被添加进队列的时候（点击上传文件按钮，弹出文件选择框，选择完文件点击确定后触发的事件）    
    uploader.on('fileQueued', function(file) {
        //限制单个文件的大小 超出了提示
        if(file.size>3*1024*1024*1024){
            alert("单个文件大小不能超过3G");
            return false;
        }
          
        /*************如果一次只能选择一个文件，再次选择替换前一个，就增加如下代码*******************************/  
        //清空文件队列  
        //$list.html("");  
        //清空文件数组  
        //filesArr=[];  
        /*************如果一次只能选择一个文件，再次选择替换前一个，就增加以上代码*******************************/  
          
        //将选择的文件添加进文件数组  
        filesArr.push(file);  
  
        $.ajax({
            type:"POST",    
            url:context+"/manager/upload/selectProgressByFileName.do",  //先检查该文件是否上传过，如果上传过，上传进度是多少  
            data:{    
                fileName : file.name  //文件名  
            },    
            cache: false,  
            async: false,  // 同步  
            dataType:"json",    
            success:function(data){
                //上传过  
                if(data>0){
                    //上传过的进度的百分比  
                            oldJindu=data/100;  
                    //如果上传过 上传了多少  
                    var jindutiaoStyle="width:"+data+"%";  
                    $list.append( '<div id="' + file.id + '" class="item">' +  
                        '<h4 class="info">' + file.name + '</h4>' +  
                        '<p class="state">已上传'+data+'%</p>' +  
                        '<a href="javascript:void(0);" class="btn btn-primary file_btn btnRemoveFile">删除</a>' +  
                            '<div class="progress progress-striped active">' +  
                      '<div class="progress-bar" role="progressbar" style="'+jindutiaoStyle+'">' +  
                      '</div>' +
                    '</div>'+
                    '</div>' );  
                    //将上传过的进度存入map集合  
                    map[file.id]=oldJindu;  
                }else{//没有上传过  
                    $list.append( '<div id="' + file.id + '" class="item">' +  
                        '<h4 class="info">' + file.name + '</h4>' +  
                        '<p class="state">等待上传...</p>' +  
                        '<a href="javascript:void(0);" class="btn btn-primary file_btn btnRemoveFile">删除</a>' +  
                    '</div>' );  
                }    
            }    
        });  
        uploader.stop(true);
        //删除队列中的文件
        $(".btnRemoveFile").bind("click", function() {
            var fileItem = $(this).parent();
            uploader.removeFile($(fileItem).attr("id"), true);  
            $(fileItem).fadeOut(function() {  
                $(fileItem).remove();  
            });  
          
            //数组中的文件也要删除  
            for(var i=0;i<filesArr.length;i++){  
                if(filesArr[i].id==$(fileItem).attr("id")){  
                    filesArr.splice(i,1);//i是要删除的元素在数组中的下标，1代表从下标位置开始连续删除一个元素  
                }  
            }  
        });  
    });

    // 文件上传过程中创建进度条实时显示。
    uploader.on( 'uploadProgress', function( file, percentage ) {
        var $li = $( '#'+file.id ),
            $percent = $li.find('.progress .progress-bar');

        // 避免重复创建
        if ( !$percent.length ) {
            $percent = $('<div class="progress progress-striped active">' +
              '<div class="progress-bar" role="progressbar" style="width: 0%">' +
              '</div>' +
            '</div>').appendTo( $li ).find('.progress-bar');
        }

         //将实时进度存入隐藏域  
        $("#jindutiao").val(Math.round(percentage * 100));  
          
        //根据fielId获得当前要上传的文件的进度  
        var oldJinduValue = map[file.id];  
          
        if(percentage<oldJinduValue && oldJinduValue!=1){  
            $li.find('p.state').text('上传中'+Math.round(oldJinduValue * 100) + '%');  
            $percent.css('width', oldJinduValue * 100 + '%');  
        }else{  
            $li.find('p.state').text('上传中'+Math.round(percentage * 100) + '%');  
            $percent.css('width', percentage * 100 + '%');  
        }  
    });
    
    //判断响应是否有效
    uploader.on( 'uploadAccept', function( object, ret ) {
          var data =JSON.parse(ret._raw);
          if(data.statusCode!=200){
            alert("服务器返回失败");
            return false;
          }
    });
    

    uploader.on( 'uploadSuccess', function( file ) {
        //上传成功去掉进度条  
        $('#'+file.id).find('.progress').fadeOut();  
        //隐藏删除按钮  
        $(".btnRemoveFile").hide();  
        //隐藏上传按钮  
        $("#startOrStopBtn").hide();  
        $('#'+file.id).find('p.state').text('文件已上传成功');    
    });

    uploader.on( 'uploadError', function( file ) {
        $( '#'+file.id ).find('p.state').text('上传出错');
    });

    uploader.on( 'uploadComplete', function( file ) {
        $( '#'+file.id ).find('.progress').fadeOut();
    });

    uploader.on( 'all', function( type ) {
        if ( type === 'startUpload' ) {
            state = 'uploading';
        } else if ( type === 'stopUpload' ) {
            state = 'paused';
        } else if ( type === 'uploadFinished' ) {
            state = 'done';
        }

        if ( state === 'uploading' ) {
            $btn.text('暂停上传');
        } else {
            $btn.text('开始上传');
        }
    });

    $btn.on( 'click', function() {
        if ( state === 'uploading' ) {
            uploader.stop(true);
        } else {
            //当前上传文件的文件名  
            var currentFileName;  
            //当前上传文件的文件id  
            var currentFileId;  
            //count=0 说明没开始传 默认从文件列表的第一个开始传  
            if(count==0){  
                currentFileName=filesArr[0].name;  
                currentFileId=filesArr[0].id;  
            }else{
                if(count<=filesArr.length-1){  
                    currentFileName=filesArr[count].name;  
                    currentFileId=filesArr[count].id;  
                }  
            }  
              
            //先查询该文件是否上传过 如果上传过已经上传的进度是多少  
            $.ajax({    
                type:"POST",    
                url:context+"/manager/upload/selectProgressByFileName.do",    
                data:{    
                    fileName : currentFileName//文件名  
                },    
                cache: false,  
                async: false,  // 同步  
                dataType:"json",    
                success:function(data){    
                    //如果上传过 将进度存入map  
                    if(data>0){  
                        map[currentFileId]=data/100;  
                    }  
                    //执行上传  
                    uploader.upload(currentFileId);  
                }    
            });
        }
    });
});


