<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/about.css"/>


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

        <div class="about-intro">
            <div class="container">
                <h1>Chào Mừng Đến Với Hikari Sushi</h1>
                <p>Hikari Sushi mang đến cho bạn hương vị ẩm thực Nhật Bản chính thống ngay tại Việt Nam. Với niềm đam mê và tâm huyết, chúng tôi tự hào phục vụ những món ăn tinh tế, độc đáo và đầy cảm xúc, mang đến trải nghiệm ẩm thực không thể nào quên.</p>
            </div>
        </div>

        <div class="video-section">
            <div class="container">
                <div class="row">
                    <div class="col-6">
                        <iframe width="100%" height="400" src="images/about1.mp4" frameborder="0" allowfullscreen></iframe>
                    </div>
                    <div class="col-6">
                        <iframe width="100%" height="400" src="images/about2.mp4" frameborder="0" allowfullscreen></iframe>
                    </div>
                </div>
            </div>
        </div>

<div class="gallery-section">
    <div class="container">
        <div id="galleryCarousel" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <div class="row">
                        <div class="col-md-4 col-sm-6 mb-4">
                            <img src="images/about1.jpg" alt="Món ăn 1" class="img-fluid gallery-img">
                        </div>
                        <div class="col-md-4 col-sm-6 mb-4">
                            <img src="images/about2.jpg" alt="Món ăn 2" class="img-fluid gallery-img">
                        </div>
                        <div class="col-md-4 col-sm-6 mb-4">
                            <img src="images/about3.jpg" alt="Món ăn 3" class="img-fluid gallery-img">
                        </div>
                        <div class="col-md-4 col-sm-6 mb-4">
                            <img src="images/about4.jpg" alt="Món ăn 4" class="img-fluid gallery-img">
                        </div>
                        <div class="col-md-4 col-sm-6 mb-4">
                            <img src="images/about5.jpg" alt="Món ăn 5" class="img-fluid gallery-img">
                        </div>
                        <div class="col-md-4 col-sm-6 mb-4">
                            <img src="images/about6.jpg" alt="Món ăn 6" class="img-fluid gallery-img">
                        </div>
                    </div>
                </div>
                <div class="carousel-item">
                    <div class="row">
                        <div class="col-md-4 col-sm-6 mb-4">
                            <img src="images/about7.jpg" alt="Món ăn 7" class="img-fluid gallery-img">
                        </div>
                        <div class="col-md-4 col-sm-6 mb-4">
                            <img src="images/about8.jpg" alt="Món ăn 8" class="img-fluid gallery-img">
                        </div>
                        <div class="col-md-4 col-sm-6 mb-4">
                            <img src="images/about9.jpg" alt="Món ăn 9" class="img-fluid gallery-img">
                        </div>
                        <div class="col-md-4 col-sm-6 mb-4">
                            <img src="images/about10.jpg" alt="Món ăn 10" class="img-fluid gallery-img">
                        </div>
                        <div class="col-md-4 col-sm-6 mb-4">
                            <img src="images/about11.jpg" alt="Món ăn 11" class="img-fluid gallery-img">
                        </div>
                        <div class="col-md-4 col-sm-6 mb-4">
                            <img src="images/about12.jpg" alt="Món ăn 12" class="img-fluid gallery-img">
                        </div>
                    </div>
                </div>
                <div class="carousel-item">
                    <div class="row">
                        <div class="col-md-4 col-sm-6 mb-4">
                            <img src="images/about13.jpg" alt="Món ăn 13" class="img-fluid gallery-img">
                        </div>
                        <div class="col-md-4 col-sm-6 mb-4">
                            <img src="images/about14.jpg" alt="Món ăn 14" class="img-fluid gallery-img">
                        </div>
                        <div class="col-md-4 col-sm-6 mb-4">
                            <img src="images/about15.jpg" alt="Món ăn 15" class="img-fluid gallery-img">
                        </div>
                        <div class="col-md-4 col-sm-6 mb-4">
                            <img src="images/about16.jpg" alt="Món ăn 16" class="img-fluid gallery-img">
                        </div>
                        <div class="col-md-4 col-sm-6 mb-4">
                            <img src="images/about5.jpg" alt="Món ăn 5" class="img-fluid gallery-img">
                        </div>
                        <div class="col-md-4 col-sm-6 mb-4">
                            <img src="images/about6.jpg" alt="Món ăn 6" class="img-fluid gallery-img">
                        </div>
                    </div>
                </div>
            </div>
            <a class="carousel-control-prev" href="#galleryCarousel" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#galleryCarousel" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
    </div>
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
                            <li><a href="https://www.facebook.com/profile.php?id=61551550319360" target="_blank"><i class="fa-brands fa-facebook"></i></a></li>
                            <li><a href="https://www.instagram.com/neil_kiwi_/" target="_blank"><i class="fa-brands fa-instagram"></i></a></li></br>
                            <li>Gmail : hanh.hiep.777@gmail.com</a></li></br>
                            <li>Số Điện Thoại : 0904034322</li>
                        </ul>
                    </div>
                </div>
                <hr />
            </div>
        </div>

    </body>
</html>
