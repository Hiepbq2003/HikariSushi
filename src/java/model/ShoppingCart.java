package model;

import java.util.ArrayList;
import java.util.List;

public class ShoppingCart {
    private List<CartItem> items; // Danh sách sản phẩm trong giỏ hàng

    public ShoppingCart() {
        items = new ArrayList<>();
    }

    // Thêm sản phẩm vào giỏ hàng
    public void addProduct(Product product, int quantity) {
        // Kiểm tra nếu sản phẩm đã có trong giỏ hàng
        for (CartItem item : items) {
            if (item.getProduct().getProductId() == product.getProductId()) {
                // Nếu sản phẩm đã tồn tại, cộng thêm số lượng
                item.setQuantity(item.getQuantity() + quantity);
                return;
            }
        }
        // Nếu sản phẩm chưa tồn tại, thêm mới vào giỏ hàng
        items.add(new CartItem(product, quantity));
    }

    // Lấy danh sách sản phẩm trong giỏ hàng
    public List<CartItem> getItems() {
        return items;
    }

    // Tính tổng giá trị giỏ hàng
    public double getTotalPrice() {
        double total = 0;
        for (CartItem item : items) {
            total += item.getProduct().getPrice() * item.getQuantity();
        }
        return total;
    }

    // Xóa sản phẩm khỏi giỏ hàng
    public void removeProduct(int productId) {
        items.removeIf(item -> item.getProduct().getProductId() == productId);
    }

    // Lớp lồng để lưu thông tin sản phẩm và số lượng
    private static class CartItem {
        private Product product;
        private int quantity;

        public CartItem(Product product, int quantity) {
            this.product = product;
            this.quantity = quantity;
        }

        public Product getProduct() {
            return product;
        }

        public int getQuantity() {
            return quantity;
        }

        public void setQuantity(int quantity) {
            this.quantity = quantity;
        }
    }
}
