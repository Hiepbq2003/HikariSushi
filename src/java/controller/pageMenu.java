package controller;

import dal.CategoryDAO;
import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import model.Category;
import model.Product;

import java.io.IOException;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

@WebServlet(name = "menu", urlPatterns = {"/menu"})
public class pageMenu extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int page = 1;
        int size = 12; // Số sản phẩm trên mỗi trang

        // Lấy tham số trang từ request
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1; // Nếu tham số không hợp lệ, trả về trang 1
            }
        }

        // Lấy tất cả danh mục
        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> categories = categoryDAO.getAllCategories();

        // Xử lý categoryId từ request
        String categoryIdParam = request.getParameter("categoryId");
        int categoryId = (categoryIdParam != null && !categoryIdParam.isEmpty()) ? Integer.parseInt(categoryIdParam) : 0;

        // Xử lý giá từ request
        Double minPrice = null;
        Double maxPrice = null;
        String minPriceParam = request.getParameter("minPrice");
        String maxPriceParam = request.getParameter("maxPrice");

        if (minPriceParam != null && !minPriceParam.isEmpty()) {
            minPrice = Double.parseDouble(minPriceParam);
        }
        if (maxPriceParam != null && !maxPriceParam.isEmpty()) {
            maxPrice = Double.parseDouble(maxPriceParam);
        }

        // Xử lý sắp xếp
        ProductDAO productDao = new ProductDAO();
        List<Product> productList = productDao.getProductsByCategoryAndPrice(categoryId, minPrice, maxPrice);

        // Xử lý sắp xếp
        String sortOrder = request.getParameter("sortOrder");
        if ("asc".equals(sortOrder)) {
            // Sắp xếp tăng dần theo giá
            Collections.sort(productList, Comparator.comparing(Product::getPrice));
        } else if ("desc".equals(sortOrder)) {
            // Sắp xếp giảm dần theo giá
            Collections.sort(productList, Comparator.comparing(Product::getPrice).reversed());
        }

        // Tính tổng số sản phẩm và số trang
        int totalProducts = productList.size();
        int totalPages = (int) Math.ceil((double) totalProducts / size);

        // Đảm bảo trang hiện tại nằm trong giới hạn
        page = Math.max(1, Math.min(page, totalPages));

        // Lấy sản phẩm cho trang hiện tại
        int start = (page - 1) * size;
        int end = Math.min(start + size, totalProducts);
        List<Product> currentProductsForPage = productList.subList(start, end);

        // Tính toán thống kê
        double maxPriceStat = productList.stream().mapToDouble(Product::getPrice).max().orElse(0);
        double minPriceStat = productList.stream().mapToDouble(Product::getPrice).min().orElse(0);
        double avgPriceStat = productList.stream().mapToDouble(Product::getPrice).average().orElse(0);
        double sumPriceStat = productList.stream().mapToDouble(Product::getPrice).sum();
        long countStat = productList.size();

        // Đặt các thuộc tính cho request
        request.setAttribute("productList", currentProductsForPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("categories", categories);
        request.setAttribute("selectedCategoryId", categoryId); // Lưu lại categoryId để hiển thị

        // Đưa các thống kê vào request
        request.setAttribute("maxPrice", maxPriceStat);
        request.setAttribute("minPrice", minPriceStat);
        request.setAttribute("avgPrice", avgPriceStat);
        request.setAttribute("sumPrice", sumPriceStat);
        request.setAttribute("count", countStat);

        // Chuyển tiếp tới trang menu.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("menu.jsp");
        dispatcher.forward(request, response);
    }
}
