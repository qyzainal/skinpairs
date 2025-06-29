<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <title>Your Skin Type Result</title>
    <style>
        body {
            font-family: Helvetica, Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #ffffff;
            color: #000000;
        }

        .navbar {
            background-color: #ecc3a5;
            display: flex;
            justify-content: space-around;
            padding: 15px 0;
        }

        .navbar a {
            text-decoration: none;
            color: #000000;
            font-size: 18px;
            padding: 10px 20px;
            font-family: Monaco;
        }

        .container {
            max-width: 900px;
            margin: 30px auto;
            padding: 30px;
            background-color: #fdf3e7;
            border: 2px solid #e9d7c0;
            border-radius: 10px;
        }

        h1 {
            text-align: center;
            color: #987d61;
            font-size: 32px;
        }

        .skin-type {
            text-align: center;
            font-size: 26px;
            font-weight: bold;
            margin: 30px 0 20px;
            color: #2b1819;
        }

        .product {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
            background-color: #ffffff;
            box-shadow: 2px 2px 6px rgba(0,0,0,0.05);
        }

        .product h3 {
            margin: 0 0 8px;
            color: #2b1819;
        }

        .product p {
            margin: 5px 0;
            color: #333;
        }

        .next-button {
            display: block;
            text-align: center;
            margin-top: 40px;
        }

        .next-button a {
            padding: 12px 25px;
            font-size: 16px;
            font-weight: bold;
            background-color: #987d61;
            color: white;
            text-decoration: none;
            border-radius: 6px;
        }

        .next-button a:hover {
            background-color: #2b1819;
        }

        footer {
            background-color: #ecc3a5;
            text-align: center;
            padding: 20px 0;
            margin-top: 40px;
            color: #000000;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <a href="Homepage.jsp">Home</a>
        <a href="#">Analysis</a>
        <a href="#">Community</a>
        <a href="#">Glossary</a>
    </div>

    <div class="container">
        <h1>Your Skin Type Has Been Identified!</h1>

        <div class="skin-type">
            You have <%= request.getAttribute("skinType") != null ? request.getAttribute("skinType") : "Unknown" %> skin.
        </div>

        <h2>Recommended Products for You:</h2>

        <%
            List<Map<String, String>> products = (List<Map<String, String>>) request.getAttribute("recommendedProducts");
            if (products != null && !products.isEmpty()) {
                Collections.shuffle(products);
                int numToShow = 3 + new Random().nextInt(2);
                numToShow = Math.min(numToShow, products.size());

                for (int i = 0; i < numToShow; i++) {
                    Map<String, String> product = products.get(i);
        %>
        <div class="product">
            <h3><%= product.get("brand") %> - <%= product.get("name") %></h3>
            <p><strong>Ingredients:</strong> <%= product.get("ingredients") %></p>
            <p><strong>Benefits:</strong> <%= product.get("benefits") %></p>
        </div>
        <%
                }
            } else {
        %>
        <p>No suitable products found for your skin type.</p>
        <%
            }
        %>

        <div class="next-button">
            <a href="Homepage.jsp">Go to My Homepage</a>
        </div>
    </div>

    <footer>
        &copy; 2025 SKINPAIRS by Nurfaqihah Zahirah Bt Zainal Ariffin (S61005)
    </footer>
</body>
</html>
