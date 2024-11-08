

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Edit</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link href="../css/style.css" rel="stylesheet" type="text/css"/>
        <style>
            img{
                width: 200px;
                height: 120px;
            }

            select {
                width: 32.3%;
                margin: 0;
                font-size: 100%;
                padding: 5px 10px 5px 10px;
                font-family: Segoe UI, Helvetica, sans-serif;
                border: 1px solid #D0D0D0;
                -webkit-box-sizing: border-box;
                -moz-box-sizing: border-box;
                box-sizing: border-box;
                border-radius: 20px;
                outline: none;
            }
        </style>
    <body>

        <div class="container">
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="row">
                        <div class="col-sm-6">
                            <h2>Sửa Món Ăn </h2>
                        </div>
                        <div class="col-sm-6">
                        </div>
                    </div>
                </div>
            </div>
            <div id="editEmployeeModal">
                <div class="modal-dialog" style="width: 100%">
                    <div class="modal-content">
                        <form id="form" action="editproduct" method="get">
                            <div class="modal-header">						

                                <a href="manager">
                                    <button style="position: absolute; right: 20px; top: 20px; color: black" type="button" class="close" data-dismiss="modal" 
                                            aria-hidden="true">&times;
                                    </button> 
                                </a>
                            </div>
                            <div class="modal-body">					
                                <div class="form-group">
                                    <label>ID món</label> 
                                    <input value="${detail.productId}" name="id" type="text" class="form-control" readonly required>
                                </div> 
                                <div class="form-group">
                                    <label>Tên món ăn</label>
                                    <input value="${detail.productName}" name="name" type="text" class="form-control" required>
                                </div>
                                <div class="form-group" style="display: flex; align-items: center; justify-content: space-between">
                                    <label style="margin-right: 20px">Ảnh</label>
                                    <div>
                                        <c:forEach var="img" items="${detail.img}">
                                            <img style="width: 200px; height: auto; margin-right: 10px;" src="${img}" mutiple>
                                        </c:forEach>
                                    </div>
                                    <input id="imageInput" name="image" type="file" multiple>
                                </div>
                                <div class="form-group">
                                    <label>Giá tiền</label>
                                    <input value="${detail.price}" name="price" type="number" step="0.01" min="0" class="form-control" >
                                </div>
                                <div class="form-group">
                                    <label>Mô tả món ăn</label>
                                    <textarea style="height: 200px" name="describe" class="form-control" required>${detail.description}</textarea>
                                </div>

                                <div class="form-group">
                                    <input type="hidden" id="stringdateolb" value="${detail.releaseDate}">
                                    <label style="margin-bottom: 10px; width: 100%">Ngày tạo món</label>
                                    <input type="date" name="date" value="${detail.releaseDate}" class="form-control" required />
                                </div>


                                <div class="form-group">
                                    <label>Phân loại</label>
                                    <textarea name="category" class="form-control" required>${detail.categoryId}</textarea>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <a href="manageProduct" class="btn btn-secondary">Trở Lại</a>
                                <input  type="submit" class="btn btn-success" value="Sửa">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script src="js/main.js"></script>
        <script src="js/clickevents.js"></script>
        <script src="js/calender.js"></script>
        <script  type="text/javascript">
        </script>
        <script src="https://cdn.ckeditor.com/ckeditor5/39.0.1/classic/ckeditor.js"></script>

        <script>
            ClassicEditor
                    .create(document.querySelector('textarea[name="describe"]'))
                    .catch(error => {
                        console.error(error);
                    });
        </script>
    </body>
</html>