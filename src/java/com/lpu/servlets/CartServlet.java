package com.lpu.servlets;

import java.io.IOException;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "CartServlet", urlPatterns = {"/CartServlet"})
public class CartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Initialize Cart if not exists
        List<Map<String, String>> cart = (List<Map<String, String>>) session.getAttribute("cart");
        if(cart == null) {
            cart = new ArrayList<>();
        }

        String action = request.getParameter("action"); 
        
        if("clear".equals(action)) {
            session.removeAttribute("cart");
            response.sendRedirect("home.jsp");
            return;
        }

        // Add item to cart
        Map<String, String> item = new HashMap<>();
        item.put("id", request.getParameter("id"));
        item.put("name", request.getParameter("name"));
        item.put("price", request.getParameter("price"));
        item.put("qty", request.getParameter("qty"));
        item.put("vendorId", request.getParameter("vendorId"));

        cart.add(item);
        session.setAttribute("cart", cart);
        
        // Redirect back to restaurant page
        String redirect = request.getParameter("redirect");
        response.sendRedirect(redirect);
    }
}