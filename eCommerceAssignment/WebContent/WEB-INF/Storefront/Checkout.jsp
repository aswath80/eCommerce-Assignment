<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html lang="en">
<head>
<title>Object Transformer's eCommerce App</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<c:if test="${not empty error}">
			<div class="alert alert-danger alert-dismissible" role="alert">
				<button type="button" class="close" data-dismiss="alert"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<strong>${error}</strong>
			</div>
		</c:if>

		<!-- Page Header -->
		<div class="page-header">
			<div class="row">
				<div class="col-md-4">
					<h2>Storefront: Checkout</h2>
				</div>
			</div>
		</div>
        
        <c:if test="${not empty invalidOrder}">
                <div class="jumbotron">
                    <h3>Invalid Order! Some items are not enough</h3>
                </div>
        </c:if>
            
        <c:choose>
            <c:when test="${not empty orderCompleted}">
                <div class="jumbotron">
                    <h3>Congratulation! your order is completed.</h3>
                    <h3>Your order number is ${orderNumber }</h3>
                </div>
            </c:when>
            <c:when test="${empty sessionScope.cart or fn:length(sessionScope.cart.itemList) eq 0}">
                <div class="jumbotron">
                    <h3>Shopping cart is empty!</h3>
                </div>
            </c:when> 
        </c:choose>

		<c:if
			test="${not empty sessionScope.cart and fn:length(sessionScope.cart.itemList) gt 0}">
			<div class="panel panel-primary">
				<div class="panel-heading">Items In Cart</div>
				<div class="panel-body">
					<table class="table table-hover table-striped table-bordered">
						<thead>
							<tr>
								<th style="text-align: center;">Item Id</th>
								<th style="text-align: center;">Item Name</th>
								<th style="text-align: center;">Item Description</th>
								<th style="text-align: center;">Quantity Ordered</th>
								<th style="text-align: center;">Unit Price</th>
								<th style="text-align: center;">Total Price</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${sessionScope.cart.itemList}" var="cartItem">
								<tr>
									<td>${cartItem.item.id}</td>
									<td>${cartItem.item.name}</td>
									<td>${cartItem.item.description}</td>
									<td>${cartItem.quantityOrdered}</td>
									<td>${cartItem.item.price}</td>
									<td>${cartItem.totalPrice}</td>
								</tr>
							</c:forEach>
							<tr>
								<td colspan="5" style="text-align: right;"><strong>Total
										price</strong></td>
								<td><strong>${sessionScope.cart.totalPrice}</strong></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</c:if>		
		<form class="form-inline" action='Checkout' method='post'>
			<c:if test="${empty orderCompleted}">
	            <div class="form-group">
	                <label for="InputName">Name</label>
	                <input type="text" class="form-control" name="inputName" placeholder="Jane Doe" value="${inputName }">
	                <c:if test="${not empty nameError}">
	                    <br />
	                    <p style='color:#f00;'>Please enter your name and lastname</p>
	                </c:if>
	            </div>
	            
	            
	            <div class="form-group" style="margin-left:45px;">
	                <label for="InputEmail">Email</label>
	                <input type="email" class="form-control" name="inputEmail" placeholder="jane.doe@example.com" value="${inputEmail }">
	                <c:if test="${not empty emailError}">
	                    <br />
	                    <p style='color:#f00;'>Please enter your email</p>
	                 </c:if>
	            </div>
            </c:if>
            <div class="row">
                    <div class="col-md-2 col-md-offset-8">
                        <c:url value="Store" var="url">
                            <c:param name="action" value="itemList" />
                            <c:param name="page" value="${page}" />
                        </c:url>
                        <a class="btn btn-primary" role="button" href="${url}">Continue
                            Shopping</a>
                    </div>
                    <c:if test="${empty orderCompleted}">
                        <button type="submit" class="btn btn-primary">Complete Purchase</button>
                    </c:if>
                </div>
        </form>
	</div>


</body>
</html>