<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- check out -->
<div class="container">
  <div class="check-nav">
    <a class="back-buy" href="${pageContext.request.contextPath}/index">返回商品页</a>
    <a href="javascript:;" class="simpleCart_empty">清空购物车</a>
  </div>
  <div class="check-sec">
    <div class="col-md-12 cart-items">
      <p>
        我的购物清单 (<span>2</span>)
      </p>
      <script>
	    $(document).ready(function(c) {
		  $('.close1').on('click',function(c) {
			$('.cart-header').fadeOut('slow',function(c) {
			  $('.cart-header').remove();
			});
		  });
	    });
	  </script>
      <div class="cart-header">
        <div class="close1"></div>
        <div class="cart-sec simpleCart_shelfItem">
          <div class="cart-item cyc">
            <img src="${resourcePath}/images/product-15.jpg" class="img-responsive" alt="" />
          </div>
          <div class="cart-item-info">
            <h3>
              <a href="single.html">洋河蓝色经典 天之蓝 46度 480ml 绵柔浓香型</a> <span> </span>
            </h3>
            <ul class="qty">
              <li><p>
                  单价 : <span>2200</span>元
                </p></li>
              <li><p>
                  数量 : <span>1</span>
                </p></li>
            </ul>
            <!-- <div class="delivery">
				 <p>Service Charges : Rs.100.00</p>
				 <span>Delivered in 2-3 bussiness days</span>
				 <div class="clearfix"></div>
			</div> -->
          </div>
          <div class="clearfix"></div>

        </div>
      </div>
      <script>
      $(document).ready(function(c) {
	    $('.close2').on('click', function(c) {
	      $('.cart-header2').fadeOut('slow', function(c) {
	        $('.cart-header2').remove();
	      });
	    });
	  });
      </script>
      <div class="cart-header2">
        <div class="close2"></div>
        <div class="cart-sec simpleCart_shelfItem">
          <div class="cart-item cyc">
            <img src="${resourcePath}/images/product-16.jpg" class="img-responsive" alt="" />
          </div>
          <div class="cart-item-info">
            <h3>
              <a href="single.html">茅台 王子 53度 单瓶装白酒 500ml 口感酱香型</a> <span></span>
            </h3>
            <ul class="qty">
              <li><p>
                  单价 : <span>4000</span>元
                </p></li>
              <li><p>
                  数量 : <span>1</span>
                </p></li>
            </ul>
          </div>
          <div class="clearfix"></div>
        </div>
      </div>
    </div>
    <div class="col-md-12 cart-total">
      <!-- <a class="continue" href="product.html">返回商品页</a> -->
      <div class="price-details">
        <h3>订单总额</h3>
        <span>总价</span> <span class="total1">6200.00</span> <span>折扣</span> <span class="total1">10%(会员价)</span> <span>运送费</span> <span class="total1">150.00</span>
        <div class="clearfix"></div>
      </div>
      <div class="coupons-item">
        <h3>优惠券</h3>
        <p>
          会员积分<span>(当前有1200积分)</span>
        </p>
        <input class="points" type="text" name="100"></input> <a class="cpns btn-sm" href="#">使用积分</a>
      </div>
      <div class="total_price">
        <h3 class="last_price">实际支付</h3>
        <p class="last_price pull-right">
          <span>￥6150.00</span> 元
        </p>
      </div>
      <a class="order" href="#">确认下单</a>
    </div>
    <div class="clearfix"></div>
  </div>
</div>
<!-- //check out -->
