function calculateTotal() {
    var totalPrice = parseFloat(document.getElementById("totalPrice").value);
    var discount = 0;

    var discountSelect = document.getElementById("discountSelect");
    if (discountSelect.value === "discount5000") {
        discount = totalPrice * 0.05; // Giảm 5%
    } else if (discountSelect.value === "discount12000") {
        discount = 12000; // Giảm 12,000 VNĐ
    } else if (discountSelect.value === "discount50000") {
        discount = 50000; // Giảm 50,000 VNĐ
    }

    var shippingCost = 0;
    var shippingMethod = document.querySelector('input[name="shippingMethod"]:checked');
    if (shippingMethod) {
        shippingCost = shippingMethod.value === "nhanh" ? 20000 : 10000; // Cập nhật phí vận chuyển
    }

    var totalAfterDiscount = totalPrice - discount;

    document.getElementById("discountAmount").innerText = discount + " VNĐ";
    document.getElementById("shippingCost").innerText = shippingCost + " VNĐ";

    var finalTotal = totalAfterDiscount + shippingCost;
    document.getElementById("finalTotal").innerText = finalTotal + " VNĐ";

    // Cập nhật giá trị vào input ẩn
    document.getElementById("hiddenTotalPrice").value = finalTotal; // Cập nhật vào trường ẩn
}

// Gắn sự kiện submit cho form
document.querySelector("form").addEventListener("submit", function(event) {
    // Ngăn chặn việc gửi form ngay lập tức
    event.preventDefault();

    // Tính toán tổng trước khi gửi
    calculateTotal();

    // Gửi form
    this.submit(); // Gọi lại để gửi form
});

// Khởi tạo khi tải trang
window.onload = function () {
    calculateTotal(); // Cập nhật tổng tiền ngay khi tải trang
};
