<%@ page import="model.Product" %>
<%@ page import="dao.ProductDAO" %>
<%
    int productId = Integer.parseInt(request.getParameter("id"));
    ProductDAO productDAO = new ProductDAO();
    Product product = productDAO.getProductById(productId);
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles/style.css">
    <title>S?a S?n Ph?m</title>
</head>
<body>
    <h1>S?a S?n Ph?m</h1>
    <form action="EditProductServlet" method="post">
        <input type="hidden" name="productId" value="<%= product.getProductId() %>">
        
        <label for="productName">Tên s?n ph?m:</label>
        <input type="text" name="productName" value="<%= product.getProductName() %>" required>
        
        <label for="price">Giá:</label>
        <input type="number" name="price" value="<%= product.getPrice() %>" required>
        
        <label for="imagePath">???ng d?n hình ?nh:</label>
        <input type="text" name="imagePath" value="<%= product.getImagePath() %>" required>
        
        <button type="submit">C?p nh?t</button>
    </form>
    <a href="product.jsp">Quay l?i</a>
</body>
</html>
