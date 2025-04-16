package com.hds.test;

import com.hds.model.Product;

public class TestProduct {
    public static void main(String[] args) {
        // Create a Product instance with sample values
        Product prod = new Product(101, "Dining Room Light Fixture", 733.0, "https://via.placeholder.com/150");

        // Print out each value
        System.out.println("Product ID: " + prod.getProductId());
        System.out.println("Product Name: " + prod.getProductName());
        System.out.println("Price: $" + prod.getPrice());
        System.out.println("Image URL: " + prod.getImageUrl());
    }
}
