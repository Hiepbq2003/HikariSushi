package model;

import java.util.Date;

public class Product {
    private int productId;
    private String productName;
    private double price;
    private String img;
    private String description;
    private int quantity;
    private Date releaseDate;
    private float rating;
    private int purchaseCount;
    private Category category;
    public int categoryId;

    public Product() {
    }

    public Product(int productId, String productName, double price, String img, String description, int quantity, 
                   Date releaseDate, float rating, int purchaseCount, Category category, int categoryId) {
        this.productId = productId;
        this.productName = productName;
        this.price = price;
        this.img = img;
        this.description = description;
        this.quantity = quantity;
        this.releaseDate = releaseDate;
        this.rating = rating;
        this.purchaseCount = purchaseCount;
        this.category = category;
        this.categoryId = categoryId;
    }

    // Getter và Setter cho các thuộc tính mới
    public Date getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(Date releaseDate) {
        this.releaseDate = releaseDate;
    }

    public float getRating() {
        return rating;
    }

    public void setRating(float rating) {
        this.rating = rating;
    }

    public int getPurchaseCount() {
        return purchaseCount;
    }

    public void setPurchaseCount(int purchaseCount) {
        this.purchaseCount = purchaseCount;
    }

    // Getter và Setter cho các thuộc tính còn lại
    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
