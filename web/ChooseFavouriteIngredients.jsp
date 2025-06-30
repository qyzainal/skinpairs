<%-- 
    Document   : ChooseFavouriteIngredients
    Created on : Jun 30, 2025, 8:01:14 PM
    Author     : FAQIHAH
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Select Your Favourite Ingredients</title>
    <style>
        body {
            font-family: Helvetica, Arial, sans-serif;
            background-color: #fffaf6;
            margin: 0;
            padding: 20px;
        }
        h2 {
            text-align: center;
            color: #2b1819;
        }
        form {
            max-width: 800px;
            margin: 0 auto;
        }
        .ingredient-list {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            justify-content: center;
        }
        .ingredient-item {
            border: 1px solid #e9d7c0;
            padding: 8px 12px;
            border-radius: 5px;
            cursor: pointer;
            background-color: #ffffff;
        }
        .ingredient-item input[type="checkbox"] {
            margin-right: 5px;
        }
        button {
            display: block;
            margin: 20px auto;
            padding: 10px 20px;
            background-color: #987d61;
            color: white;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #2b1819;
        }
    </style>
</head>
<body>

<h2>Select up to 10 of your favourite skincare ingredients</h2>

<form action="SaveFavouriteIngredientsServlet" method="post">
    <div class="ingredient-list">
        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                // Use centralized DBConnection utility
                conn = utils.DBConnection.initializeDatabase();

                String sql = "SELECT ingredient_name, ingredient_category FROM ingredient_list WHERE ingredient_category = 'Cult Favourite'";
                stmt = conn.prepareStatement(sql);
                rs = stmt.executeQuery();

                while (rs.next()) {
                    String ingredient = rs.getString("ingredient_name");
                    String category = rs.getString("ingredient_category"); // e.g., Cult Favourite, etc.
        %>
            <label class="ingredient-item">
                <input type="checkbox" name="ingredients" value="<%= ingredient %>">
                <%= ingredient %> (<%= category %>)
            </label>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
        %>
            <p style="color:red;">Failed to load ingredients.</p>
        <%
            } finally {
                try { if (rs!=null) rs.close(); if (stmt!=null) stmt.close(); if (conn!=null) conn.close(); } catch(Exception ex) {}
            }
        %>
    </div>

    <button type="submit">Save Favourites</button>
</form>

<script>
    // Limit selection to 10
    const checkboxes = document.querySelectorAll('input[type=checkbox]');
    checkboxes.forEach(cb => {
        cb.addEventListener('change', () => {
            const checked = document.querySelectorAll('input[type=checkbox]:checked');
            if (checked.length > 10) {
                cb.checked = false;
                alert("You can select up to 10 ingredients only!");
            }
        });
    });
</script>

</body>
</html>
