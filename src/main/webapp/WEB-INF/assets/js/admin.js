(function($) {
    
    // tab panel
    weui.tab('#tab', {
	defaultIndex : 0,
	onChange : function(index) {
	    console.log(index);
	    if(index == 0) {	//商品管理页面
		
	    }
	    else if(index == 1) { //订单管理页面
		$.get("/wine/order/list_admin", function(data){
		    console.log(data);
		    $('.order-list .weui-cells_access').empty();
		    $.each(data.orders, function(i, e) {
			var content = '<a class="weui-cell order-item" data-id="'+e.id+'" href="#pay">'+
				      '  <div class="weui-cell__hd"></div>'+
				      '  <div class="weui-cell__bd weui-cell_primary">'+
				      '订单号：'+e.id+e.payAmount+'元'+
				      '  </div>'+
				      '</a>';
//				      '    <div class="weui-uploader">'+
//				      '      <div class="weui-uploader__hd weui-cell"></div>'+
//				      '      <div class="weui-uploader__bd">'+
//				      '        <ul class="weui-uploader__files">'
			$('.order-list .weui-cells_access').append(content);
				      
		    });
		});
	    }
	    else if(index == 2) { //积分管理页面
		
	    }
	    else { //其他
		
	    }
	}
    });
    
    function showItemList() {
	$('#item-form').hide();
	$('#item-list').show();
	$('#item-list .weui-grids').empty();
	$.get("/wine/admin/item/all", function(data){
	    //console.log(data);
	    $.each(data.content, function(i, e) {
		var content = '<a href="javascript:;" class="weui-grid">'+
		'  <div class="weui-grid__icon">'+
		'    <img src="resources/'+e.icon+'" alt="">'+
		' </div>'+
		' <p class="weui-grid__label">'+e.name+'+</p>'+
		'</a>';
		$('#item-list .weui-grids').append(content);
	    });
	    
	});
    };
    showItemList();
    
    $('#add-item').on("click", function(event) {
	$('#item-list').hide();
	$('#item-form').show();
    });

    var catMap = {};
    
    function initialCategory(categories, data) {
	$.each(data, function(i, e) {
	    catMap[e.name] = e.id;
	    var cate = {};
	    cate.label = e.name;
	    cate.value = e.id;
	    if(e.subItems && e.subItems.length>0) {
		cate.children = [];
		initialCategory(cate.children, e.subItems);
	    }
	    categories.push(cate);
	});
    };
    
    var categories = [];
    $.get("/wine/category", function(data){
	//console.log(data);
	initialCategory(categories,data.content);
	//console.log(categories);
	//console.log(catMap);
    });

    /* form */
    // 约定正则
    var regexp = {
	regexp : {
	    IDNUM : /(?:^\d{15}$)|(?:^\d{18}$)|^\d{17}[\dXx]$/,
	    VCODE : /^.{4}$/
	}
    };

    // 失去焦点时检测
    weui.form.checkIfBlur('#item-form', regexp);
    
    // 提交表单
    $("#formSubmitBtn").on("click", function(event) {
	weui.form.validate('#item-form', function(error) {
	    console.log(error);
	    if (!error) {
		// form data
		var item = {
		    'name' : '',
		    'icon' : '',
		    'detail' : '',
		    'categoryId' : '',
		    'normalPrice' : '',
		    'vipPrice' : '',
		    'backPoints' : '',
		    'sales' : '',
		    'status' : '',
		    'titleImgs' : '',
		    'detailImgs' : ''
		};
		// get data
		item.name = $('input[name="name"]').val();
		item.detail = $('textarea[name="detail"]').val();
		var cateStr = $('input[name="categoryId"]').val();
		var lastCateIdx = cateStr.lastIndexOf('--')+2;
		item.categoryId = catMap[cateStr.substr(lastCateIdx)];
		item.normalPrice = $('input[name="normalPrice"]').val();
		item.vipPrice = $('input[name="vipPrice"]').val();
		item.sales = $('input[name="sales"]').val();
		item.status = $('input[name="state"]').val();
		if (iconUploadList.length == 0) {
		    weui.topTips('请输入商品缩略图', {
			duration : 3000,
			className : "custom-classname",
			callback : function() {
			    console.log('close');
			}
		    });
		    return;
		}
		item.icon = iconUploadList[0].content;
		if (titleUploadList.length == 0) {
		    weui.topTips('请输入商品预览图片', {
			duration : 3000,
			className : "custom-classname",
			callback : function() {
			    console.log('close');
			}
		    });
		    //$('input[id="icon"]').closest('.weui-cell').addClass('weui-cell_warn');
		    return;
		}
		$.each(titleUploadList, function(i, e) {
		    item.titleImgs += ',' + e.content;
		});
		item.titleImgs = item.titleImgs.substr(1);
		if (detailUploadList.length == 0) {
		    weui.topTips('请输入商品详情图片', {
			duration : 3000,
			className : "custom-classname",
			callback : function() {
			    console.log('close');
			}
		    });
		    return;
		}
		$.each(detailUploadList, function(i, e) {
		    item.detailImgs += ',' + e.content;
		});
		item.detailImgs = item.detailImgs.substr(1);
		console.log(item);
		var loading = weui.loading('提交中...');
		// submit
		$.ajax({
		    type: "POST",
		    url: "/wine/admin/item",
		    contentType: "application/json",
		    data: JSON.stringify(item),
		    success: function(data){
			loading.hide();
			if(data.success) {
			    weui.toast('提交成功', 3000);
			    showItemList();
			}
			else {
			    weui.toast('提交失败', 3000);
			}
		    }
		});
//		setTimeout(function() {
//		    loading.hide();
//		}, 1500);
	    }
	}, regexp);
    });
    
    // text area
    $('textarea[name="detail"]').on('input', function() {
	var max = 200;
	var text = $(this).val();
	var len = text.length;
	$('#detail_count').text(len);
	if (len > max) {
	    $(this).closest('.weui_cell').addClass('weui_cell_warn');
	} else {
	    $(this).closest('.weui_cell').removeClass('weui_cell_warn');
	}
    });

    // mutil picker
    $("#category").on('click', function(e) {
        weui.picker(categories, {
            depth: 3,
            defaultValue: [1, 5, 0],
            onChange: function (result) {
                console.log(result);
            },
            onConfirm: function (result) {
                console.log(result);
                var str = '';
                var x;
                for(x in result) {
                    str += "--" + result[x].label;
                }
                str = str.substr(2);
                $('#category').val(str);
            },
            id: 'cascadePicker'
        });
    });
    
    /* icon图片自动上传 */
    var iconUploadCount = 0, iconUploadList = [];
    var $iconCount = $("#iconCount");
    weui.uploader('#icon-uploader', {
        url: '/wine/upload',
        auto: true,
        type: 'file',
        fileVal: 'file',
        compress: {
            width: 1600,
            height: 1600,
            quality: .8
        },
        onBeforeQueued: function(files) {
            // `this` 是轮询到的文件, `files` 是所有文件
            if(["image/jpg", "image/jpeg", "image/png", "image/gif"].indexOf(this.type) < 0){
                weui.alert('请上传图片');
                return false; // 阻止文件添加
            }
            if(this.size > 10 * 1024 * 1024){
                weui.alert('请上传不超过10M的图片');
                return false;
            }
            if (files.length > 1) { // 防止一下子选中过多文件
                weui.alert('最多只能上传1张图片，请重新选择');
                return false;
            }
            if (iconUploadCount + 1 > 1) {
                weui.alert('最多只能上传1张图片');
                return false;
            }

            ++iconUploadCount;
            $iconCount.html(iconUploadCount);
        },
        onQueued: function(){
            iconUploadList.push(this);
            // console.log(this);
        },
        onBeforeSend: function(data, headers){
            // console.log(this, data, headers);
            $.extend(data, { imgType: 'icon' }); // 可以扩展此对象来控制上传参数
            // $.extend(headers, { Origin: 'http://127.0.0.1' }); // 可以扩展此对象来控制上传头部
            // return false; // 阻止文件上传
        },
        onProgress: function(procent){
            // console.log(this, procent);
            // return true; // 阻止默认行为，不使用默认的进度显示
        },
        onSuccess: function (ret) {
            this.content = ret.content;	//上传图片的URL地址
            console.log(iconUploadList, this, ret);
            // return true; // 阻止默认行为，不使用默认的成功态
        },
        onError: function(err){
            console.log(this, err);
            // return true; // 阻止默认行为，不使用默认的失败态
        }
    });

    // icon缩略图预览
    $("#iconFiles").on('click', function(e) {
        var target = e.target;

        while(!target.classList.contains('weui-uploader__file') && target){
            target = target.parentNode;
        }
        if(!target) return;

        var url = target.getAttribute('style') || '';
        var id = target.getAttribute('data-id');

        if(url){
            url = url.match(/url\((.*?)\)/)[1].replace(/"/g, '');
        }
        var gallery = weui.gallery(url, {
            className: 'custom-name',
            onDelete: function(){
                weui.confirm('确定删除该图片？', function(){
                    --iconUploadCount;
                    $iconCount.html(iconUploadCount);

                    for (var i = 0, len = iconUploadList.length; i < len; ++i) {
                        var file = iconUploadList[i];
                        if(file.id == id){
                            file.stop();
                            iconUploadList.splice(i, 1);
                            break;
                        }
                    }
                    target.remove();
                    gallery.hide();
                });
            }
        });
    });
    
    /* title image图片自动上传 */
    var titleUploadCount = 0, titleUploadList = [];
    var $titleImgsCount = $("#titleImgsCount");
    weui.uploader('#title_imgs-uploader', {
        url: 'http://' + location.hostname + ':8080/wine/upload',
        auto: true,
        type: 'file',
        fileVal: 'file',
        compress: {
            width: 1600,
            height: 1600,
            quality: .8
        },
        onBeforeQueued: function(files) {
            // `this` 是轮询到的文件, `files` 是所有文件
            if(["image/jpg", "image/jpeg", "image/png", "image/gif"].indexOf(this.type) < 0){
                weui.alert('请上传图片');
                return false; // 阻止文件添加
            }
            if(this.size > 10 * 1024 * 1024){
                weui.alert('请上传不超过10M的图片');
                return false;
            }
            if (files.length > 6) { // 防止一下子选中过多文件
                weui.alert('最多只能上传6张图片，请重新选择');
                return false;
            }
            if (titleUploadCount + 1 > 6) {
                weui.alert('最多只能上传6张图片');
                return false;
            }

            ++titleUploadCount;
            $titleImgsCount.html(titleUploadCount);
        },
        onQueued: function(){
            titleUploadList.push(this);
            // console.log(this);
        },
        onBeforeSend: function(data, headers){
            // console.log(this, data, headers);
            $.extend(data, { imgType: 'title' }); // 可以扩展此对象来控制上传参数
            // $.extend(headers, { Origin: 'http://127.0.0.1' }); // 可以扩展此对象来控制上传头部
            // return false; // 阻止文件上传
        },
        onProgress: function(procent){
            // console.log(this, procent);
            // return true; // 阻止默认行为，不使用默认的进度显示
        },
        onSuccess: function (ret) {
            this.content = ret.content;	//上传图片的URL地址
            console.log(titleUploadList, this, ret);
            // return true; // 阻止默认行为，不使用默认的成功态
        },
        onError: function(err){
            console.log(this, err);
            // return true; // 阻止默认行为，不使用默认的失败态
        }
    });

    // title image缩略图预览
    $("#titleImgsFiles").on('click', function(e) {
        var target = e.target;

        while(!target.classList.contains('weui-uploader__file') && target){
            target = target.parentNode;
        }
        if(!target) return;

        var url = target.getAttribute('style') || '';
        var id = target.getAttribute('data-id');

        if(url){
            url = url.match(/url\((.*?)\)/)[1].replace(/"/g, '');
        }
        var gallery = weui.gallery(url, {
            className: 'custom-name',
            onDelete: function(){
                weui.confirm('确定删除该图片？', function(){
                    --titleUploadCount;
                    $titleImgsCount.html(titleUploadCount);

                    for (var i = 0, len = titleUploadList.length; i < len; ++i) {
                        var file = titleUploadList[i];
                        if(file.id == id){
                            file.stop();
                            titleUploadList.splice(i, 1);
                            break;
                        }
                    }
                    target.remove();
                    gallery.hide();
                });
            }
        });
    });
    
    /* detail image图片自动上传 */
    var detailUploadCount = 0, detailUploadList = [];
    var $detailImgsCount = $("#detailImgsCount");
    weui.uploader('#detail_imgs-uploader', {
        url: 'http://' + location.hostname + ':8080/wine/upload',
        auto: true,
        type: 'file',
        fileVal: 'file',
        compress: {
            width: 1600,
            height: 1600,
            quality: .8
        },
        onBeforeQueued: function(files) {
            // `this` 是轮询到的文件, `files` 是所有文件
            if(["image/jpg", "image/jpeg", "image/png", "image/gif"].indexOf(this.type) < 0){
                weui.alert('请上传图片');
                return false; // 阻止文件添加
            }
            if(this.size > 10 * 1024 * 1024){
                weui.alert('请上传不超过10M的图片');
                return false;
            }
            if (files.length > 20) { // 防止一下子选中过多文件
                weui.alert('最多只能上传20张图片，请重新选择');
                return false;
            }
            if (detailUploadCount + 1 > 20) {
                weui.alert('最多只能上传20张图片');
                return false;
            }

            ++detailUploadCount;
            $detailImgsCount.html(detailUploadCount);
        },
        onQueued: function(){
            detailUploadList.push(this);
            // console.log(this);
        },
        onBeforeSend: function(data, headers){
            // console.log(this, data, headers);
            $.extend(data, { imgType: 'detail' }); // 可以扩展此对象来控制上传参数
            // $.extend(headers, { Origin: 'http://127.0.0.1' }); // 可以扩展此对象来控制上传头部
            // return false; // 阻止文件上传
        },
        onProgress: function(procent){
            // console.log(this, procent);
            // return true; // 阻止默认行为，不使用默认的进度显示
        },
        onSuccess: function (ret) {
            this.content = ret.content;	//上传图片的URL地址
            console.log(detailUploadList, this, ret);
            // return true; // 阻止默认行为，不使用默认的成功态
        },
        onError: function(err){
            console.log(this, err);
            // return true; // 阻止默认行为，不使用默认的失败态
        }
    });

    // detail image缩略图预览
    $("#detailImgsFiles").on('click', function(e) {
        var target = e.target;

        while(!target.classList.contains('weui-uploader__file') && target){
            target = target.parentNode;
        }
        if(!target) return;

        var url = target.getAttribute('style') || '';
        var id = target.getAttribute('data-id');

        if(url){
            url = url.match(/url\((.*?)\)/)[1].replace(/"/g, '');
        }
        var gallery = weui.gallery(url, {
            className: 'custom-name',
            onDelete: function(){
                weui.confirm('确定删除该图片？', function(){
                    --detailUploadCount;
                    $detailImgsCount.html(detailUploadCount);

                    for (var i = 0, len = detailUploadList.length; i < len; ++i) {
                        var file = detailUploadList[i];
                        if(file.id == id){
                            file.stop();
                            detailUploadList.splice(i, 1);
                            break;
                        }
                    }
                    target.remove();
                    gallery.hide();
                });
            }
        });
    });
    
    $('input[name="state"]').on('click', function() {
	if($(this).prop("checked")) {
	    $(this).val("1");
	}
	else {
	    $(this).val("2");
	}
    });
    
    weui.searchBar('#user-searchBar');
    
    $('#user-searchBar .weui-search-bar__search-btn').on('click', function() {
	var query = $('#user-searchBar input').val();
	$.ajax({
	    type: "GET",
	    url: "/wine/admin/user",
	    data: "search="+query,
	    success: function(data){
		console.log(data);
		$('#user-form input[name="name"]').val(data.content.name);
		$('#user-form input[name="phone"]').val(data.content.phone);
		$('#user-form input[name="points"]').val(data.content.points);
		if(data.content.type == 1) {
		    $('#user-type').prop('checked', true);
		    $("#user-vip").show();
		    $("#user-normal").hide();
		}
		else {
		    $('#user-type').prop('checked', false);
		    $("#user-vip").hide();
		    $("#user-normal").show();
		}
	    }
	})
    });
    

    $('#user-type').on('click', function() {
	if($(this).prop("checked")) {
	    $("#user-vip").show();
	    $("#user-normal").hide();
	}
	else {
	    $("#user-vip").hide();
	    $("#user-normal").show();
	}
    });

})(jQuery);