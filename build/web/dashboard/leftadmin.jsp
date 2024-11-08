<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Sidebar -->
<nav id="sidebarMenu" class="collapse d-lg-block sidebar collapse bg-black" style="padding: 0px; width: 270px; background-color: black">
    <div class="position-sticky" >
        <div class="list-group list-group-flush mx-3 mt-4" style="margin: 0">
            <div class="footer_logo" style="text-align: center; margin-bottom: 0">
                <a href="home"><img src="images/Hikari sushi logo white.png" alt="Logo" style="height: 53px"></a>
            </div>
            <a href="dashBoard" class="list-group-item list-group-item-action" aria-current="true" style="margin-top: 10px;">
                <i style="margin-right: 10px; font-size: 18px" class="fas fa-tachometer-alt fa-fw me-3"></i>
                <span style="font-size: 16px; font-weight: 600">Bảng điều khiển</span>
            </a>
            
            <a href="monthlyrevenue" class="list-group-item list-group-item-action" style="margin-top: 10px">
                <i style="margin-right: 10px; font-size: 18px" class="fa-solid fa-chart-gantt"></i></i>
                <span style="font-size: 16px; font-weight: 600">Lợi nhuận tháng</span>
            </a>
            
            <a href="weekrevenue" class="list-group-item list-group-item-action" style="margin-top: 10px">
                <i style="margin-right: 10px; font-size: 18px" class="fas fa-chart-pie fa-fw me-3"></i>
                <span style="font-size: 16px; font-weight: 600">Lợi nhuận tuần</span>
            </a>
            
            <a href="orderManager" class="list-group-item list-group-item-action" style="margin-top: 10px">
                <i style="margin-right: 10px; font-size: 18px" class="fas fa-file-invoice-dollar fa-fw me-3"></i>
                <span style="font-size: 16px; font-weight: 600">Chi tiết đơn đặt hàng</span></a>
            <a href="managerAccount" class="list-group-item list-group-item-action" style="margin-top: 10px">
                <i style="margin-right: 10px; font-size: 18px" class="fas fa-user-circle fa-fw me-3"></i>
                <span style="font-size: 16px; font-weight: 600">Quản lý tài khoản</span>
            </a>
            
            <a href="manageProduct" class="list-group-item list-group-item-action" style="margin-top: 10px">
                <i style="margin-right: 10px; font-size: 18px" <i class="fa-solid fa-cart-shopping"></i>
                <span style="font-size: 16px; font-weight: 600">Quản lý sản phẩm</span>
            </a>
            <a href="manageCategory" class="list-group-item list-group-item-action" style="margin-top: 10px">
                <i style="margin-right: 10px; font-size: 18px" class="fas fa-parachute-box fa-fw me-3"></i>
                <span style="font-size: 16px; font-weight: 600">Quản lý phân loại</span>
            </a>
            <a href="ProductStatistic" class="list-group-item list-group-item-action" style="margin-top: 10px">
                <i style="margin-right: 10px; font-size: 18px" class="fa-solid fa-utensils"></i>
                <span style="font-size: 16px; font-weight: 600">Thống kê Sản phẩm</span>
            </a>
   
        </div>
    </div>
</nav>