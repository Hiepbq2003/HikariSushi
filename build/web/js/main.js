// Lấy các mục menu
const menuItems = document.querySelectorAll('.menu li');
const action = document.getElementById('action');

// Thiết lập ban đầu của thanh #action
if (menuItems.length > 0) {
    action.style.width = menuItems[0].offsetWidth + 'px';
    action.style.left = menuItems[0].offsetLeft + 'px';
}

// Thêm sự kiện hover cho từng mục menu
menuItems.forEach(item => {
    item.addEventListener('mouseover', () => {
        // Di chuyển thanh #action tới mục đang hover
        action.style.width = item.offsetWidth + 'px';
        action.style.left = item.offsetLeft + 'px';

        // Thay đổi màu chữ của mục đang hover
        menuItems.forEach(li => li.classList.remove('active'));
        item.classList.add('active');
    });
});

let currentSlide = 0;

function moveCarousel(direction) {
    const productContainer = document.querySelector('.product-container');
    const products = document.querySelectorAll('.product');
    const totalProducts = products.length;

    currentSlide += direction;

    // Kiểm tra ranh giới
    if (currentSlide < 0) {
        currentSlide = totalProducts - 1;
    } else if (currentSlide >= totalProducts) {
        currentSlide = 0;
    }

    // Di chuyển sản phẩm
    const offset = -currentSlide * 220; // Kích thước sản phẩm + margin
    productContainer.style.transform = `translateX(${offset}px)`;
    
}

