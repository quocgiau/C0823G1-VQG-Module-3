package com.example.java_web.controllers;

import com.example.java_web.models.Product;
import com.example.java_web.services.IProductService;
import com.example.java_web.services.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ProductServlet", value = "/product-servlet")
public class ProductServlet extends HttpServlet {
    private static IProductService service = new ProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "show":
                showForm(req, resp);
                break;
            default:
                showList(req, resp);
        }
    }

    private static void showList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> list = service.getList();
        req.setAttribute("list", list);
        req.getRequestDispatcher("index.jsp").forward(req, resp);
    }

    private static void showForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("result.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create":
                addProduct(req, resp);
                break;
            case "delete":
                deleteProduct(req,resp);
                break;
            case "update":
                editProduct(req,resp);
                break;
        }
    }

    public void addProduct(HttpServletRequest req, HttpServletResponse resp) {
        int id = inputId();
        String name = req.getParameter("name");
        double price = Double.parseDouble(req.getParameter("price"));
        String describe = req.getParameter("describe");
        String producer = req.getParameter("producer");
        service.add(new Product(id, name, price, describe, producer));
        try {
            resp.sendRedirect("/product-servlet");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public int inputId() {
        int count = 0;
        List<Product> employeeList = service.getList();
        for (Product employee : employeeList) {
            count = employee.getId();
        }
        return count + 1;
    }
    public static void deleteProduct(HttpServletRequest req, HttpServletResponse resp){
        int id = Integer.parseInt(req.getParameter("id"));
        service.delete(id);
        try {
            resp.sendRedirect("/product-servlet");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    public static void editProduct(HttpServletRequest req, HttpServletResponse resp){
        int id = Integer.parseInt(req.getParameter("id"));
    }
}
