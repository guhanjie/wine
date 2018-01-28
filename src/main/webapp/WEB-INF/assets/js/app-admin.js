(function($) {

    // ====================================0. 路由管理=====================================

    // tab panel
    weui.tab('#tab', {
        defaultIndex : 0,
        onChange : function(index) {
            if (index == 0) { // 商品管理页面
                showItemList();
            } else if (index == 1) { // 订单管理页面
                $.get("/wine/order/list_admin", function(data) {
                    showOrderList(data);
                });
            } else if (index == 2) { // 会员积分管理页面

            } else { // 会员列表

            }
        }
    });

    //initialize
    showItemList();

    // ====================================1. 商品管理=====================================
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
    };
    
    function initialImgUploader(uploader) {
        /* 图片自动上传 */
        weui.uploader('#' + uploader.type + '_imgs-uploader', {
            url : '/wine/admin/upload',
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
            $(this).closest('.weui-cell').addClass('weui-cell_warn');
        } else {
            $(this).closest('.weui-cell').removeClass('weui-cell_warn');
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
    

    // ====================================2. 订单管理=====================================
    function showOrderList(data) {
        $('.order-list .weui-cells_access').empty();
        if(data && data.success) {
            data.fmtShipType = function () {
              if(this.shipType == 1) {
                  return "快递";
              }
              else if(this.shipType == 2) {
                  return "同城配送";
              }
              return "--";
            }
            data.fmtCreateTime = function() {
                return new Date(this.createTime).toLocaleString();
            }
            data.fmtStatus = function() {
              switch(this.status) {
                case 29:
                    return '<span class="btn_status text-primary">已支付</span>';
                case 13:
                    return '<span class="btn_status text-success">已送达</span>';
                case 05:
                    return '<span class="btn_status text-success">正在配送</span>';
                case 03:
                    return '<span class="btn_status text-bold">已取消</span>';
                case 01:
                    return '<span class="btn_cancel">取消</span>';
                default:
                    return '<span class="btn_success gloming">去支付</span>';
              }
            }
            var orderTemplate = $('#order-template').html();
            Mustache.parse(orderTemplate);   // optional, speeds up future uses
            var rendered = Mustache.render(orderTemplate, data);
            $('.order-list .weui-cells_access').append(rendered);
            //pagenation
            var $pagenation = $('.order-list .pagenation');
            $pagenation.empty();
            if(data.current > 0) {
              $pagenation.append('<a class="page-left" data-page='+(data.current-1)+' href="#"><i class="glyphicon glyphicon-menu-left"></i></a>');
            }
            $pagenation.append('<span> '+(data.current+1)+' / '+data.pages+' </span>');
            if(data.current < data.pages-1) {
              $pagenation.append('<a class="page-right" data-page='+(data.current+1)+' href="#"><i class="glyphicon glyphicon-menu-right"></i></a>');
            }
        }
    };
    
    $('.order-list').on('click touch', '.page-left,.page-right', function() {
        var pageId = $(this).data('page');
        $.ajax({
            type : "GET",
            url : "/wine/order/list_admin?page="+pageId,
            success : function(data) {
                showOrderList(data);
            }
        });
    });

    // ====================================3. 会员管理=====================================

    weui.searchBar('#user-searchBar');

    $('#user-searchBar .weui-search-bar__search-btn').on('click touch', function() {
        var query = $('#user-searchBar input').val();
        $('.promotees_list').empty();
        $.ajax({
            type : "GET",
            url : "/wine/admin/user",
            data : "search=" + query,
            success : function(data) {
                //console.log(data);
                var user = data.user;
                if(user == undefined) {
                    weui.alert("用户不存在");
                    $('#user-form').removeData('id');
                    $('#user-form input[name="name"]').val('');
                    $('#user-form input[name="phone"]').val('');
                    $('#user-form input[name="points"]').val('');
                    $('#modifyPoints').addClass('hide');
                    return;
                }
                $('#user-form').data('id', user.id);
                $('#user-form input[name="name"]').val(user.name);
                $('#user-form input[name="phone"]').val(user.phone);
                $('#user-form input[name="points"]').val(user.points);
                $('#modifyPoints').removeClass('hide');
                $('#submitPoints').addClass('hide');
                $('#cancelPoints').addClass('hide');
                if (user.type == 1) {
                    $('#user-type').prop('checked', true);
                    $("#user-vip").show();
                    $("#user-normal").hide();
                } else {
                    $('#user-type').prop('checked', false);
                    $("#user-vip").hide();
                    $("#user-normal").show();
                }
                var promotees = data.promotees;
                if(promotees) {
                    $('.promotees_list').append('<table class="table table-condensed table-striped">'+
                                    '<thead>'+
                                    '<tr>'+
                                      '<th>ID</th>'+
                                      '<th>用户名</th>'+
                                      '<th>积分</th>'+
                                      '<th>电话</th>'+
                                      '<th>注册时间</th>'+
                                    '</tr>'+
                                  '</thead>'+
                                  '<tbody>'+
                                  '</tbody>'+
                                '</table>');
                    for(i=0; i<promotees.length; i++) {
                        var promotee = promotees[i];
                        $('.promotees_list tbody').append(
                            '<tr>'+
                              '<th scope="row">'+promotee.id+'</th>'+
                              '<td>'+promotee.name+'</td>'+
                              '<td>'+promotee.points+'</td>'+
                              '<td>'+promotee.phone+'</td>'+
                              '<td>'+new Date(promotee.createTime).toLocaleString()+'</td>'+
                            '</tr>');
                    }
                }
            }
        });
    });
    
    $('#modifyPoints').on('click', function() {
        $('#modifyPoints').addClass('hide');
        $('#submitPoints').removeClass('hide');
        $('#cancelPoints').removeClass('hide');
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
                    $('#modifyPoints').removeClass('hide');
                    $('#submitPoints').addClass('hide');
                    $('#cancelPoints').addClass('hide');
                    $('#user-form input[name="points"]').removeClass('points');
                    $('#user-form input[name="points"]').prop('disabled', true);
                }
            });
        }, function () {
            //console.log('no');
            $('#modifyPoints').removeClass('hide');
            $('#submitPoints').addClass('hide');
            $('#cancelPoints').addClass('hide');
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