function addToCart(productId) {
    const userId = getUserId(); // Lấy ID người dùng
    const action = "add"; // Hành động thêm sản phẩm

    fetch('cart', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: `action=${action}&userId=${userId}&productId=${productId}`
    })
    .then(response => {
        if (response.ok) {
            alert('Sản phẩm đã được thêm vào giỏ hàng!');
            updateCartCount(1); // Cập nhật số lượng giỏ hàng
        } else {
            console.error('Có lỗi xảy ra khi thêm sản phẩm: ' + response.statusText);
        }
    })
    .catch(error => {
        console.error('Error:', error);
    });
}

// Hàm xóa sản phẩm khỏi giỏ hàng
function removeFromCart(productId) {
    const userId = getUserId(); // Lấy ID người dùng
    fetch('cart', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: `action=remove&userId=${userId}&productId=${productId}`
    })
    .then(response => {
        if (response.ok) {
            alert('Sản phẩm đã được xóa khỏi giỏ hàng!');
            updateCartCount(-1); // Cập nhật số lượng giỏ hàng
        } else {
            console.error('Có lỗi xảy ra khi xóa sản phẩm: ' + response.statusText);
        }
    })
    .catch(error => {
        console.error('Error:', error);
    });
}

// Cập nhật số lượng giỏ hàng
function updateCartCount(change = 0) {
    const userId = getUserId(); // Lấy ID người dùng
    let currentCount = parseInt(getCookie(`cartCount_${userId}`)) || 0; 
    currentCount += change; // Thay đổi số lượng
    currentCount = Math.max(currentCount, 0); // Đảm bảo không âm

    setCookie(`cartCount_${userId}`, currentCount, 7); // Cập nhật cookie

    // Cập nhật số lượng trên giao diện
    const cartCountElement = document.querySelector('.cart-count');
    if (cartCountElement) {
        cartCountElement.textContent = currentCount; // Cập nhật số lượng
    } else {
        console.error('Không tìm thấy phần tử hiển thị số lượng giỏ hàng.');
    }
}

// Hàm thanh toán
function doPayment() {
    fetch('cart', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: 'action=payment'
    })
    .then(response => {
        if (response.ok) {
            location.href = 'checkout.jsp'; // Chuyển đến trang thanh toán
        } else {
            alert('Có lỗi xảy ra khi thanh toán: ' + response.statusText);
        }
    })
    .catch(error => {
        console.error('Error:', error);
    });
}

// Đặt cookie
function setCookie(name, value, days) {
    const d = new Date();
    d.setTime(d.getTime() + (days * 24 * 60 * 60 * 1000)); // Tính toán thời gian hết hạn
    const expires = `expires=${d.toUTCString()}`;
    document.cookie = `${name}=${value};${expires};path=/`; // Đặt cookie
}

// Lấy giá trị cookie
function getCookie(name) {
    const nameEQ = `${name}=`;
    const ca = document.cookie.split(';');
    for (let i = 0; i < ca.length; i++) {
        let c = ca[i].trim(); // Xóa khoảng trắng
        if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length, c.length); // Trả về giá trị
    }
    return "0"; // Trả về 0 nếu không tìm thấy
}

// Lấy ID người dùng
function getUserId() {
    return getCookie("userId") || "defaultUser"; // Nếu không tìm thấy, sử dụng giá trị mặc định
}

// Cập nhật số lượng giỏ hàng khi trang được tải
document.addEventListener('DOMContentLoaded', function () {
    loadCart(); // Tải giỏ hàng khi trang được tải
});

// Hàm tải giỏ hàng từ cơ sở dữ liệu
function loadCart() {
    const userId = getUserId(); // Lấy ID người dùng
    fetch(`cart?userId=${userId}`, {
        method: 'GET'
    })
    .then(response => {
        if (response.ok) {
            return response.json(); // Giả sử máy chủ trả về một mảng các sản phẩm trong giỏ
        } else {
            throw new Error('Không thể lấy giỏ hàng: ' + response.statusText);
        }
    })
    .then(cart => {
        let totalQuantity = 0;
        cart.forEach(item => {
            totalQuantity += item.quantity; // Cộng dồn số lượng sản phẩm
        });
        updateCartCount(totalQuantity); // Cập nhật số lượng giỏ hàng
    })
    .catch(error => {
        console.error('Error:', error);
    });
}

// Hàm xử lý khi người dùng đăng nhập thành công
function onLoginSuccess() {
    loadCart(); // Tải giỏ hàng cho người dùng khi đăng nhập thành công
}
