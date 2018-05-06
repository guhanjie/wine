(function($) {
    // buy item now
    $('body').on('click', '.buy-now', function(e) {
    	if($(this).hasClass('rush')) {
            window.location.href = "/wine/order/checkout?type=rush";
    	}
    	else {
    		window.location.href = "/wine/order/checkout?type=normal";
    	}
    });
    
    // add item into cart
    $("body").on('click', '.add-cart', function(e) {
        weui.toast('已加入购物车', 1000);
        // var data = {};
        // var $prod = $(this).parents('.product-item');
        // data["itemId"] = $prod.data('id');
        // // data["price"] = $prod.data('price');
        // var $itemCount = $(this).siblings('.item_quantity');
        // data["count"] = $itemCount.length == 0 ? 1 : $itemCount.val();
        // $.ajax({
        // type : 'POST',
        // url : '/wine/cart/add',
        // data : data,
        // success : function(result) {
        // weui.toast('已加入购物车', 2000);
        // }
        // });
    });

    // remove item from cart
    // $("body").on('click', '.item-remove', function(e) {
    // var itemid = $(this).closest('.itemRow').data('id');
    // var item = simpleCart.find({"name":""+itemid})[0];
    // if(!!item) {
    // item.remove();
    // }
    // $('.cart-header').fadeOut('slow', function(e) {
    // $('.cart-header').remove();
    // });
    // });

    $("body").on('click', '.simpleCart_increment,.simpleCart_decrement', function(e) {
        simpleCart.update();
        $('input.points').val('');
        $('span.delcpns').text('');
        $('.coupons-discount').hide();
    });
    
    $("body").on('click', '.shipType :radio', function(e) {
        //快递
        if($('#shipType1').prop('checked')) {
            ships = 5;
        }
        //同城快送
        if($('#shipType2').prop('checked')) {
            ships = 10;
        }
        simpleCart.update();
    });

    // use coupon
    $("body").on('click', '.cpns.btn-sm', function(e) {
        var cpns = parseInt($(this).siblings('input.points').val());
        var $cpn = $(this).siblings('p').find('strong');
        var maxcpns = parseInt($cpn.text());
        var total = simpleCart.total();
        var all = simpleCart.all();
        if (simpleCart.total() == 0) {
            weui.alert('购物车内空空如也，请先加入商品');
            return;
        }
        if (isNaN(cpns)) {
            weui.alert('使用积分只能填入数字');
            return;
        }
        if (cpns < 0) {
            weui.alert('使用积分不能为负数');
            return;
        }
        if (cpns > maxcpns) {
            weui.alert('使用积分不能超过最大积分');
            return;
        }
        if (cpns > all) {
            weui.alert('使用积分不能超过订单总额');
            return;
        }
        simpleCart["coupons"] = cpns;
        // $cpn.text(maxcpns-cpns);
        $('.coupons-discount').find('span.delcpns').text('-￥' + cpns);
        $('.coupons-discount').fadeIn('slow', function(e) {
        	var num = new Number(all - cpns);
        $('.simpleCart_all').text('¥' + num.toFixed(1));
        });
    });

    // place order
    $("body").on('click', '#submit', function(e) {
        if ($(this).is('.disabled')) {
            return;
        }
        if (simpleCart.total() == 0) {
            weui.alert('购物车内空空如也，请先加入商品');
            return;
        }
        // 如果是秒杀活动，则只能使用积分
        if(ships==0 && $('.simpleCart_all').text() != '¥0.0') {
        	weui.alert('本单为活动秒杀，必须使用等额积分支付本单');
        	return;
        }
        // 1.收集数据
        var order = {};
        var total = $('.simpleCart_total').text();
        order["totalAmount"] = !!total ? parseFloat(total.replace("¥", "").replace(",", "")) : 0;
        var all = $('.simpleCart_all').text();
        order["payAmount"] = !!all ? parseFloat(all.replace("¥", "").replace(",", "")) : 0;
        order["coupons"] = simpleCart["coupons"] || 0;
        var items = ""; // itemid:quantity,[itemid:quantity]
        simpleCart.each(function(item) {
            items += ',' + item.itemid() + ':' + item.quantity();
        });
        order["items"] = items.substr(1);
        order["ships"] = ships;
        order["shipType"] = $(':radio[name="shipType"]:checked').val();
        order["sourceType"] = $('#sourceType').val() ? $('#sourceType').val() : "normal";
        order["contactor"] = $('#order-contactor').val();
        order["phone"] = $('#order-phone').val();
        order["address"] = $('#order-address').val();
        // 2.验证订单
        if (!order["contactor"]) {
            weui.alert('请输入联系人');
            $('#order-contactor').addClass('warn');
            $('#submit').removeClass('disabled');
            return;
        }
        if (!order["phone"]) {
            weui.alert('请输入联系电话');
            $('#order-phone').addClass('warn');
            $('#submit').removeClass('disabled');
            return;
        }
        if (!order["address"]) {
            weui.alert('请输入收货地址');
            $('#order-address').addClass('warn');
            $('#submit').removeClass('disabled');
            return;
        }
        $(this).addClass('disabled');
        var loading = weui.loading('订单提交中...');
        $.ajax({
            type : 'POST',
            url : '/wine/order/put',
            data : JSON.stringify(order),
            contentType : 'application/json',
            success : function(data) {
                loading.hide();
                if (data.success) {
                    simpleCart.empty();
                    weui.dialog({
                        title : '订单提交成功',
                        content : '订单已提交，请尽快完成支付',
                        className : 'submit-success',
                        buttons : [
                                {
                                    label : '稍后支付', type : 'default', onClick : function() {
                                        window.location.href = "/wine/order/list";
                                    }
                                },
                                {
                                    label : '去支付', type : 'primary', onClick : function() {
                                        $('.my-cart').hide();
                                        $('.weui-msg.weixin_pay .order-item').data('id', data.content.id);
                                        $('#res_amount').text('' + data.content.payAmount + ' 元');
                                        $('.pay-msg').fadeIn();
                                        window.scrollTo(0,0); //页面滚动回顶端
                                    }
                                } ]
                    });
                } else {
                    weui.alert(data.description);
                }
                $('#submit').removeClass('disabled');
            }, error : function(xhr, type) {
                weui.alert('订单信息有误，提交失败');
                $('#submit').removeClass('disabled');
            }
        });
    });
    
    // weixin-pay msg btn-back
    $("body").on('click', '.pay.weui-msg.weixin_pay .btn_back', function() {
        window.location.href = "/wine/order/list";
    });
    
    //-------------------------order search-------------------------------
    $("body").on('click', '.order-item .weui-cell__bd', function() {
        $(this).find('.order-detail').fadeToggle(600);
        return false;
    });

    $("body").on('click', '.order-list .btn_cancel', function() {
        var orderid = $(this).parents('.order-item').data('id');
        var $that = $(this);
        weui.dialog({
            title: '取消订单',
            content: '是否确定取消该订单？',
            buttons: [{
                label: '放弃',
                type: 'default',
                onClick: function() {}
            },
            {
                label: '确定',
                type: 'primary',
                onClick: function() {
                    $.ajax({
                        type: 'POST',
                        url: '/wine/order/cancel',
                        data: {
                            'orderid': orderid
                        },
                        dataType: 'json',
                        success: function(data) {
                            if (data.success) {
                                var $parent = $that.parents('.weui-cell__ft');
                                $that.remove();
                                $parent.empty();
                                $parent.append('<span class="btn_status text-bold">已取消</span>');
                            } else {
                                weui.alert(data.description);
                            }
                        },
                        error: function(xhr, type) {
                            weui.topTips('订单支付失败');
                        }
                    });
                }
            }]
        });
    });

    $("body").on('click', '.order-list .btn_success', function() {
        var orderid = $(this).parents('.order-item').data('id');
        var $that = $(this);
        weui.dialog({
            title: '订单支付成功',
            content: '是否确定用户已完成该订单支付？',
            buttons: [{
                label: '取消',
                type: 'default',
                onClick: function() {}
            },
            {
                label: '确定',
                type: 'primary',
                onClick: function() {
                    $.ajax({
                        type: 'POST',
                        url: 'payed',
                        data: {
                            'orderid': orderid
                        },
                        dataType: 'json',
                        success: function(data) {
                            if (data.success) {
                                var $parent = $that.parents('.weui-cell__ft');
                                $that.remove();
                                $parent.append('<span class="btn_status text-primary">已支付</span>');
                            } else {
                                weui.topTips(data.content);
                            }
                        },
                        error: function(xhr, type) {
                            weui.topTips('订单取消失败');
                        }
                    });
                }
            }]
        });
    });

    $("body").on('click', '.order-list .btn_pay', function() {
        var $item = $(this).parents('.order-item');
        $('.order-list').hide();
        $('.weui-msg .order-item').data('id', $item.data('id'));
        $('#res_amount').text($item.find('#amount').text());
        $('.weui-msg.weixin_pay').fadeIn();
    });

    $("body").on('click', '.order.weui-msg.weixin_pay .btn_back', function(event) {
        event.preventDefault();
        $('.weui-msg').hide();
        $('.order-list').fadeIn();
        return false;
    });

})(jQuery);
