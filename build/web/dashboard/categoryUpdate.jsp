

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
        </style>
    <body>
        <div class="container">
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="row">
                        <div class="col-sm-6">
                            <h2>Sửa <b>Phân Loại</b> </h2>
                        </div>
                        <div class="col-sm-6">
                        </div>
                    </div>
                </div>
            </div>
            <div id="editEmployeeModal">
                <div class="modal-dialog" style="width: 100%">
                    <div class="modal-content">
                        <form action="updateCategory" method="post">
                            <div class="modal-header">						
                                <h4 class="modal-title">Sửa phân loại sản phẩm</h4>
                                <a href="managersupplier">
                                    <button style="position: absolute; right: 20px; top: 20px; color: black" type="button" class="close" data-dismiss="modal" 
                                            aria-hidden="true">&times;
                                    </button> 
                                </a>
                            </div>
                            <div class="modal-body">					
                                <div class="form-group">
                                    <label>ID</label> 
                                    <input value="${detail.categoryId}" name="id" type="text" class="form-control" readonly required>
                                </div> 
                                
                                <div class="form-group">
                                    <label>Tên sản phẩm</label>
                                    <input value="${detail.categoryName}" name="cName" type="text" class="form-control" >
                                </div>
                                
                            </div>
                            <div class="modal-footer">
                                <input type="submit" class="btn btn-success" value="Sửa">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        
        <script  type="text/javascript">
        </script>
    </body>
</html>