<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Product Analysis</title>

    <!-- Font Awesome for star icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        body {
            margin: 0;
            font-family: Helvetica, Arial, sans-serif;
            background-color: #fffaf6;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .header-image {
            width: 100%;
            height: 180px;
            object-fit: cover;
            border-bottom: 5px solid #e9d7c0;
        }

        .container {
            flex: 1;
            max-width: 1000px;
            margin: 30px auto;
            padding: 20px;
        }

        .result-card {
            background: #ffffff;
            border: 2px solid #e9d7c0;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .result-header {
            background-color: #ecc3a5;
            padding: 15px;
            font-size: 28px;
            font-weight: bold;
            color: #000;
            border-radius: 10px;
            text-align: center;
            margin-bottom: 25px;
        }

        .highlight {
            margin-bottom: 20px;
        }

        .highlight h3 {
            margin-bottom: 10px;
            color: #987d61;
        }

        .tags {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .tag {
            background-color: #e6f0f2;
            color: #000;
            padding: 8px 14px;
            border-radius: 20px;
            font-size: 14px;
            border: 1px solid #987d61;
            display: flex;
            align-items: center;
        }

        .tag i.fa-star {
            color: #f4c542;
            margin-left: 6px;
        }

        .benefits-box {
            background-color: #fef9f4;
            border-left: 5px solid #987d61;
            padding: 15px;
            border-radius: 10px;
            font-size: 16px;
            color: #333;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            padding: 12px 20px;
            border-radius: 6px;
            border: 1px solid #f5c6cb;
            text-align: center;
            margin-bottom: 20px;
        }

        .card-footer {
            text-align: center;
            margin-top: 30px;
        }

        .card-footer a {
            background-color: #987d61;
            color: #ffffff;
            text-decoration: none;
            padding: 10px 25px;
            border-radius: 8px;
            font-weight: bold;
            transition: 0.3s;
        }

        .card-footer a:hover {
            background-color: #e6f0f2;
            color: #000;
        }

        footer {
            background-color: #ecc3a5;
            color: #000000;
            text-align: center;
            padding: 20px 0;
            border-top: 5px solid #e9d7c0;
        }
    </style>
</head>
<body>
    <img src="image/skincare13.png" alt="Header Image" class="header-image">

    <div class="container">
        <div class="result-card">
            <div class="result-header">Product Analysis Result</div>

            <%
                String productName = (String) request.getAttribute("productName");
                String ingredientsRaw = (String) request.getAttribute("ingredients");
                String benefits = (String) request.getAttribute("benefits");
                String errorMessage = (String) request.getAttribute("errorMessage");

                // Define your star ingredients
                String[] starList = { "Hyaluronic Acid", "Glycerin", "Aloe Vera", "Niacinamide", "", 
                    "Vitamin C", "Retinol", "AHA", "Ascorbic Acid", "Glycolic Acid", "Lactic Acid", "Camellia Sinensis Leaf Extract", 
                    "Salicylic Acid", "Benzoyl Peroxide", "Ceramides", "Beta Glucan", "Squalane", "Snail Mucin", "Peptides", "Panthenol", "Licorice Root Extract", "Alpha Arbutin", 
                    "Bakuchiol", "Zinc", "Centella Asiatica", "Madecassoside", "Allantoin", "Zinc Oxide", "Titanium Dioxide", "Oryza Sativa" ,"Snail Secretion Filtrate", "Galactomyces Ferment Filtrate"};

                java.util.List<String> starIngredients = java.util.Arrays.asList(starList);

                if (errorMessage != null) {
            %>
                <div class="alert-danger"><%= errorMessage %></div>
            <%
                } else {
                    String[] ingredients = ingredientsRaw != null ? ingredientsRaw.split(",") : new String[0];
            %>
                <div class="highlight">
                    <h3>Product Name:</h3>
                    <div class="tag"><%= productName %></div>
                </div>

                <div class="highlight">
                    <h3>Key Ingredients:</h3>
                    <div class="tags">
                        <% for (String ing : ingredients) {
                               String trimmed = ing.trim();
                               boolean isStar = starIngredients.contains(trimmed);
                        %>
                            <div class="tag">
                                <%= trimmed %>
                                <% if (isStar) { %>
                                    <i class="fas fa-star" title="Star Ingredient"></i>
                                <% } %>
                            </div>
                        <% } %>
                    </div>
                </div>

                <div class="highlight">
                    <h3>Benefits:</h3>
                    <div class="benefits-box">
                        <%= benefits %>
                    </div>
                </div>
            <%
                }
            %>

            <div class="card-footer">
                <a href="Product_Analyzer.jsp">Analyze Another Product</a>
            </div>
        </div>
    </div>

    <footer>
        &copy; 2025 SKINPAIRS by Nurfaqihah Zahirah Bt Zainal Ariffin (S61005)
    </footer>
</body>
</html>
