<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="ISO-8859-1">
        <title>Statistic</title>
        <link rel="icon" href="images/logo1.png"/>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta http-equiv="x-ua-compatible" content="ie=edge">


        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"
              integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link href="css/manager.css" rel="stylesheet" type="text/css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"
              integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css"/>
        <!-- Google Fonts Roboto -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap"/>
        <!-- MDB -->
        <link rel="stylesheet" href="css/mdb.min.css"/>
        <!-- Custom styles -->
        <link rel="stylesheet" href="css/style.css"/>

        <style>
            body {
                margin: 0;
                padding: 0;
            }
        </style>
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"><link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&amp;display=swap"><link rel="stylesheet" type="text/css" href="https://mdbootstrap.com/wp-content/themes/mdbootstrap4/css/mdb5/3.8.1/compiled.min.css"><link rel="stylesheet" type="text/css" href="https://mdbootstrap.com/wp-content/themes/mdbootstrap4/css/mdb-plugins-gathered.min.css"><style>body {
                background-color: #fbfbfb;
            }
            @media (min-width: 991.98px) {
                main {
                    padding-left: 240px;
                }
            }
            .text_page_head{
                font-size: 18px;
                font-weight: 600;
            }
            .text_page {
                font-size: 14px;
                font-weight: 600;
            }

            /* Sidebar */
            .sidebar {
                position: fixed;
                top: 0;
                bottom: 0;
                left: 0;
                padding: 58px 0 0; /* Height of navbar */
                box-shadow: 0 2px 5px 0 rgb(0 0 0 / 5%), 0 2px 10px 0 rgb(0 0 0 / 5%);
                width: 240px;
                z-index: 600;
            }

            @media (max-width: 991.98px) {
                .sidebar {
                    width: 100%;
                }
            }
            .sidebar .active {
                border-radius: 5px;
                box-shadow: 0 2px 5px 0 rgb(0 0 0 / 16%), 0 2px 10px 0 rgb(0 0 0 / 12%);
            }

            .sidebar-sticky {
                position: relative;
                top: 0;
                height: calc(100vh - 48px);
                padding-top: 0.5rem;
                overflow-x: hidden;
                overflow-y: auto; /* Scrollable contents if viewport is shorter than content. */
            }</style>
    </head>
    <body>

        <!--Main Navigation-->
        <header>
            <jsp:include page="leftadmin.jsp"></jsp:include>
            </header>
        <jsp:include page="header_right.jsp"></jsp:include>
            <!--Main Navigation-->

            <main>
                <div class="container pt-4">
                    <section class="mb-4">
                        <div class="card">
                            <div class="card-header py-3">
                                <h3 class="mb-0 text-center"><strong>Thống kê sản phẩm</strong></h3>
                            </div>

                            <div class="card-body">
                                <!-- Buttons for Product Statistics -->
                                <div class="text-center mb-3">
                                    <form action="ProductStatistic" method="GET">

                                    <c:set var="selectedCategory" value="${param.categoryId}" />

                                    <select name="categoryId" id="categoryId">
                                        <option value="1" ${selectedCategory == '1' ? 'selected' : ''}>Danh mục 1</option>
                                        <option value="2" ${selectedCategory == '2' ? 'selected' : ''}>Danh mục 2</option>
                                        <option value="3" ${selectedCategory == '3' ? 'selected' : ''}>Danh mục 3</option>
                                        <option value="4" ${selectedCategory == '4' ? 'selected' : ''}>Danh mục 4</option>
                                        <option value="5" ${selectedCategory == '5' ? 'selected' : ''}>Danh mục 5</option>
                                        <option value="6" ${selectedCategory == '6' ? 'selected' : ''}>Danh mục 6</option>
                                        <!-- Thêm các danh mục khác ở đây -->
                                    </select>
                                    <div class="form-group">
                                        <label for="price">Giá:</label>
                                        <input type="number" name="price" id="price" placeholder="Nhập giá" class="form-control">
                                    </div>

                                    <!-- Thêm nút chọn sắp xếp tăng/giảm dần -->
                                    <div class="form-group">
                                        <label for="sortOrder">Thứ tự sắp xếp:</label>
                                        <select name="sortOrder" id="sortOrder" class="form-control">
                                            <option value="asc">Tăng dần</option>
                                            <option value="desc">Giảm dần</option>
                                        </select>
                                    </div>
                                    <button class="btn btn-info" name="sortBy" value="price">Xếp theo giá</button>
                                    <button class="btn btn-info" name="sortBy" value="Rating">Xếp theo đánh giá</button>
                                    <button class="btn btn-info" name="sortBy" value="purchase_count">Số lượt mua</button>
                                    <button class="btn btn-info" name="sortBy" value="releaseDate">Ngày ra mắt</button>
                                </form>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-hover text-nowrap">
                                    <thead>
                                        <tr>
                                            <th class="text_page_head">tên món</th>
                                            <th class="text_page_head">phân loại</th>
                                            <th class="text_page_head">lợi nhuận</th>
                                            <th class="text_page_head">đánh giá</th>
                                            <th class="text_page_head">lượt mua</th>
                                            <th class="text_page_head">Ngày ra mắt</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- Iterate through the products list based on chosen statistic type -->
                                        <c:forEach items="${product}" var="product">
                                            <tr>
                                                <td class="text_page">${product.productName}</td>
                                                <td class="text_page">${product.categoryId}</td>
                                                <td class="text_page">${product.price}</td>
                                                <td class="text_page">${product.rating}</td>
                                                <td class="text_page">${product.purchaseCount}</td>
                                                <td class="text_page">${product.releaseDate}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </section>
            </div>

        </main>



        <script src="js/manager.js" type="text/javascript"></script>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <!--Main layout-->
        <!-- SCRIPTS -->
        <!-- JQuery -->
        <script src="https://mdbootstrap.com/previews/ecommerce-demo/js/jquery-3.4.1.min.js"></script>
        <!-- Bootstrap tooltips -->
        <script type="text/javascript" src="https://mdbootstrap.com/previews/ecommerce-demo/js/popper.min.js"></script>
        <!-- Bootstrap core JavaScript -->
        <script type="text/javascript" src="https://mdbootstrap.com/previews/ecommerce-demo/js/bootstrap.js"></script>
        <!-- MDB core JavaScript -->
        <script type="text/javascript" src="https://mdbootstrap.com/previews/ecommerce-demo/js/mdb.min.js"></script>
        <!-- MDB Ecommerce JavaScript -->
        <script type="text/javascript" src="https://mdbootstrap.com/previews/ecommerce-demo/js/mdb.ecommerce.min.js"></script>
        <!-- MDB -->
        <script type="text/javascript" src="js/mdb.min.js"></script>
        <!-- Custom scripts -->
        <script type="text/javascript" src="js/script.js"></script>
        <%--    <script src="https://mdbootstrap.com/api/snippets/static/download/MDB5-Free_3.8.1/js/mdb.min.js">--%>

    </script><script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js"></script>


    <script type="text/javascript" src="https://mdbootstrap.com/wp-content/themes/mdbootstrap4/js/plugins/mdb-plugins-gathered.min.js"></script>
    <!-- MDB -->
    <script type="text/javascript" src="js/mdb.min.js"></script>
    <!-- Custom scripts -->
    <script type="text/javascript" src="js/script.js"></script>
</body>
</html>