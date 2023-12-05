package com.example.java_web.services;

import com.example.java_web.models.Product;

import java.util.List;

public interface IProductService {
    List<Product> getList();
    void add(Product product);
    void edit(int id, Product product);
    void delete(int id);
    List<Product> search(String name);
}
