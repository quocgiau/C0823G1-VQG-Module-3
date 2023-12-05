package com.example.java_web.services;

import com.example.java_web.models.Product;
import com.example.java_web.repositoryes.*;

import java.util.List;

public class ProductService implements IProductService{
    private static IProductRepository repository = new ProductRepository();
    @Override
    public List<Product> getList() {
        return repository.getList();
    }

    @Override
    public void add(Product product) {
        repository.add(product);
    }

    @Override
    public void edit(int id, Product product) {
        repository.edit(id,product);
    }

    @Override
    public void delete(int id) {
        repository.delete(id);
    }

    @Override
    public List<Product> search(String name) {
        return repository.search(name);
    }
}
