<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="${pageContext.request.contextPath}/resources/js/responsiveslides.min.js"></script>
<script>
	$(function() {
		$("#slider").responsiveSlides({
			auto : true,
			nav : true,
			speed : 500,
			namespace : "callbacks",
			pager : false,
		});
	});
</script>

<!-- slider bar -->
<div class="slider">
  <div class="callbacks_container">
    <ul class="rslides" id="slider">
      <c:forEach  var="bannar" items="${bannars}" varStatus="status">
        <li>
          <div class="banner" style="background-image:url(${pageContext.request.contextPath}/resources/${bannar.img});">
            <div class="banner-info">
              <h3>${bannar.title}</h3>
              <p>${bannar.description}</p>
            </div>
          </div>
        </li>
      </c:forEach>
    </ul>
  </div>
</div>
<!-- //slider bar -->

<!-- items -->
<div class="items">
  <div class="container items-sec">
    <h3>国酒典藏</h3>
    <div class="col-md-3 feature-grid">
      <a href="product.html"><img src="${pageContext.request.contextPath}/resources/images/product-1.jpg" alt="" />
        <div class="arrival-info">
          <h4>泸州老窖 国窖 1573</h4>
          <p class="vip">
            <span>会员价 </span> ￥<em>800</em>元
          </p>
          <p class="normal">
            <span>原价 </span><span class="pric1"> ￥<del>1200</del></span> <span class="disc">[12% Off]</span>
          </p>
        </div> </a>
    </div>
    <div class="col-md-3 feature-grid">
      <a href="product.html"><img src="${pageContext.request.contextPath}/resources/images/product-2.jpg" alt="" />
        <div class="arrival-info">
          <h4>小糊涂仙 浓香型</h4>
          <p class="vip">
            <span>会员价 </span> ￥<em>800</em>元
          </p>
          <p class="normal">
            <span>原价 </span><span class="pric1"> ￥<del>1200</del></span> <span class="disc">[30% Off]</span>
          </p>
        </div> </a>
    </div>
    <div class="col-md-3 feature-grid">
      <a href="product.html"><img src="${pageContext.request.contextPath}/resources/images/product-3.jpg" alt="" />
        <div class="arrival-info">
          <h4>郎酒 红花郎酒</h4>
          <p class="vip">
            <span>会员价 </span> ￥<em>800</em>元
          </p>
          <p class="normal">
            <span>原价 </span><span class="pric1"> ￥<del>1200</del></span> <span class="disc">[30% Off]</span>
          </p>
        </div> </a>
    </div>
    <div class="col-md-3 feature-grid">
      <a href="product.html"><img src="${pageContext.request.contextPath}/resources/images/product-4.jpg" alt="" />
        <div class="arrival-info">
          <h4>茅台 15年贵州茅台酒</h4>
          <p class="vip">
            <span>会员价 </span> ￥<em>800</em>元
          </p>
          <p class="normal">
            <span>原价 </span><span class="pric1"> ￥<del>1200</del></span> <span class="disc">[30% Off]</span>
          </p>
        </div> </a>
    </div>
    <div class="clearfix"></div>
  </div>
  <div class="container items-sec">
    <h3>精美洋酒系列</h3>
    <div class="col-md-3 feature-grid">
      <a href="product.html"><img src="${pageContext.request.contextPath}/resources/images/product-5.jpg" alt="" />
        <div class="arrival-info">
          <h4>巴黎之花 PerrierJouet特级干型香槟</h4>
          <p class="vip">
            <span>会员价 </span> ￥<em>800</em>元
          </p>
          <p class="normal">
            <span>原价 </span><span class="pric1"> ￥<del>1200</del></span> <span class="disc">[30% Off]</span>
          </p>
        </div> </a>
    </div>
    <div class="col-md-3 feature-grid">
      <a href="product.html"><img src="${pageContext.request.contextPath}/resources/images/product-6.jpg" alt="" />
        <div class="arrival-info">
          <h4>长城 干红葡萄酒</h4>
          <p class="vip">
            <span>会员价 </span> ￥<em>800</em>元
          </p>
          <p class="normal">
            <span>原价 </span><span class="pric1"> ￥<del>1200</del></span> <span class="disc">[50% Off]</span>
          </p>
        </div> </a>
    </div>
    <div class="col-md-3 feature-grid">
      <a href="product.html"><img src="${pageContext.request.contextPath}/resources/images/product-7.jpg" alt="" />
        <div class="arrival-info">
          <h4>1664白啤酒</h4>
          <p class="vip">
            <span>会员价 </span> ￥<em>800</em>元
          </p>
          <p class="normal">
            <span>原价 </span><span class="pric1"> ￥<del>1200</del></span> <span class="disc">[50% Off]</span>
          </p>
        </div> </a>
    </div>
    <div class="col-md-3 feature-grid">
      <a href="product.html"><img src="${pageContext.request.contextPath}/resources/images/product-8.jpg" alt="" />
        <div class="arrival-info">
          <h4>Baileys/百利甜酒 爱尔兰甜酒</h4>
          <p class="vip">
            <span>会员价 </span> ￥<em>800</em>元
          </p>
          <p class="normal">
            <span>原价 </span><span class="pric1"> ￥<del>1200</del></span> <span class="disc">[50% Off]</span>
          </p>
        </div> </a>
    </div>
    <div class="clearfix"></div>
  </div>
</div>
<!---->
<div class="offers">
  <div class="container">
    <h3>『 一 · 元 · 购 』</h3>
    <div class="offer-grids">
      <div class="col-md-6">
        <a href="#"><div class="offer-grid">
            <div class="ofr-pic">
              <img src="${pageContext.request.contextPath}/resources/images/offer-1 (2).jpg" class="img-responsive center-block" alt="" />
            </div>
            <div class="ofr-pic-info pull-right text-right">
              <h4>一元抢购 · 经典海之蓝</h4>
              <p class="status">
                已抢购 <span>198</span> 份，<span>98</span> 人参加
              </p>
              <p class="buy">立即抢购</p>
            </div>
            <div class="clearfix"></div>
          </div></a>
      </div>
      <div class="col-md-6">
        <a href="#"><div class="offer-grid">
            <div class="ofr-pic">
              <img src="${pageContext.request.contextPath}/resources/images/offer-8.jpg" class="img-responsive center-block" alt="" />
            </div>
            <div class="ofr-pic-info pull-right text-right">
              <h4>法国精品葡萄酒·一元抢购</h4>
              <p class="status">
                已抢购 <span>198</span> 份，<span>98</span> 人参加
              </p>
              <p class="buy">立即抢购</p>
            </div>
            <div class="clearfix"></div>
          </div></a>
      </div>
      <div class="clearfix"></div>
    </div>
  </div>
</div>
<!---->