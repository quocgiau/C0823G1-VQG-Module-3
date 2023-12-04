package com.example.customer;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet(name = "CustomerServlet", value = "/customer-servlet")
public class CustomerServlet extends HttpServlet {
    private static List<Customer> list = new ArrayList<>();

    static {
        list.add(new Customer(1,"Mai Văn Hoàn", "1983/08/20", "Hà nội", "https://testerhn.com/files/assets/tuan_anh_pm.jpg"));
        list.add(new Customer(2,"Nguyễn Văn Nam", "1983/08/21", "Bắc Giang", "https://testerhn.com/files/assets/tuan_anh_pm.jpg"));
        list.add(new Customer(3,"Nguyễn Thái Hoà", "1983/08/22", "Nam Định", "https://testerhn.com/files/assets/tuan_anh_pm.jpg"));
        list.add(new Customer(4,"Trần Đăng Khoa", "1983/08/17", "Hà Tây", "https://testerhn.com/files/assets/tuan_anh_pm.jpg"));
        list.add(new Customer(5,"Nguyễn Đình Thi", "1983/08/19", "Hà nội", "https://testerhn.com/files/assets/tuan_anh_pm.jpg"));
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("list", list);
        req.getRequestDispatcher("/index.jsp").forward(req, resp);
    }
}
