<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<ol class="breadcrumb">
  <li><a href="${pageContext.request.contextPath}/index.html">首页</a></li>
  <li class="active">我的购物车</li>
</ol>
<div class="container">
  <!-- check out -->
  <div class="my-cart">
    <div class="check-nav">
      <a class="back-buy" href="${pageContext.request.contextPath}/index">返回商品页</a>
      <a class="simpleCart_empty" href="javascript:;">清空购物车</a>
    </div>
    <div class="check-sec row">
      <div class="col-xs-12 cart-items">
        <p>
          我的购物清单 (<span id="simpleCart_quantity" class="simpleCart_quantity"></span>)
        </p>
        <div class="simpleCart_items"></div>
      </div>
      <div class="col-xs-12 cart-total">
        <!-- <a class="continue" href="product.html">返回商品页</a> -->
        
        <div class="price-details">
          <h3>订单总额</h3>
          <div>
            <span>总价</span> <span class="total1"><span class="simpleCart_total"></span>元</span>
          </div>
          <div class="coupons-discount">
            <span class="cpns">会员积分（扣减）</span> <span class="total1 "><span class="delcpns"></span>元</span>
          </div>
          <div>
            <span>会员折扣（已省）</span> <span class="total1"><del class="simpleCart_discount"></del>元</span>
          </div>
          <div>
            <span class="shipType">
              <label class="radio-inline">
                <input type="radio" name="shipType" id="shipType2" value="2" checked> 同城快送
              </label>
              <label class="radio-inline">
                <input type="radio" name="shipType" id="shipType1" value="1"> 快递
              </label>
            </span> 
            <span class="total1"><span class="simpleCart_shipping"></span>元</span>
          </div>
          <div class="clearfix"></div>
        </div>
        
        <div class="coupons-item">
          <h3>优惠券</h3>
          <p>
            会员积分<span>(当前有<strong>${user.points!=null ? user.points : 0}</strong>积分)
            </span>
          </p>
          <input class="points" type="number" min="0" max="${user.points}"></input> <a class="cpns btn-sm" href="javascript:;">使用积分</a>
        </div>
        <div class="owner-info">
          <h3>收件人信息</h3>
          <div class="weui-cell">
            <div class="weui-cell__hd">
              <label class="weui-label">联系人</label>
            </div>
            <div class="weui-cell__bd">
              <input id="order-contactor" class="weui-input" type="text" value="${user.name}" placeholder="请输入联系人名字">
            </div>
          </div>
          <div class="weui-cell">
            <div class="weui-cell__hd">
              <label class="weui-label">联系电话</label>
            </div>
            <div class="weui-cell__bd">
              <input id="order-phone" class="weui-input" type="number" pattern="[0-9]*" value="${user.phone}" placeholder="请输入手机号码">
            </div>
          </div>
          <div class="weui-cell">
            <div class="weui-cell__hd">
              <label class="weui-label">收货地址</label>
            </div>
            <div class="weui-cell__bd">
              <input id="order-address" class="weui-input" type="text" value="${user.address}" placeholder="请输入收货地址">
            </div>
          </div>
        </div>
        <div class="total_price">
          <h3 class="last_price">实际支付</h3>
          <p class="last_price pull-right">
            <span class="simpleCart_all"></span> 元
          </p>
        </div>
		<c:if test="${cartType=='rush'}">
		  <input type="hidden" name="sourceType" id="sourceType" value="rush" />
		  <script>ships = 0;</script>
		</c:if>
        <a class="order btn" id="submit" href="javascript:;">确认下单</a>
      </div>
      <div class="clearfix"></div>
    </div>
  </div>
  <!-- //check out -->

  <!-- pay msg -->
  <div class="pay-msg" style="display: none;">
    <div class="check-nav">
      <a class="back-buy" href="${pageContext.request.contextPath}/index">返回商品页</a>
      <a class="go-order-list" href="${pageContext.request.contextPath}/order/list" >前往订单中心</a>
    </div>
    <div class="pay weui-msg weixin_pay">
      <div class="weui-msg__icon-area">
        <i class="weui-icon-success weui-icon_msg"></i>
      </div>
      <div class="weui-msg__text-area">
        <h2 class="weui-msg__title">订单支付</h2>
        <p class="weui-msg__desc">请您完成支付，如果商城给您最好的商品和服务！</p>
        <div class="weui-cells order-item">
          <div class="weui-cell">
            <div class="weui-cell__hd">
              <p>
                <i class="weui-icon-success-circle"></i>订单金额：
              </p>
            </div>
            <div class="weui-cell__bd">
              <span id="res_amount" class="text-red"></span>
            </div>
          </div>
        </div>
      </div>
      <div class="weui-msg__opr-area">
        <p class="weui-btn-area">
          <a href="javascript:;" class="weui-btn weui-btn_primary order-pay">微信支付</a>
        </p>
        <a class="btn_back" href="#">返回订单列表</a>
      </div>
      <div class="weui-msg__extra-area"></div>
    </div>
  </div>
  <!-- //pay msg -->
</div>