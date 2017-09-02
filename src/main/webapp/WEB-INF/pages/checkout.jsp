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
        我的购物清单 (<span id="simpleCart_quantity" class="simpleCart_quantity"></span>)
      </p>
      <div class="simpleCart_items"></div>
    </div>
    <div class="col-md-12 cart-total">
      <!-- <a class="continue" href="product.html">返回商品页</a> -->
      <div class="price-details">
        <h3>订单总额</h3>
        <div><span>总价</span> <span class="total1"><span class="simpleCart_total"></span>元</span></div>
        <div><span>会员折扣（已省）</span> <span class="total1"><del class="simpleCart_discount"></del>元</span></div>
        <div class="coupons-discount"><span class="cpns">会员积分（扣减）</span> <span class="total1 "><span class="delcpns"></span>元</span></div>
        <div><span>运送费</span> <span class="total1"><span class="simpleCart_shipping"></span>元</span></div>
        <div class="clearfix"></div>
      </div>
      <div class="coupons-item">
        <h3>优惠券</h3>
        <p>会员积分<span>(当前有<strong>1200</strong>积分)</span></p>
        <input class="points" type="number"></input> 
        <a class="cpns btn-sm" href="javascript:;">使用积分</a>
      </div>
      <div class="owner-info">
        <h3>收件人信息</h3>
        <div class="weui_cell">
            <div class="weui_cell_hd"><label class="weui_label">联系人</label></div>
            <div class="weui_cell_bd weui_cell_primary">
                <input class="weui_input" type="text" value="${user.name}" placeholder="请输入联系人名字">
            </div>
        </div>
        <div class="weui_cell">
            <div class="weui_cell_hd"><label class="weui_label">联系电话</label></div>
            <div class="weui_cell_bd weui_cell_primary">
                <input class="weui_input" type="number" pattern="[0-9]*" value="${user.phone}" placeholder="请输入手机号码">
            </div>
        </div>
        <div class="weui_cell">
            <div class="weui_cell_hd"><label class="weui_label">收货地址</label></div>
            <div class="weui_cell_bd weui_cell_primary">
                <input class="weui_input" type="text" value="${user.address}" placeholder="请输入收货地址">
            </div>
        </div>
        <!-- <div>
        <label class="">收货人</<label>
        <input class="contactor " type="text"> 
        </div>
        <div>
        <label class="">联系电话</label>
        <input class="phone " type="text"> 
        </div>
        <div>
        <label class="">收货地址</label>
        <input class="address " type="text"> 
        </div> -->
      </div>
      <div class="total_price">
        <h3 class="last_price">实际支付</h3>
        <p class="last_price pull-right">
          <span class="simpleCart_all"></span> 元
        </p>
      </div>
      <a class="order btn" id="submit-order" href="javascript:;">确认下单</a>
    </div>
    <div class="clearfix"></div>
  </div>
</div>
<!-- //check out -->