package com.example.java_web.repositoryes;

import com.example.java_web.models.Product;

import java.util.ArrayList;
import java.util.List;

public class ProductRepository implements IProductRepository {
    private static List<Product> list = new ArrayList<>();
    static {
        list.add(new Product(1, "Ngũ cốc", 10, "Lương thực", "Ruộng"));
        list.add(new Product(2, "Dầu", 10, "Rất nhiều", "Nhà máy"));
        list.add(new Product(3, "Thép", 15, "Vật liệu", "Quặng"));
        list.add(new Product(4, "Khoáng sản", 30, "Tài nguyên quý hiếm", "Mỏ"));
    }

    @Override
    public List<Product> getList() {
        return list;
    }

    @Override
    public void add(Product product) {
        list.add(product);
    }

    @Override
    public void edit(int id, Product product) {
        list.add(id,product);
    }

    @Override
    public void delete(int id) {
        list.remove(id);
    }

    @Override
    public List<Product> search(String name) {
        return null;
    }
}
