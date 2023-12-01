package com.example.product_discount_calculator;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "DisplayDiscount", value = "/display-discount")
public class Discount extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // khi thực hiện request get
        // + gỗ trên đường dẫn ulr
        // + click vào thẻ a
        // + form vơi method get
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // khi nào post chay
        // + form + mehthod
        // lấy dữ liệu từ form
        String description = req.getParameter("describe");
        float price = Float.parseFloat(req.getParameter("price"));
        float percent = Float.parseFloat(req.getParameter("percent"));
        float amount = (float) (percent * price * 0.01);
        float discount_price = price - amount;
        req.setAttribute("amount", amount);
        req.setAttribute("discount_price", discount_price);
        // chuyển hương sang trang result
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("result.jsp");
        requestDispatcher.forward(req, resp);
    }
}
