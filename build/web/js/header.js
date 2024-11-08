function showProfileMessage() {
    const profileMessage = document.querySelector('.profile-message');
    profileMessage.style.display = 'block'; // Hiển thị thông báo
}

function hideProfileMessage() {
    const profileMessage = document.querySelector('.profile-message');
    profileMessage.style.display = 'none'; // Ẩn thông báo
}

document.addEventListener("DOMContentLoaded", function() {
    fetch('/cart-quantity')
        .then(response => response.json())
        .then(data => {
            document.querySelector(".cart-count").textContent = data.totalQuantity; // Sửa lại ở đây
        })
        .catch(error => console.error("Error fetching cart quantity:", error));
});
