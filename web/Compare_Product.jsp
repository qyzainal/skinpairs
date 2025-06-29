<%-- 
    Document   : Compare_Product
    Created on : Jan 3, 2025, 6:14:35 PM
    Author     : FAQIHAH
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Compare Products</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="card shadow">
            <div class="card-header bg-primary text-white">
                <h3>Compare Products</h3>
            </div>
            <div class="card-body">
                <form action="CompareProductServlet" method="POST">
                    <div class="mb-3">
                        <label for="product1" class="form-label">Select First Product:</label>
                        <input type="text" name="product1" id="product1" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="product2" class="form-label">Select Second Product:</label>
                        <input type="text" name="product2" id="product2" class="form-control" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Compare</button>
                </form>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

