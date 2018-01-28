<%@ page  contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="t" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>管理控制台</title>
    <!-- 引入 WeUI -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/weui-1.1.2.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.css" media="all"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/app-order.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/app-admin.css"/>
    <script src="${pageContext.request.contextPath}/resources/js/jquery-1.11.3.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/weui-1.1.2.js"> </script>
    <script src="${pageContext.request.contextPath}/resources/js/mustache.min.js"> </script>
</head>
<body ontouchstart>
<p id="bear"></p>
<div class="weui-tab" id="tab">
    <div class="weui-navbar">
        <div class="weui-navbar__item">商品管理</div>
        <div class="weui-navbar__item">订单管理</div>
        <div class="weui-navbar__item">会员管理</div>
        <div class="weui-navbar__item">会员列表</div>
    </div>
    <div class="weui-tab__panel">
        <div class="weui-tab__content">
            <div id="item-list">
              <div class="weui-cells__title">管理后台--商品列表</div>
              <div class="weui-grids"></div>
              <a id="add-item" class="weui-footer_fixed-bottom weui-btn weui-btn_primary">添加商品</a>
            </div>
            <div id="item-form">
                <div class="weui-cells__title">
                  <span>管理后台--商品信息</span>
                  <a href="javascript:;" class="back-item-list">返回列表</a>
                </div>
                <div class="weui-cells weui-cells_form">
                    <div class="weui-cell">
                        <div class="weui-cell__hd"><label class="weui-label">商品名称</label></div>
                        <div class="weui-cell__bd">
                            <input class="weui-input" type="text" name="name" required maxlength="100" placeholder="输入商品名称" emptyTips="请输入商品名称" notMatchTips="商品名称不超过100字">
                        </div>
                        <div class="weui-cell__ft">
                            <i class="weui-icon-warn"></i>
                        </div>
                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__hd"><label class="weui-label">详情描述</label></div>
                        <div class="weui-cell__bd">
                           <textarea class="weui-textarea" name="detail" required maxlength="200" rows="3" placeholder="请输入商品详情描述"></textarea>
                           <div class="weui-textarea-counter">
                               <span id="detail_count">0</span>/200
                           </div>
                        </div>
                        <div class="weui-cell__ft">
                            <i class="weui-icon-warn"></i>
                        </div>
                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__hd"><label class="weui-label">商品类目</label></div>
                        <div class="weui-cell__bd">
                            <input class="weui-input" type="text" id="category" name="categoryId" required placeholder="选择商品类目" emptyTips="请选择商品类目" notMatchTips="选择合适的商品类目">
                        </div>
                        <div class="weui-cell__ft">
                            <i class="weui-icon-warn"></i>
                        </div>
                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__hd"><label class="weui-label">会员价格</label></div>
                        <div class="weui-cell__bd">
                            <input class="weui-input" type="number" name="normalPrice" required pattern="^\d+(\.\d+)?$" maxlength="10" placeholder="输入普通价格" emptyTips="请输入普通价格" notMatchTips="普通价格只能输入数字">
                        </div>
                        <div class="weui-cell__ft">
                            <i class="weui-icon-warn"></i>
                            <span class="price">元</span>
                        </div>
                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__hd"><label class="weui-label">代理价格</label></div>
                        <div class="weui-cell__bd">
                            <input class="weui-input" type="number" name="vipPrice" required pattern="^\d+(\.\d+)?$" maxlength="10" placeholder="输入会员价格" emptyTips="请输入会员价格" notMatchTips="会员价格只能输入数字">
                        </div>
                        <div class="weui-cell__ft">
                            <i class="weui-icon-warn"></i>
                            <span class="price">元</span>
                        </div>
                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__hd"><label class="weui-label">商品销量</label></div>
                        <div class="weui-cell__bd">
                            <input class="weui-input" type="number" name="sales" pattern="^\d+$" maxlength="10" placeholder="输入商品销量" emptyTips="请输入商品销量" notMatchTips="商品销量只能输入数字">
                        </div>
                        <div class="weui-cell__ft">
                            <i class="weui-icon-warn"></i>
                        </div>
                    </div>
                </div> 
                <div class="weui-cells__title">商品图片</div>
                <div class="weui-cells weui-cells_form">
                    <div class="weui-cell" id="icon_imgs-uploader">
                        <div class="weui-cell__bd">
                            <div class="weui-uploader">
                                <div class="weui-uploader__hd">
                                    <p class="weui-uploader__title">商品缩略图</p>
                                    <div class="weui-uploader__info"><span id="iconImgsCount">0</span>/1</div>
                                </div>
                                <div class="weui-uploader__bd">
                                    <ul class="weui-uploader__files" id="iconImgsFiles"></ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="icon" class="weui-uploader__input" type="file" accept="image/*" capture="camera"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="weui-cell" id="title_imgs-uploader">
                        <div class="weui-cell__bd">
                            <div class="weui-uploader">
                                <div class="weui-uploader__hd">
                                    <p class="weui-uploader__title">商品预览图片</p>
                                    <div class="weui-uploader__info"><span id="titleImgsCount">0</span>/6</div>
                                </div>
                                <div class="weui-uploader__bd">
                                    <ul class="weui-uploader__files" id="titleImgsFiles"></ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="titleImgs" class="weui-uploader__input" type="file" accept="image/*" capture="camera" multiple="multiple"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="weui-cell" id="detail_imgs-uploader">
                        <div class="weui-cell__bd">
                            <div class="weui-uploader">
                                <div class="weui-uploader__hd">
                                    <p class="weui-uploader__title">商品详情图片</p>
                                    <div class="weui-uploader__info"><span id="detailImgsCount">0</span>/20</div>
                                </div>
                                <div class="weui-uploader__bd">
                                    <ul class="weui-uploader__files" id="detailImgsFiles"></ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="detailImgs" class="weui-uploader__input" type="file" accept="image/*" capture="camera" multiple="multiple"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="weui-cells__title">商品状态</div>
                <div class="weui-cells weui-cells_form">
                    <div class="weui-cell weui-cell_switch">
                        <div class="weui-cell__bd">商品上架</div>
                        <div class="weui-cell__ft">
                            <input class="weui-switch" name="state" checked="" type="checkbox">
                        </div>
                    </div>
                </div>
                <div class="weui-btn-area">
                    <a id="formSubmitBtn" href="javascript:" class="weui-btn weui-btn_primary">提交</a>
                </div>
            </div>
        </div>
        <div class="weui-tab__content">
          <div class="order-list">
            <div class="weui-cells__title">管理后台--订单列表</div>
            <div class="weui-cells weui-cells_access"></div>
            <div class="pagenation"></div>
          </div>
        </div>
        <div class="weui-tab__content">
          <div class="weui-cells__title">管理后台--用户信息</div>
          <div class="weui-search-bar" id="user-searchBar">
              <form class="weui-search-bar__form">
                  <div class="weui-search-bar__box">
                      <i class="weui-icon-search"></i>
                      <input type="search" class="weui-search-bar__input" placeholder="可输入用户名或手机号或用户id" required="">
                      <a href="javascript:" class="weui-icon-clear"></a>
                  </div>
                  <label class="weui-search-bar__label">
                      <i class="weui-icon-search"></i>
                      <span>用户搜索</span>
                  </label>
              </form>
              <a href="javascript:" class="weui-search-bar__search-btn">查询</a>
              <a href="javascript:" class="weui-search-bar__cancel-btn">取消</a>
          </div>
          <div id="user-form">
              <div class="weui-cells weui-cells_form">
                  <div class="weui-cell">
                      <div class="weui-cell__hd"><label class="weui-label">用户名</label></div>
                      <div class="weui-cell__bd">
                          <input class="weui-input" type="text" name="name" disabled>
                      </div>
                      <div class="weui-cell__ft">
                          <i class="weui-icon-warn"></i>
                      </div>
                  </div>
                  <div class="weui-cell">
                      <div class="weui-cell__hd"><label class="weui-label">手机号码</label></div>
                      <div class="weui-cell__bd">
                          <input class="weui-input" type="text" name="phone" disabled>
                      </div>
                      <div class="weui-cell__ft">
                          <i class="weui-icon-warn"></i>
                      </div>
                  </div>
                  <div class="weui-cell">
                      <div class="weui-cell__hd"><label class="weui-label">用户积分</label></div>
                      <div class="weui-cell__bd">
                          <input class="weui-input" type="number" name="points" disabled>
                      </div>
                      <a href="javascript:;" id="modifyPoints" class="hide weui-btn weui-btn_mini weui-btn_primary">修改</a>
                      <a href="javascript:;" id="submitPoints" class="hide weui-btn weui-btn_mini weui-btn_primary">提交</a>
                      <a href="javascript:;" id="cancelPoints" class="hide weui-btn weui-btn_mini weui-btn_default">取消</a>
                      <div class="weui-cell__ft">
                          <i class="weui-icon-warn"></i>
                      </div>
                  </div>
                  <div class="weui-cell weui-cell_switch">
                      <div class="weui-cell__hd"><label class="weui-label">用户类型</label></div>
                      <div class="weui-cell__bd text-center">
                        <input id="user-normal" class="weui-input" type="text" style="display:none" value="普通会员" disabled>
                        <input id="user-vip" class="weui-input" type="text" style="display:none" value="代理商" disabled>
                      </div>
                      <div class="weui-cell__ft">
                          <input id="user-type" class="weui-switch" type="checkbox">
                      </div>
                  </div>
              </div>
              <div class="item">
                  <p class="item__title bg-success">推广人列表<span class="promotees"></span></p>
                  <div class="table-responsive promotees_list">
                  </div>
              </div>
          </div>
        </div>
        <div class="weui-tab__content">
            <div class="item">
                <p class="item__title bg-success">代理商</p>
                <div class="table-responsive">
                  <table class="table table-condensed table-striped">
                    <thead>
                      <tr>
                        <th>ID</th>
                        <th>用户名</th>
                        <th>积分</th>
                        <th>电话</th>
                        <th>注册时间</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="nu" items="${agentUsers}" varStatus="status">
                        <tr>
                          <th scope="row">${nu.id}</th>
                          <td>${nu.name}</td>
                          <td>${nu.points}</td>
                          <td>${nu.phone}</td>
                          <td><fmt:formatDate type="BOTH" value="${nu.createTime}" /></td>
                        </tr>
                      </c:forEach>
                    </tbody>
                  </table>
                </div>
            </div>
            <div class="item">
                <p class="item__title bg-info">普通会员</p>
                <div class="table-responsive">
                  <table class="table table-condensed table-striped">
                    <thead>
                      <tr>
                        <th>ID</th>
                        <th>用户名</th>
                        <th>积分</th>
                        <th>电话</th>
                        <th>注册时间</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="nu" items="${normalUsers}" varStatus="status">
                        <tr>
                          <th scope="row">${nu.id}</th>
                          <td>${nu.name}</td>
                          <td>${nu.points}</td>
                          <td>${nu.phone}</td>
                          <td><fmt:formatDate type="BOTH" value="${nu.createTime}" /></td>
                        </tr>
                      </c:forEach>
                    </tbody>
                  </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/resources/js/app-admin.js"> </script>
<script src="${pageContext.request.contextPath}/resources/js/app-order.js"> </script>
<script id="order-template" type="x-tmpl-mustache">
{{#orders}}
<a class="weui-cell order-item" data-id="{{id}}" href="#pay">
  <div class="weui-cell__hd"></div>
  <div class="weui-cell__bd weui-cell_primary">
    <div class="weui-uploader">
      <div class="weui-uploader__hd weui-cell"></div>
      <div class="weui-uploader__bd">
        <ul class="weui-uploader__files">
          {{#itemList}}
          <li class="weui-uploader__file" 
            style="background-image: url(/wine/resources/{{icon}}); background-size: 79px 79px; background-position: top left">
            <div class="item_count">{{count}}</div>
            <span style="position: absolute; top: 110px;">{{name}}</span>
          </li>
          {{/itemList}}
        </ul>
      </div>
    </div>
    <p>订单ID： <span id="start_time" class="text-blue">{{id}}</span></p>
    <p>支付金额：<span id="amount" class="text-red">{{payAmount}}</span> 元</p>
    <div class="order-detail">
      <p>使用积分：<span id="coupons" class="text-blue">{{coupons}}</span> 分</p>
      <p>配送方式：<span>{{fmtShipType}}</span></p>
      <p>联系人：{{contactor}}</p>
      <p>联系电话：<span>{{phone}}</span></p>
      <p>收货地址：{{address}}</p>
      <!--<p class="text-red">快递单号：<span class="text-red">{{address}}</span></p>-->
      <p>创建时间：<span id="start_time">{{fmtCreateTime}}</span></p>
      <p>备注：{{remark}}</p>
    </div>
  </div>
  <div class="weui-cell__ft">{{{fmtStatus}}}</div>
</a>
{{/orders}}
</script>
</body>
</html>