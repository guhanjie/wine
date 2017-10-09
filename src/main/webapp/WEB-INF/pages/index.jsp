<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
      <c:forEach var="bannar" items="${bannars}" varStatus="status">
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
<div class="container-fluid items">
  <c:forEach var="category" items="${indexCategories}" varStatus="status">
    <div class="row items-sec">
      <h3><a href="${pageContext.request.contextPath}/items/${category.id}" >${category.name}</a></h3>
      <c:forEach var="item" items="${indexItems[status.index]}" varStatus="status">
        <div class="col-xs-4 feature-grid">
          <a href="item/${item.id}"><img src="${pageContext.request.contextPath}/resources/${item.icon}" alt="" />
            <div class="arrival-info">
              <h4>${item.name}</h4>
              <p class="normal_price">
                <span>会员价 </span> ￥<em>${item.normalPrice}</em>元
              </p>
              <c:if test="${user.agent}">
                <p class="agent_price">
                  <span>代理价 </span>
                  <span> ￥<em>${item.vipPrice}</em></span>
                  <span class="disc">[<fmt:formatNumber type="percent"
                      maxIntegerDigits="2" value="${item.vipPrice/item.normalPrice}" /> Off]
                  </span>
                </p>
              </c:if>
              <p class="item_sales">
                <span>已销售 </span> <em>${item.sales}</em> 件
              </p>
            </div> </a>
        </div>
      </c:forEach>
      <div class="clearfix"></div>
    </div>
  </c:forEach>
</div>
<!-- //items -->