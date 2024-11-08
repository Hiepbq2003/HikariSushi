package model;

public class Category {
    private int categoryId; // ID của danh mục
    private String categoryName; // Tên của danh mục
    private int productCount; // Số lượng sản phẩm trong danh mục

    // Constructor
    public Category() {
    }

    public Category(int categoryId, String categoryName, int productCount) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.productCount = productCount;
    }

    // Getter và Setter cho categoryId
    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    // Getter và Setter cho categoryName
    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    // Getter và Setter cho productCount
    public int getProductCount() {
        return productCount;
    }

    public void setProductCount(int productCount) {
        this.productCount = productCount;
    }

    @Override
    public String toString() {
        return categoryName + " (" + productCount + ")"; // Định dạng cho tên danh mục
    }
}
