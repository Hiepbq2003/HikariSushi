<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Thanh toán</title>
        <link rel="stylesheet" type="text/css" href="css/checkout.css">
        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
            integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
            crossorigin="anonymous"
            />
        <script type="text/javascript"
  src="https://cdn.jsdelivr.net/npm/@emailjs/browser@3/dist/email.min.js"></script>
        <script type="text/javascript">
    (function () {
        emailjs.init("hapcW1SqNMCQYSxmN");
      })();
      function sendMail() {
  var params = {
    name: document.getElementById("firstName").value,
    email: document.getElementById("email").value
 
  };

  const serviceID = "service_yifvu0v";
  const templateID = "template_ajnkrea";

    emailjs.send(serviceID, templateID, params)
    .then(res=>{
        document.getElementById("name").value = "";
        document.getElementById("email").value = "";
  
        console.log(res);
       

    })
    .catch(err=>console.log(err));

}
        </script>
    </head>
    <body>

        <h1>Thông tin thanh toán</h1>

        <form action="checkout" method="POST" onsubmit="sendMail(event)">
            <h2>Thông tin cá nhân</h2>
            <label for="firstName">Tên *</label>
            <input type="text" id="firstName" name="firstName" required>

            <label for="lastName">Họ *</label>
            <input type="text" id="lastName" name="lastName" required>

            <label for="company">Tên công ty (tuỳ chọn)</label>
            <input type="text" id="company" name="company">

            <label for="country">Quốc gia/Khu vực *</label>
            <select id="country" name="country" required>
                <option value="Vietnam">Việt Nam</option>
                <option value="Japan">Japan</option>
                <!-- Các quốc gia khác có thể thêm ở đây -->
            </select>

            <label for="address">Địa chỉ *</label>
            <input type="text" id="address" name="address" required>

            <label for="postalCode">Mã bưu điện (tuỳ chọn)</label>
            <input type="text" id="postalCode" name="postalCode">

            <label for="city">Tỉnh / Thành phố *</label>
            <input type="text" id="city" name="city" required>

            <label for="phone">Số điện thoại *</label>
            <input type="tel" id="phone" name="phone" required>

            <label for="email">Địa chỉ email *</label>
            <input type="email" id="email" name="email" required class="form-control">

            <h2>Thông tin bổ sung</h2>
            <label for="orderNotes">Ghi chú đơn hàng (tuỳ chọn)</label>
            <textarea id="orderNotes" name="orderNotes" rows="4" placeholder="Ghi chú về đơn hàng, ví dụ: thời gian hay chỉ dẫn địa điểm giao hàng chi tiết hơn."></textarea>

            <h2>Đơn hàng của bạn</h2>
            <table border="1">
                <tr>
                    <th>Sản phẩm</th>
                    <th>Tạm tính</th>
                </tr>
                <c:choose>
                    <c:when test="${not empty cart}">
                        <c:forEach var="product" items="${cart}">
                            <tr>
                                <td>${product.productName} × ${product.quantity}</td>
                                <td>${product.price * product.quantity} VNĐ</td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="2">Giỏ hàng trống!</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </table>

            <p>Tạm tính: 
                <c:set var="totalPrice" value="0" />
                <c:forEach var="product" items="${cart}">
                    <c:set var="totalPrice" value="${totalPrice + (product.price * product.quantity)}" />
                </c:forEach>
                <input type="hidden" id="totalPrice" value="${totalPrice}" /> <!-- Lưu giá trị tạm tính -->
                ${totalPrice} VNĐ
            </p>

            <h2>Phương thức vận chuyển</h2>
            <label>
                <input type="radio" name="shippingMethod" value="nhanh" onclick="calculateTotal()" required>
                Vận chuyển nhanh (20.000 VNĐ)
            </label><br>

            <label>
                <input type="radio" name="shippingMethod" value="tietkiem" onclick="calculateTotal()" required>
                Vận chuyển tiết kiệm (10.000 VNĐ)
            </label><br>

            <h2>Chọn giảm giá</h2>
            <label for="discountSelect">Chọn mã giảm giá:</label>
            <select id="discountSelect" onchange="calculateTotal()">
                <option value="none">Không có giảm giá</option>
                <option value="discount5000">Giảm 5%</option>
                <option value="discount12000">Giảm 12,000 VNĐ</option>
                <option value="discount50000">Giảm 50,000 VNĐ</option>
            </select>

            <p>Phí vận chuyển: <span id="shippingCost">0 VNĐ</span></p> <!-- Hiển thị phí vận chuyển -->
            <p>Số tiền đã giảm giá: <span id="discountAmount">0 VNĐ</span></p>
            <p>Tổng cộng: <span id="finalTotal">${totalPrice} VNĐ</span></p>
            <input type="hidden" id="hiddenTotalPrice" name="totalPrice" value="${totalPrice}" />
            <br>
            <button id="button" class="btn btn-primary" type="submit" onclick="sendMail()">Đặt hàng</button>
        </form>
            
          <div class="form-group">
    
            <input
                type="hidden" 
              class="form-control"
              id="name"
              placeholder="Enter name"
            />
          </div>
          <div class="form-group">
    
            <input
               type="hidden" 
              class="form-control"
              id="email"
              placeholder="Enter email"
            />
          </div>
     
        <a href="menu" class="link-back" >Quay lại thực đơn</a>
        <script src="js/payment.js"></script>
    </body>
</html>