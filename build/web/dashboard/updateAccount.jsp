

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
                            <h2>Sửa Thông Tin Tài Khoản</h2>
                        </div>
                    </div>
                </div>
            </div>
            <div id="editAccountModal">
                <div class="modal-dialog" style="width: 100%">
                    <div class="modal-content">
                        <form id="editAccount" action="editAccount" method="post">
                            <div class="modal-header">
                                <a href="managerAccount">
                                    <button style="position: absolute; right: 20px; top: 20px; color: black" type="button" class="close" data-dismiss="modal" 
                                            aria-hidden="true">&times;
                                    </button> 
                                </a>
                            </div>
                            <div class="modal-body">

                                <div class="form-group">
                                    <label>Tên Tài Khoản</label>
                                    <input value="${user.username}" name="userName" type="text" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>Email</label>
                                    <input value="${user.email}" name="email" type="email" class="form-control" required readonly>
                                </div>
                                <div class="form-group">
                                    <label>Mật khẩu</label>
                                    <input type="password" name="password" class="form-control" placeholder="Nhập mật khẩu mới">
                                </div>

                                <div class="form-group">
                                    <label>Địa Chỉ</label>
                                    <input value="${user.address}" name="address" type="text" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label>Giới Tính</label>
                                    <select name="gender" class="form-control">
                                        <option value="1" ${user.gender ? 'selected' : ''}>Nam</option>
                                        <option value="0" ${!user.gender ? 'selected' : ''}>Nữ</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Số Điện Thoại</label>
                                    <input value="${user.phone}" name="phone" type="text" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label>Vai Trò</label>
                                    <select name="roleId" class="form-control"> <!-- Sửa lại tên thuộc tính -->
                                        <option value="" disabled selected>Chọn vai trò</option>
                                        <option value="3">Admin</option>
                                        <option value="2">Nhân viên</option>
                                        <option value="1">Người dùng</option>
                                    </select>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <a href="managerAccount" class="btn btn-secondary">Trở Lại</a>
                                <input type="submit" class="btn btn-success" value="Cập Nhật">
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
    </body>
</html>