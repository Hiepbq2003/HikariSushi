package controller;

import dal.ProductDAO;
import dal.UserCartDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import model.Product;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

    private static final String CART_COOKIE_NAME = "cartCookie";
    private static final int COOKIE_MAX_AGE = 60 * 60 * 24 * 7;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        List<Product> cart = (List<Product>) session.getAttribute("cart");

        // Khởi tạo giỏ hàng nếu chưa có
        if (cart == null) {
            cart = new ArrayList<>();
        }

        // Thực hiện hành động theo yêu cầu
        switch (action) {
            case "add":
                addToCart(request, cart);
                break;
            case "update":
                updateCart(request, cart);
                break;
            case "remove":
                removeFromCart(request, cart);
                break;
            default:
                request.setAttribute("errorMessage", "Hành động không hợp lệ.");
                break;
        }

        // Tính toán tổng tiền và phí vận chuyển
        double totalPrice = calculateTotalPrice(cart);
        double shippingCost = calculateShippingCost(request.getParameter("shippingMethod"));
        double discountedPrice = (request.getAttribute("discountedPrice") != null)
                ? (double) request.getAttribute("discountedPrice") : totalPrice;

        double finalTotal = discountedPrice + shippingCost; // Tổng tiền cuối

        // Cập nhật giỏ hàng và thông tin cho request
        session.setAttribute("cart", cart);
        request.setAttribute("cart", cart);
        request.setAttribute("totalPrice", totalPrice);
        request.setAttribute("shippingCost", shippingCost);
        request.setAttribute("finalTotal", finalTotal); // Tổng tiền cuối
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

      private void addToCart(HttpServletRequest request, List<Product> cart) {
    try {
        int productId = Integer.parseInt(request.getParameter("productId"));
        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductById(productId);
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId"); // Lấy userId từ session

        if (product != null) {
            // Kiểm tra xem sản phẩm đã có trong giỏ hàng chưa
            boolean found = false;
            for (Product p : cart) {
                if (p.getProductId() == productId) {
                    p.setQuantity(p.getQuantity() + 1); // Tăng số lượng
                    found = true;
                    break;
                }
            }
            // Nếu sản phẩm chưa có, thêm vào giỏ hàng
            if (!found) {
                
                product.setQuantity(1); // Đặt số lượng sản phẩm mới là 1
                cart.add(product); // Thêm sản phẩm vào giỏ hàng
                
            }

            
            
        } else {
            request.setAttribute("errorMessage", "Sản phẩm không tồn tại.");
        }
    } catch (NumberFormatException e) {
        request.setAttribute("errorMessage", "Mã sản phẩm không hợp lệ.");
    }
}


    private void updateCart(HttpServletRequest request, List<Product> cart) {
        Iterator<Product> iterator = cart.iterator();
        while (iterator.hasNext()) {
            Product product = iterator.next();
            String quantityParam = request.getParameter("quantity_" + product.getProductId());
            if (quantityParam != null) {
                try {
                    int quantity = Integer.parseInt(quantityParam);
                    if (quantity > 0) {
                        product.setQuantity(quantity); // Cập nhật số lượng sản phẩm
                    } else {
                        iterator.remove(); // Nếu số lượng <= 0, xóa sản phẩm khỏi giỏ hàng
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("errorMessage", "Số lượng không hợp lệ cho sản phẩm: " + product.getProductId());
                }
            }
        }
    }

    private void removeFromCart(HttpServletRequest request, List<Product> cart) {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            cart.removeIf(product -> product.getProductId() == productId); // Xóa sản phẩm
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Mã sản phẩm không hợp lệ.");
        }
    }

    // Tính tổng tiền giỏ hàng
    private double calculateTotalPrice(List<Product> cart) {
        double totalPrice = 0;
        for (Product product : cart) {
            totalPrice += product.getPrice() * product.getQuantity();
        }
        return totalPrice;
    }

    // Tính phí vận chuyển dựa trên phương thức
    private double calculateShippingCost(String shippingMethod) {
        if ("nhanh".equals(shippingMethod)) {
            return 20000; // Phí vận chuyển nhanh
        } else if ("tietkiem".equals(shippingMethod)) {
            return 10000; // Phí vận chuyển tiết kiệm
        }
        return 0; // Không có phí vận chuyển
    }

    // Lưu giỏ hàng vào cookie (nếu cần)
    private void saveCartToCookie(HttpServletResponse response, List<Product> cart) {
        StringBuilder cartData = new StringBuilder();
        for (Product product : cart) {
            cartData.append(product.getProductId()).append(":").append(product.getQuantity()).append(",");
        }
        // Xóa dấu phẩy cuối cùng
        if (cartData.length() > 0) {
            cartData.deleteCharAt(cartData.length() - 1);
        }

        Cookie cookie = new Cookie(CART_COOKIE_NAME, cartData.toString());
        cookie.setMaxAge(COOKIE_MAX_AGE); // Thời gian tồn tại cookie
        cookie.setPath("/"); // Đặt đường dẫn để cookie có thể được truy cập từ mọi trang
        response.addCookie(cookie); // Thêm cookie vào response
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chuyển hướng đến trang giỏ hàng
        List<Product> cart = (List<Product>) request.getSession().getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>(); // Khởi tạo giỏ hàng nếu chưa có
        }

        request.setAttribute("cart", cart);
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }
}
