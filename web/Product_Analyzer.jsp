<!DOCTYPE html>
<html>
<head>
    <title>Product Analyzer</title>
    <style>
        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            font-family: Helvetica, Arial, sans-serif;
            background-color: #ffffff;
            color: #000000;
            display: flex;
            flex-direction: column;
        }

        h1 {
            font-family: Monaco;
            text-align: center;
            color: #000000;
            font-size: 75px;
            font-weight: bold;
            margin-bottom: 50px;
        }

        .navbar {
            background-color: #ecc3a5;
            display: flex;
            justify-content: space-around;
        }

        .navbar a {
            color: #000000;
            text-decoration: none;
            font-size: 18px;
            padding: 15px 30px;
            font-family: Monaco;
            flex-grow: 1;
            text-align: center; 
        }

        .navbar a:hover {
            background-color: #e6f0f2;
            color: #000000;
        }

        .content-container {
            display: flex;
            flex: 1;
            justify-content: center;
            align-items: center;
            position: relative;
        }

        .content img.logo {
            margin-bottom: -37px; 
        }

        .side-image {
            position: absolute;
            top: 0;
            bottom: 0;
            width: 20%;
            height: 99%;
            object-fit: cover;
            border: 5px solid #e9d7c0;
        }

        .left-image {
            left: 0;
        }

        .right-image {
            right: 0;
        }

        .content {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            width: 60%;
            z-index: 1;
            text-align: center;
        }

        .form-container {
            background-color: #ecc3a5;
            border: 15px solid #e9d7c0;
            border-radius: 10px;
            padding: 30px 50px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 100%;
            max-width: 400px;
            position: relative;
        }

        label {
            display: block;
            font-size: 16px;
            color: #000000;
            margin-bottom: 10px;
        }

        input[type="text"] {
            width: calc(100% - 30px); 
            padding: 10px 15px;
            font-size: 14px;
            margin-bottom: 0;
            border: 1px solid #987d61;
            border-radius: 5px;
            box-sizing: border-box;
        }

        #suggestions {
            border: 1px solid #ccc;
            max-height: 150px;
            overflow-y: auto;
            position: absolute;
            background-color: #fff;
            width: calc(100% - 30px);
            z-index: 99;
            border-radius: 5px;
        }

        .suggestion-item {
            padding: 10px;
            cursor: pointer;
            border-bottom: 1px solid #eee;
        }

        .suggestion-item:hover {
            background-color: #f0f0f0;
        }

        button {
            width: 100%;
            max-width: 200px;
            padding: 10px 20px;
            font-size: 16px;
            color: #ffffff;
            background-color: #987d61;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s ease;
            margin: 20px auto 0 auto;
            display: block;
        }

        button:hover {
            background-color: #e6f0f2;
            color: #987d61;
        }

        footer {
            background-color: #ecc3a5;
            color: #000000;
            text-align: center;
            padding: 20px 0;
            margin: 0;
            border: 5px solid #e9d7c0;
            border-radius: 10px;
        }
    </style>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const input = document.getElementById("productName");
            const suggestionBox = document.getElementById("suggestions");

            input.addEventListener("input", function () {
                const query = input.value;
                if (query.length >= 2) {
                    fetch("ProductSuggestionServlet?query=" + encodeURIComponent(query))
                        .then(response => response.json())
                        .then(data => {
                            suggestionBox.innerHTML = "";
                            data.forEach(item => {
                                const option = document.createElement("div");
                                option.textContent = item;
                                option.className = "suggestion-item";
                                option.onclick = () => {
                                    input.value = item;
                                    suggestionBox.innerHTML = "";
                                };
                                suggestionBox.appendChild(option);
                            });
                        });
                } else {
                    suggestionBox.innerHTML = "";
                }
            });

            document.addEventListener("click", (e) => {
                if (!suggestionBox.contains(e.target) && e.target !== input) {
                    suggestionBox.innerHTML = "";
                }
            });
        });
    </script>
</head>
<body>
    <div class="navbar">
        <a href="#">Analysis</a>
        <a href="CommunityPost_User.jsp">Community</a>
        <a href="#">Glossary</a>
        <a href="LogoutServlet">Logout</a>
    </div>

    <div class="content-container">
        <img src="image/skincare2.jpeg" alt="Left Image" class="side-image left-image">

        <div class="content">
            <img src="image/SKIN.png" alt="Product Analyzer Logo" class="logo" width="190px">
            <h1>Product Analyzer</h1>
            <div class="form-container">
                <form action="ProductAnalyzerServlet" method="POST">
                    <label for="productName">Enter Product Name:</label>
                    <input type="text" name="productName" id="productName" placeholder="Type product name here..." required autocomplete="off">
                    <div id="suggestions"></div>
                    <button type="submit">Analyze</button>
                </form>
            </div>
        </div>

        <img src="image/skincare6.png" alt="Right Image" class="side-image right-image">
    </div>

    <footer>
        &copy; 2025 SKINPAIRS by Nurfaqihah Zahirah Bt Zainal Ariffin (S61005)
    </footer>
</body>
</html>
