<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- <link href="<c:url value="/resources/css/css/form.css" />" rel="stylesheet" type="text/css" media="all" /> --%>
<link href="<c:url value="/resources/css/flexslider.css" />" rel="stylesheet" type="text/css" media="screen" />

<!-- item -->
<ol class="breadcrumb">
  <li><a href="<c:url value="/index"/>">首页</a></li>
  <li>积分秒杀活动</li>
</ol>
<!--breadcrumb//-->
<div class="product">
  <div class="container">
    <div class="product-price1">
      <h4>${item.name}</h4>
      <div class="top-sing">
        <div class="col-md-12 single-top">
          <div class="flexslider">
            <ul class="slides">
              <c:forTokens items="${item.titleImgs}" delims="," var="titleImg">
                <li data-thumb="${pageContext.request.contextPath}/resources/${titleImg}">
                  <div class="thumb-image">
                    <img src="${pageContext.request.contextPath}/resources/${titleImg}" data-imagezoom="true" class="img-responsive" alt="" />
                  </div>
                </li>
              </c:forTokens>
            </ul>
          </div>
          <script src="${pageContext.request.contextPath}/resources/js/imagezoom.js"></script>
          <script defer src="${pageContext.request.contextPath}/resources/js/jquery.flexslider.js"></script>
          <script>
  			// Can also be used with $(document).ready()
  			$(window).load(function() {
  				$('.flexslider').flexslider({
  					animation : "slide",
  					controlNav : "thumbnails"
  				});
  			});
  		  </script>
        </div>
        <div class="col-md-5 single-top-in simpleCart_shelfItem">
          <div data-id="${item.id}" data-price="${item.vipPrice}" class="single-para product-item">
            <div class="relative">
              <span class="hidden item_itemid">${item.id}</span>
              <span class="hidden item_name">${item.name}</span>
              <span class="hidden item_type">rush</span>
              <span class="hidden item_img">${pageContext.request.contextPath}/resources/${item.icon}</span>
              <h5 class="item_price">￥ ${item.vipPrice}</h5>
              <p class="pric1 normal-price">
                原价 <del class="item_normalprice">${item.normalPrice}</del>
              </p>
              <a href="#" class="buy-now item_add rush">立即抢购</a>
            </div>
            <div class="clear-fix"></div>
            <p class="item_sales">
              <span>已销售 </span> <em>${item.counts}</em> <span> ，剩余可购 </span> <em class="item_limits">${1000-item.counts}</em> 
            </p>
            <div class="prdt-info-grid">
              『 秒 · 杀 · 专 · 区 』活动说明：<br/>
              <ul>
                <li>- 用户使用积分，下单购买本活动的相应份额；</li>
                <li>- 购得一份额后，会随机获得一个3位数的随机号码；</li>
                <li>- 当达成活动总份额时开奖，最终拥有中奖号码的用户购得此活动商品。</li>
                <li>- 为保证本活动公开透明，采用福彩3D中奖号码作为活动参考开奖号码，</li>
                <li>- 开奖号码日期确定为当活动份额达成当日的后一天的福彩3D中奖号码。</li>
              </ul>
            </div>
          </div>
        </div>
        <div class="clearfix"></div>
      </div>
      <section>
        <c:forTokens items="${item.detailImgs}" delims="," var="detailImg">
          <img src="${pageContext.request.contextPath}/resources/${detailImg}" class="img-responsive" alt="">
        </c:forTokens>
      </section>
    </div>
  </div>
</div>
<!---->