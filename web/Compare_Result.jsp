<%-- 
    Document   : Compare_Result
    Created on : Jan 3, 2025, 6:16:43 PM
    Author     : FAQIHAH
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Product Comparison</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="card shadow">
            <div class="card-header bg-primary text-white">
                <h3>Product Comparison</h3>
            </div>
            <div class="card-body">
                <%
                    String product1Name = (String) request.getAttribute("product1_name");
                    String product1Ingredients = (String) request.getAttribute("product1_ingredients");
                    String product1Benefits = (String) request.getAttribute("product1_benefits");

                    String product2Name = (String) request.getAttribute("product2_name");
                    String product2Ingredients = (String) request.getAttribute("product2_ingredients");
                    String product2Benefits = (String) request.getAttribute("product2_benefits");

                    String errorMessage = (String) request.getAttribute("errorMessage");

                    if (errorMessage != null) {
                %>
                <div class="alert alert-danger">
                    <%= errorMessage %>
                </div>
                <%
                    } else {
                %>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Product Name</th>
                            <th><%= product1Name %></th>
                            <th><%= product2Name %></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Ingredients</td>
                            <td><%= product1Ingredients %></td>
                            <td><%= product2Ingredients %></td>
                        </tr>
                        <tr>
                            <td>Benefits</td>
                            <td><%= product1Benefits %></td>
                            <td><%= product2Benefits %></td>
                        </tr>
                    </tbody>
                </table>
                <%
                    }
                %>
            </div>
            <div class="card-footer text-end">
                <a href="compareProducts.jsp" class="btn btn-secondary">Back</a>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>