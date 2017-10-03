(function($) {

    var cateMap = {}, categories = [];
    var iconUploader = {
        type : 'icon',
        count : 0,
        maxCount : 1,
        uploadList : []
    };
    var titleUploader = {
        type : 'title',
        count : 0,
        maxCount : 6,
        uploadList : []
    };
    var detailUploader = {
        type : 'detail',
        count : 0,
        maxCount : 20,
        uploadList : []
    };
    function initialCategory(categories, data) {
        $.each(data, function(i, e) {
            cateMap[e.name] = e.id;
            cateMap[e.id] = e.name;
            var cate = {};
            cate.label = e.name;
            cate.value = e.id;
            if (e.subItems && e.subItems.length > 0) {
                cate.children = [];
                initialCategory(cate.children, e.subItems);
            }
            categories.push(cate);
        });
    }
    ;
    $.get("/wine/category", function(data) {
        initialCategory(categories, data.content);
    });

    function showItemList() {
        $('#item-form').hide();
        $('#item-list').show();
        $('#item-list .weui-grids').empty();
        $.get("/wine/admin/item/all", function(data) {
            $.each(data.content, function(i, e) {
                var content = '<a href="javascript:;" class="weui-grid item" id="item-' + e.id + '">'
                        + '  <div class="weui-grid__icon">' + '    <img src="resources/' + e.icon + '" alt="">'
                        + ' </div>' + ' <p class="weui-grid__label">' + e.name + '</p>' +
                        // '<span
                        // class="del-item
                        // weui-badge"
                        // style="position:
                        // absolute;top:
                        // 0.5em;right:
                        // 0.5em;">X</span>'+
                        '</a>';
                $('#item-list .weui-grids').append(content);
                $('#item-' + e.id).data('item', e);
            });
        });
    }
    ;
    showItemList();

    function showOrderList() {
        $.get("/wine/order/list_admin", function(data) {
            $('.order-list .weui-cells_access').empty();
            if(data && data.success) {
                $.each(data.orders, function(i, e) {
                    var content = '<a class="weui-cell order-item" data-id="' + e.id + '" href="#pay">'
                    + '  <div class="weui-cell__hd"></div>' + '  <div class="weui-cell__bd weui-cell_primary">'
                    + '订单号：' + e.id + e.payAmount + '元' + '  </div>' + '</a>';
                    // ' <div class="weui-uploader">'+
                    // ' <div class="weui-uploader__hd weui-cell"></div>'+
                    // ' <div class="weui-uploader__bd">'+
                    // ' <ul class="weui-uploader__files">'
                    $('.order-list .weui-cells_access').append(content);
                });
            }
        });
    }

    function initialImgUploader(uploader) {
        /* 图片自动上传 */
        weui.uploader('#' + uploader.type + '_imgs-uploader', {
            url : '/wine/upload',
            auto : true,
            type : 'file',
            fileVal : 'file',
            compress : {
                width : 1600,
                height : 1600,
                quality : .8
            },
            onBeforeQueued : function(files) {
                // `this` 是轮询到的文件, `files` 是所有文件
                if ([ "image/jpg", "image/jpeg", "image/png", "image/gif" ].indexOf(this.type) < 0) {
                    weui.alert('请上传图片');
                    return false; // 阻止文件添加
                }
                if (this.size > 10 * 1024 * 1024) {
                    weui.alert('请上传不超过10M的图片');
                    return false;
                }
                if (files.length > uploader.maxCount) { // 防止一下子选中过多文件
                    weui.alert('最多只能上传20张图片，请重新选择');
                    return false;
                }
                if (uploader.count + 1 > uploader.maxCount) {
                    weui.alert('最多只能上传20张图片');
                    return false;
                }

                ++uploader.count;
                $("#" + uploader.type + "ImgsCount").html(uploader.count);
            },
            onQueued : function() {
                uploader.uploadList.push(this);
                // console.log(this);
            },
            onBeforeSend : function(data, headers) {
                // console.log(this, data, headers);
                $.extend(data, {
                    imgType : uploader.type
                }); // 可以扩展此对象来控制上传参数
                // $.extend(headers, { Origin: 'http://127.0.0.1' }); //
                // 可以扩展此对象来控制上传头部
                // return false; // 阻止文件上传
            },
            onProgress : function(procent) {
                // console.log(this, procent);
                // return true; // 阻止默认行为，不使用默认的进度显示
            },
            onSuccess : function(ret) {
                this.content = ret.content; // 上传图片的URL地址
                console.log(uploader.uploadList, this, ret);
                // return true; // 阻止默认行为，不使用默认的成功态
            },
            onError : function(err) {
                console.log(this, err);
                // return true; // 阻止默认行为，不使用默认的失败态
            }
        });

        // detail image缩略图预览
        $("#" + uploader.type + "ImgsFiles").on('click', function(e) {
            var target = e.target;
            while (!target.classList.contains('weui-uploader__file') && target) {
                target = target.parentNode;
            }
            if (!target)
                return;
            var url = target.getAttribute('style') || '';
            var id = target.getAttribute('data-id');
            if (url) {
                url = url.match(/url\((.*?)\)/)[1].replace(/"/g, '');
            }
            var gallery = weui.gallery(url, {
                className : 'custom-name',
                onDelete : function() {
                    weui.confirm('确定删除该图片？', function() {
                        --uploader.count;
                        $("#" + uploader.type + "ImgsCount").html(uploader.count);
                        for (var i = 0, len = uploader.uploadList.length; i < len; ++i) {
                            var file = uploader.uploadList[i];
                            if (file.id == id) {
                                // file.stop();
                                uploader.uploadList.splice(i, 1);
                                break;
                            }
                        }
                        target.remove();
                        gallery.hide();
                    });
                }
            });
        });
    }

    // tab panel
    weui.tab('#tab', {
        defaultIndex : 0,
        onChange : function(index) {
            console.log(index);
            if (index == 0) { // 商品管理页面

            } else if (index == 1) { // 订单管理页面
                showOrderList();
            } else if (index == 2) { // 积分管理页面

            } else { // 其他

            }
        }
    });

    // 删除商品信息
    $('#item-list').on("click", '.del-item', function(event) {
        $(this).closest('.item').remove();
    });

    // 编辑商品信息
    $('#item-list').on(
            "click touch",
            '.item.weui-grid',
            function(event) {
                var $item = $(this);
                weui.actionSheet([
                        {
                            label : '编辑',
                            onClick : function() {
                                var item = $item.data('item');
                                $('#item-form').data('id', item.id);
                                $('input[name="name"]').val(item.name);
                                $('textarea[name="detail"]').val(item.detail);
                                $('input[name="categoryId"]').val(cateMap[item.categoryId]);
                                $('input[name="normalPrice"]').val(item.normalPrice);
                                $('input[name="vipPrice"]').val(item.vipPrice);
                                $('input[name="sales"]').val(item.sales);
                                $('input[name="state"]').prop('checked', (item.state == 1) ? 'true' : 'false');
                                iconUploader.uploadList = [];
                                if (item.icon) {
                                    iconUploader.uploadList[0] = {
                                        'content' : item.icon,
                                        'id' : item.icon
                                    };
                                    $('#iconImgsFiles').empty();
                                    $('#iconImgsFiles').append(
                                            '<li class="weui-uploader__file" data-id="' + item.icon
                                                    + '" style="background-image: url(&quot;/wine/resources/'
                                                    + item.icon + '&quot;);"></li>');
                                }
                                titleUploader.uploadList = [];
                                $('#titleImgsFiles').empty();
                                if (item.titleImgs) {
                                    var titleImgs = item.titleImgs.split(",");
                                    $.each(titleImgs, function(i, e) {
                                        titleUploader.uploadList[i] = {
                                            'content' : e,
                                            'id' : e
                                        };
                                        $('#titleImgsFiles').append(
                                                '<li class="weui-uploader__file" data-id="' + e
                                                        + '" style="background-image: url(&quot;/wine/resources/' + e
                                                        + '&quot;);"></li>');
                                    });
                                }
                                detailUploader.uploadList = [];
                                $('#detailImgsFiles').empty();
                                if (item.detailImgs) {
                                    var detailImgs = item.detailImgs.split(",");
                                    $.each(detailImgs, function(i, e) {
                                        detailUploader.uploadList[i] = {
                                            'content' : e,
                                            'id' : e
                                        };
                                        $('#detailImgsFiles').append(
                                                '<li class="weui-uploader__file" data-id="' + e
                                                        + '" style="background-image: url(&quot;/wine/resources/' + e
                                                        + '&quot;);"></li>');
                                    });
                                }
                                $('#item-list').hide();
                                $('#item-form').show();
                            }
                        }, {
                            label : '删除',
                            onClick : function() {
                                var item = $item.data('item');
                                weui.confirm('确定删除该商品吗？', function() {
                                    // console.log('yes');
                                    // delete item
                                    $.ajax({
                                        type : "DELETE",
                                        url : "/wine/admin/item/delete",
                                        contentType : "application/json",
                                        data : JSON.stringify(item),
                                        success : function(data) {
                                            if (data.success) {
                                                weui.toast('删除成功', 3000);
                                                $item.remove();
                                            } else {
                                                weui.toast('删除失败', 3000);
                                            }
                                        }
                                    });
                                    ;
                                }, function() {
                                    // console.log('no');
                                }, {
                                    title : '删除商品'
                                });
                            }
                        } ], {
                    className : "custom-classname"
                });
            });

    // 添加商品信息
    $('#add-item').on("click touch", function(event) {
        $('#item-form').removeData("id");
        $('input[name="name"]').val('');
        $('textarea[name="detail"]').val('');
        $('input[name="categoryId"]').val('');
        $('input[name="normalPrice"]').val('');
        $('input[name="vipPrice"]').val('');
        $('input[name="sales"]').val('');
        $('input[name="state"]').prop('checked', 'true');
        iconUploader.uploadList = [];
        $('#iconImgsFiles').empty();
        titleUploader.uploadList = [];
        $('#titleImgsFiles').empty();
        detailUploader.uploadList = [];
        $('#detailImgsFiles').empty();
        $('#item-list').hide();
        $('#item-form').show();
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
                    'id' : '',
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
                var id = $('#item-form').data('id');
                if(id) {
                    item.id = id;
                }
                item.name = $('input[name="name"]').val();
                item.detail = $('textarea[name="detail"]').val();
                var cateStr = $('input[name="categoryId"]').val();
                if(cateStr.lastIndexOf('--') > 0) {
                    var lastCateIdx = cateStr.lastIndexOf('--') + 2;
                    item.categoryId = cateMap[cateStr.substr(lastCateIdx)];
                }
                else {
                    item.categoryId = cateMap[cateStr];
                }
                item.normalPrice = $('input[name="normalPrice"]').val();
                item.vipPrice = $('input[name="vipPrice"]').val();
                item.sales = $('input[name="sales"]').val();
                item.status = $('input[name="state"]').prop("checked") ? 1 : 2;
                if (iconUploader.uploadList.length == 0) {
                    weui.topTips('请输入商品缩略图', {
                        duration : 3000,
                        className : "custom-classname",
                        callback : function() {
                            // console.log('close');
                        }
                    });
                    return;
                }
                item.icon = iconUploader.uploadList[0].content;
                if (titleUploader.uploadList.length == 0) {
                    weui.topTips('请输入商品预览图片', {
                        duration : 3000,
                        className : "custom-classname",
                        callback : function() {
                            // console.log('close');
                        }
                    });
                    // $('input[id="icon"]').closest('.weui-cell').addClass('weui-cell_warn');
                    return;
                }
                $.each(titleUploader.uploadList, function(i, e) {
                    item.titleImgs += ',' + e.content;
                });
                item.titleImgs = item.titleImgs.substr(1);
                if (detailUploader.uploadList.length == 0) {
                    weui.topTips('请输入商品详情图片', {
                        duration : 3000,
                        className : "custom-classname",
                        callback : function() {
                            console.log('close');
                        }
                    });
                    return;
                }
                $.each(detailUploader.uploadList, function(i, e) {
                    item.detailImgs += ',' + e.content;
                });
                item.detailImgs = item.detailImgs.substr(1);
                console.log(item);
                var loading = weui.loading('提交中...');
                // submit
                var type = id ? "PUT" : "POST";
                var url =  id ? "/wine/admin/item/modify" : "/wine/admin/item/add";
                $.ajax({
                    type : type,
                    url : url,
                    contentType : "application/json",
                    data : JSON.stringify(item),
                    success : function(data) {
                        loading.hide();
                        if (data.success) {
                            weui.toast('提交成功', 3000);
                            showItemList();
                        } else {
                            weui.toast('提交失败', 3000);
                        }
                    }
                });
                // setTimeout(function() {loading.hide();}, 1500);
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
            depth : 3,
            defaultValue : [ 1, 5, 0 ],
            onChange : function(result) {
                console.log(result);
            },
            onConfirm : function(result) {
                console.log(result);
                var str = '';
                var x;
                for (x in result) {
                    str += "--" + result[x].label;
                }
                str = str.substr(2);
                $('#category').val(str);
            },
            id : 'cascadePicker'
        });
    });

    // image upload
    /* icon图片自动上传 */
    initialImgUploader(iconUploader);
    /* title image图片自动上传 */
    initialImgUploader(titleUploader);
    /* detail image图片自动上传 */
    initialImgUploader(detailUploader);

    $('.back-item-list').on('click touch', function() {
        $('#item-form').hide();
        $('#item-list').show();
    });

    // ====================================会员管理=====================================

    weui.searchBar('#user-searchBar');

    $('#user-searchBar .weui-search-bar__search-btn').on('click touch', function() {
        var query = $('#user-searchBar input').val();
        $.ajax({
            type : "GET",
            url : "/wine/admin/user",
            data : "search=" + query,
            success : function(data) {
                //console.log(data);
                var user = data.content;
                $('#user-form').data('id', user.id);
                $('#user-form input[name="name"]').val(user.name);
                $('#user-form input[name="phone"]').val(user.phone);
                $('#user-form input[name="points"]').val(user.points);
                $('#modifyPoints').show();
                $('#submitPoints').hide();
                $('#cancelPoints').hide();
                if (user.type == 1) {
                    $('#user-type').prop('checked', true);
                    $("#user-vip").show();
                    $("#user-normal").hide();
                } else {
                    $('#user-type').prop('checked', false);
                    $("#user-vip").hide();
                    $("#user-normal").show();
                }
            }
        });
    });
    
    $('#modifyPoints').on('click', function() {
        $('#modifyPoints').hide();
        $('#submitPoints').show();
        $('#cancelPoints').show();
        $('#user-form input[name="points"]').addClass('points');
        $('#user-form input[name="points"]').prop('disabled', false);
    });
    
    $('#submitPoints').on('click', function() {
        weui.confirm('确定更新用户积分吗？', function () {
            //console.log('yes');
            var userid = $('#user-form').data('id');
            var points = $('#user-form input[name="points"]').val();
            $.ajax({
                type : "PUT",
                url : "/wine/admin/user/points?id="+userid+"&points="+points,
                success : function(data) {
                    //console.log(data);
                    weui.toast('积分更新成功', 2000);
                    $('#modifyPoints').show();
                    $('#submitPoints').hide();
                    $('#cancelPoints').hide();
                    $('#user-form input[name="points"]').removeClass('points');
                    $('#user-form input[name="points"]').prop('disabled', true);
                }
            });
        }, function () {
            //console.log('no');
            $('#modifyPoints').show();
            $('#submitPoints').hide();
            $('#cancelPoints').hide();
            $('#user-form input[name="points"]').removeClass('points');
            $('#user-form input[name="points"]').prop('disabled', true);
        }, {
            title: '更新用户积分'
        });
    });
    

    $('#user-type').on('click', function() {
        weui.confirm('确定更新用户类型吗？', function () {
            //console.log('yes');
            if ($('#user-type').prop('checked')) {
                var userid = $('#user-form').data('id');
                var type = 1;
                $.ajax({
                    type : "PUT",
                    url : "/wine/admin/user/type?id="+userid+"&type="+type,
                    success : function(data) {
                        //console.log(data);
                        weui.toast('类型更新成功', 2000);
                        $("#user-vip").show();
                        $("#user-normal").hide();
                    }
                });
            } else {
                var userid = $('#user-form').data('id');
                var type = 0;
                $.ajax({
                    type : "PUT",
                    url : "/wine/admin/user/type?id="+userid+"&type="+type,
                    success : function(data) {
                        //console.log(data);
                        weui.toast('类型更新成功', 2000);
                        $("#user-vip").hide();
                        $("#user-normal").show();
                    }
                });
            }
        }, function () {
            //console.log('no');
            var checked = $('#user-type').prop('checked');
            $('#user-type').prop('checked', !checked);
        }, {
            title: '更新用户类型'
        });
    });

})(jQuery);