$(function() {
    $('.order-item').on('click', '.weui-cell__bd', function() {
        $(this).find('.order-detail').fadeToggle(600);
        return false;
    });

    $('.order-list').on('click', '.btn_cancel', function() {
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
                        url: 'cancel',
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

    $('.order-list').on('click', '.btn_success', function() {
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

    $('.order-list').on('click', '.btn_pay', function() {
        var $item = $(this).parents('.order-item');
        $('.order-list').hide();
        $('.weui-msg .order-item').data('id', $item.data('id'));
        $('#res_amount').text($item.find('#amount').text());
        $('.weui_msg.weixin_pay').fadeIn();
    });

    $('.weui_msg.weixin_pay').on('click', '.btn_back', function(event) {
        event.preventDefault();
        $('.weui-msg').hide();
        $('.order-list').fadeIn();
        return false;
    });

});