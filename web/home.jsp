<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/home.css"/>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" />

        <!-- Fonts -->
        <link href="https://fonts.googleapis.com" rel="preconnect">
        <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&family=Inter:wght@100;200;300;400;500;600;700;800;900&family=Amatic+SC:wght@400;700&display=swap" rel="stylesheet">

    </head>
    <body>

        <jsp:include page="headerNoLogin.jsp"/>

        <div class="video-container">
            <video autoplay muted loop>
                <source src="images/video.mp4" type="video/mp4">
            </video>
            <div class="overlay-text" id="dynamic-text">
                <h2>BEST QUALITY OMAKASE</h2>
                <p>The fresh fish comes from Ha Noi Every Week!</p>
            </div>
        </div>



        <div class="container">
            <h1 class="text-center my-4">Chào mừng đến với Nhà hàng Sushi</h1>
            <img src="images/gt.png" width="500px" height="400px" alt="alt" id="gt"/>
            <p>
                Tại Hikari Sushi, đồ ăn của chúng tôi được chế biến bởi các đầu bếp lành nghề và giàu kinh nghiệm, được làm từ những nguyên liệu tươi ngon, được chọn lọc và phục vụ với mức giá hợp lý cho khách hàng.
                Khu vực ăn uống của chúng tôi được trang bị quầy salad tươi miễn phí cũng như khu vực và thực đơn dành cho trẻ em, nhằm mang đến cho khách hàng trải nghiệm ăn uống gia đình thú vị hơn!
                Chúng tôi tự hào mang đến cho khách hàng không chỉ là bữa ăn, mà còn là trải nghiệm văn hóa ẩm thực Nhật Bản.
            </p>
            <p>
                Với sự đa dạng trong thực đơn và không gian thoải mái, chúng tôi sẵn sàng phục vụ mọi bữa ăn, từ bữa trưa đơn giản đến bữa tối cao cấp dành cho những dịp đặc biệt.
            </p>

            <!-- Hình ảnh sushi nổi bật -->
            <div class="row">
                <div class="col-md-4">
                    <img src="images/home1.jpg" alt="Sushi Tươi" class="img-fluid img-zoom rounded-image" />
                    <h3>Đại tiệc món ngon</h3>
                    <p>Thưởng thức những loại sushi tươi ngon nhất từ các nguyên liệu chất lượng cao.</p>
                </div>
                <div class="col-md-4">
                    <img src="images/home2.jpg" alt="Combo Đặc Biệt" class="img-fluid img-zoom rounded-image" />
                    <h3>Đại tiệc linh đình</h3>
                    <p>Cùng lưu lại những bức hình đăng face với các góc ảnh thật chill, trong không gian được thiết kế theo lối kiến trúc Nhật cổ điển, tinh tế.</p>
                </div>
                <div class="col-md-4">
                    <img src="images/home3.png" alt="Sashimi Đặc Biệt" class="img-fluid img-zoom rounded-image" />
                    <h3>Phòng riêng và trang trọng</h3>
                    <p>Nhà hàng luôn tự hào mang đến cho thực khách một không gian yên tĩnh và ấm cúng cùng những món ăn thật say đắm lòng người.</p>
                </div>
            </div>
            <hr style="height: 1px;background:  black;">
        </div>


        <!-- Nhóm sản phẩm nổi bật theo rating 4.6 trở lên -->
        <h2>SẢN PHẨM NỔI ĐÁNH GIÁ CAO NHÂT</h2>
        <div id="featuredProductsCarousel" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner">
                <c:if test="${not empty featuredProductsRating}">
                    <c:forEach var="product" items="${featuredProductsRating}" varStatus="status">
                        <c:if test="${status.index % 4 == 0}">
                            <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                                <div class="product-container row">
                                </c:if>
                                <div class="col-md-3 col-sm-6 mb-4">
                                    <div class="product-item">
                                        <img src="${product.img}" alt="${product.productName}" class="img-fluid">
                                        <h3>${product.productName}</h3>
                                    </div>
                                </div>
                                <c:if test="${(status.index + 1) % 4 == 0 || status.index + 1 == featuredProductsRating.size()}">
                                </div> <!-- Đóng product-container -->
                            </div> <!-- Đóng carousel-item -->
                        </c:if>
                    </c:forEach>
                </c:if>
                <c:if test="${empty featuredProductsRating}">
                    <div class="carousel-item active">
                        <div class="product-container">
                            <p>No featured products available.</p>
                        </div>
                    </div>
                </c:if>
            </div>
            <a class="carousel-control-prev" href="#featuredProductsCarousel" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#featuredProductsCarousel" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
        <button class="view-all" onclick="window.location.href = 'menu?category=featuredRating'">Xem tất cả</button>
        <hr style="height: 1px;background:  black;">

        <!-- Nhóm sản phẩm nổi bật theo purchase_count (top 10) -->
        <h2>SẢN PHẨM MUA NHIỀU NHẤT</h2>
        <div id="topPurchaseCarousel" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner">
                <c:if test="${not empty topPurchaseProducts}">
                    <c:forEach var="product" items="${topPurchaseProducts}" varStatus="status">
                        <c:if test="${status.index % 4 == 0}">
                            <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                                <div class="product-container row">
                                </c:if>
                                <div class="col-md-3 col-sm-6 mb-4">
                                    <div class="product-item">
                                        <img src="${product.img}" alt="${product.productName}" class="img-fluid">
                                        <h3>${product.productName}</h3>
                                    </div>
                                </div>
                                <c:if test="${(status.index + 1) % 4 == 0 || status.index + 1 == topPurchaseProducts.size()}">
                                </div> <!-- Đóng product-container -->
                            </div> <!-- Đóng carousel-item -->
                        </c:if>
                    </c:forEach>
                </c:if>
                <c:if test="${empty topPurchaseProducts}">
                    <div class="carousel-item active">
                        <div class="product-container">
                            <p>No featured products available.</p>
                        </div>
                    </div>
                </c:if>
            </div>
            <a class="carousel-control-prev" href="#topPurchaseCarousel" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#topPurchaseCarousel" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
        <button class="view-all" onclick="window.location.href = 'menu?category=topPurchased'">Xem tất cả</button>
        <hr style="height: 1px;background:  black;">

        <!-- Nhóm sản phẩm mới nhất (top 10) -->
        <h2>SẢN PHẨM MỚI NHẤT</h2>
        <div id="newestProductsCarousel" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner">
                <c:if test="${not empty newestProducts}">
                    <c:forEach var="product" items="${newestProducts}" varStatus="status">
                        <c:if test="${status.index % 4 == 0}">
                            <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                                <div class="product-container row">
                                </c:if>
                                <div class="col-md-3 col-sm-6 mb-4">
                                    <div class="product-item">
                                        <img src="${product.img}" alt="${product.productName}" class="img-fluid">
                                        <h3>${product.productName}</h3>
                                    </div>
                                </div>
                                <c:if test="${(status.index + 1) % 4 == 0 || status.index + 1 == newestProducts.size()}">
                                </div> <!-- Đóng product-container -->
                            </div> <!-- Đóng carousel-item -->
                        </c:if>
                    </c:forEach>
                </c:if>
                <c:if test="${empty newestProducts}">
                    <div class="carousel-item active">
                        <div class="product-container">
                            <p>No featured products available.</p>
                        </div>
                    </div>
                </c:if>
            </div>
            <a class="carousel-control-prev" href="#newestProductsCarousel" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#newestProductsCarousel" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
        <button class="view-all" onclick="window.location.href = 'menu?category=newest'">Xem tất cả</button>
        <hr style="height: 1px;background:  black;">



        <!--Dich vu noi bat-->
        <div class="dv">
            <h2>Dịch Vụ Nổi Bật</h2>

            <div class="row">
                <div class="col-md-6">
                    <h4>Giao Hàng Tận Nơi</h4>
                    <p>
                        Dù bạn ở đâu, chúng tôi vẫn mang đến những món sushi tươi ngon và đầy đủ hương vị đến tận nhà bạn. Dịch vụ giao hàng nhanh chóng và tiện lợi, giúp bạn thưởng thức món ăn tuyệt hảo mọi lúc, mọi nơi.
                    </p>
                    <video autoplay muted loop >
                        <source src="images/dv.mp4" type="video/mp4" >
                    </video>
                </div>
                <div class="col-md-6">
                    <img src="images/dv123.jpg" alt="Hình ảnh giao hàng tận nơi" class="service-img">
                    <h4>Đặt Bàn Trực Tuyến</h4>
                    <p>
                        Đặt bàn trực tuyến giúp bạn nhanh chóng chọn chỗ ngồi yêu thích, đảm bảo trải nghiệm ẩm thực thoải mái mà không phải chờ đợi. Đặt ngay hôm nay để tận hưởng không gian sang trọng và món ăn đẳng cấp tại nhà hàng của chúng tôi.
                    </p>
                    <div class="button-container">
                        <a href="menu" class="menu-button">Xem Thực Đơn</a>
                        <a class="call-button" style="color: white;">SĐT: 0904034322</a>
                        <a href="https://maps.app.goo.gl/VVe98VkJ2tZvzyRRA" target="_blank" class="location-button">Địa Chỉ</a>
                    </div>
                </div>
            </div>
        </div>


        <!--scroll-->
        <div class="scroll-down">
            <a href="#footer">&#8595;</a>
        </div>

        <!-- Footer -->
        <div class="footer">
            <div class="container">
                <div class="row">
                    <div class="footer-col-1">
                        <h3>Giờ Hoạt Động</h3>
                        <p>THỨ 2 - THỨ 7 : 11:00 AM - 10:00 PM</p>
                        <p>CHỦ NHẬT : 11:00 AM - 9:30 PM</p>
                        <img src="images/Hikari sushi logo white.png" width="300px" height="150px" alt="alt"/>
                    </div>

                    <div class="footer-col-2">
                        <h3>Địa Chỉ</h3>
                        <iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d878.9154256880357!2d105.5199199341659!3d21.004144548371816!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31345b975c8eb30d%3A0x970dd8ffd8f1de29!2zTmjDoCBIw6BuZyBHw6AgUmkgUGjDuiBCw6xuaCAy!5e0!3m2!1svi!2s!4v1728432167384!5m2!1svi!2s" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                    </div>


                    <div class="footer-col-4">
                        <h3>Liên Hệ</h3>
                        <ul>
                            <li><a href="https://www.facebook.com/HikariSushi.20" target="_blank"><i class="fa-brands fa-facebook"></i></a></li>
                            <li><a href="https://www.instagram.com/hikarisushiofficial/?hl=en" target="_blank"><i class="fa-brands fa-instagram"></i></a></li></br>
                            <li>Gmail : hanh.hiep.777@gmail.com</a></li></br>
                            <li>Số Điện Thoại : 0904034322</li>
                        </ul>
                    </div>

                </div>

                <hr />

            </div>
        </div>



        <a href="#" id="scroll-top" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>
        <div id="preloader"></div>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="vendor/php-email-form/validate.js"></script>
        <script src="vendor/aos/aos.js"></script>
        <script src="vendor/glightbox/js/glightbox.min.js"></script>
        <script src="vendor/purecounter/purecounter_vanilla.js"></script>
        <script src="vendor/swiper/swiper-bundle.min.js"></script>

        <script src="js/main.js"></script>

    </body>

</html>
