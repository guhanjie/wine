<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="container">
  <ol class="breadcrumb">
    <li><a href="index.html">首页</a></li>
    <li class="active">用户中心</li>
  </ol>
  <div class="container">
    <div class="panel panel-info">
      <div class="panel-heading">
        <h3 class="panel-title">基本信息</h3>
      </div>
      <div class="panel-body">
        <form class="form-horizontal">
          <div class="form-group">
            <label class="col-xs-3 control-label">用户名</label> <label class="col-xs-9 control-label">${user.name}</label>
          </div>
          <div class="form-group">
            <label class="col-xs-3 control-label">用户类型</label> <label class="col-xs-9 control-label"> <c:if test="${user.type == 0}">
                <span class="label label-default">普通用户</span>
              </c:if> <c:if test="${user.type == 1}">
                <span class="label label-warning">会员</span>
              </c:if>

            </label>
          </div>
          <div class="form-group">
            <label class="col-xs-3 control-label">手机号码</label> <label class="col-xs-9 control-label">${user.phone}</label>
          </div>
          <!-- <div class="form-group">
			    <label class="col-xs-3 control-label">收货地址</label>
			  </div> -->
        </form>
      </div>
    </div>
    <div class="panel panel-warning">
      <div class="panel-heading">
        <h3 class="panel-title">会员积分</h3>
      </div>
      <div class="panel-body">
        <form class="form-horizontal">
          <div class="form-group">
            <label class="col-xs-3 control-label">可用积分</label> <label class="col-xs-9 control-label"> <span class="badge badge-success">${user.points}</span>
              <%-- <span class="label label-info text-danger">${user.points}</span> --%>
            </label>
          </div>
        </form>
      </div>
    </div>
    <div class="panel panel-success">
      <div class="panel-heading">
        <h3 class="panel-title">推荐会员</h3>
      </div>
      <div class="panel-body">
        <div class="table-responsive">
          <table class="table table-condensed table-striped">
            <thead>
              <tr>
                <th>#</th>
                <th>用户名</th>
                <th>推荐时间</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="p" items="${promotees}" varStatus="status">
                <tr>
                  <th scope="row">${status.index+1}</th>
                  <td>${p.name}</td>
                  <td><fmt:formatDate type="both" dateStyle="long" timeStyle="long" value="${p.updateTime}" /></td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>
<!---->
<div class="subscribe">
  <div class="container">
    <h3>推荐好友</h3>
    <form>
      <input type="text" class="text" value="Email" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Email';}">
      <!-- <input type="submit" value="立即推荐"/> -->
      <a class="btn" href="${pageContext.request.contextPath}/promote">立即推荐</a>
    </form>
  </div>
</div>
<!---->