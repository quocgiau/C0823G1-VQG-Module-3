package com.example.java_web.repositoryes;

import com.example.java_web.models.Product;

import java.util.List;

public interface IProductRepository {
    List<Product> getList();
    void add(Product product);
    void edit(int id, Product product);
    void delete(int id);
    List<Product> search(String name);
}
