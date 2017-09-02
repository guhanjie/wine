(function($) {
    // add item into cart
    $("body").on('click', '.add-cart', function(e) {
	$.weui.toast('已加入购物车', 2000);
//	var data = {};
//	var $prod = $(this).parents('.product-item');
//	data["itemId"] = $prod.data('id');
//	// data["price"] = $prod.data('price');
//	var $itemCount = $(this).siblings('.item_quantity');
//	data["count"] = $itemCount.length == 0 ? 1 : $itemCount.val();
//	$.ajax({
//	    type : 'POST',
//	    url : '/wine/cart/add',
//	    data : data,
//	    success : function(result) {
//		weui.toast('已加入购物车', 2000);
//	    }
//	});
    });

    // remove item from cart
//    $("body").on('click', '.item-remove', function(e) {
//	var itemid = $(this).closest('.itemRow').data('id');
//	var item = simpleCart.find({"name":""+itemid})[0];
//	if(!!item) {
//	    item.remove();
//	}
//      $('.cart-header').fadeOut('slow', function(e) {
//          $('.cart-header').remove();
//	});
//    });
    
    //use coupon
    $("body").on('click', '.cpns.btn-sm', function(e) {
	var cpns = parseInt($(this).siblings('input.points').val());
	var $cpn = $(this).siblings('p').find('strong');
	var maxcpns = parseInt($cpn.text());
	if(simpleCart.total() == 0) {
	    $.weui.alert('购物车内空空如也，请先加入商品');
	    return;
	}
	if(isNaN(cpns)) {
	    $.weui.alert('使用积分只能填入数字');
	    return;
	}
	if(cpns<0) {
	    $.weui.alert('使用积分不能为负数');
	    return;
	}
	if(cpns>maxcpns) {
	    $.weui.alert('使用积分不能超过最大积分');
	    return;
	}
	simpleCart["coupons"] = cpns;
	//$cpn.text(maxcpns-cpns);
	$('.coupons-discount').find('span.delcpns').text('-￥'+cpns);
	var all = $('.simpleCart_all').text();
	var total = parseFloat(all.replace("¥","").replace(",",""))
	total = '¥'+(total - cpns);
	$('.simpleCart_all').text(total);
	$('.coupons-discount').fadeIn('slow', function(e) {
	});
    });
    
    //place order
    $("body").on('click', '#submit-order', function(e) {
	if($(this).is('.disabled')) {
	    return;
	}
	var order = {};
	order["amount"] = simpleCart.total();
	order["coupons"] = simpleCart["coupons"];
	var items = "";
	simpleCart.each(function (item) {
		items += ',' + item.itemid() + '|' + item.quantity();
	});
	order["items"] = items.substr(1);
	order["ships"] = ships;
	order["sourceType"] = "normal";
	$(this).addClass('disabled');
	$.weui.loading('订单提交中...');
	$.ajax({
	    type: 'POST',
	    url: '/wine/order/put',
	    data: JSON.stringify(order),
	    contentType: 'application/json',
	    success: function(data){
		$.weui.hideLoading();
		if(data.success) {
		    $.weui.dialog({
			    title: '订单提交成功',
			    content: '订单已提交，请尽快完成支付',
			    className: 'submit-success',
			    buttons: [{
			        label: '取消',
			        type: 'default',
			        onClick: function () { simpleCart.empty(); }
			    }, {
			        label: '确定',
			        type: 'primary',
			        onClick: function () { simpleCart.empty(); alert('确定'); }
			    }]
			});
		}
		else {
		    $.weui.topTips('订单信息有误，提交失败');
		}
		$('#submit').removeClass('disabled');
	    },
	    error: function(xhr, type){
		$.weui.topTips('订单信息有误，提交失败');
		$('#submit').removeClass('disabled');
	    }
	});
    });
    
})(jQuery);
