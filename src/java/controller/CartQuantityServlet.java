package controller;

import dal.UserCartDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.BufferedReader;

@WebServlet("/cart-quantity")
public class CartQuantityServlet extends HttpServlet {
    private UserCartDAO userCartDAO = new UserCartDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        int totalQuantity = 0;

        if (userId != null) {
            totalQuantity = userCartDAO.getTotalQuantityByUserId(userId); // Hàm này bạn cần thêm trong UserCartDAO
        }

        response.setContentType("application/json");
        response.getWriter().write("{\"totalQuantity\":" + totalQuantity + "}");
    }
}



