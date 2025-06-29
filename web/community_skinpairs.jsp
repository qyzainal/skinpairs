<%-- 
    Document   : community_skinpairs
    Created on : Apr 24, 2025, 2:16:50?PM
    Author     : FAQIHAH
--%>

<!DOCTYPE html>
<html>
<head>
    <title>SkinPairs Community</title>
    <style>
        body {
            font-family: Helvetica, Arial, sans-serif;
            background-color: #ffffff;
            color: #000000;
            margin: 0;
            padding: 0;
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
            font-family: Monaco;
            padding: 10px 20px;
        }

        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 20px;
            background-color: #fdf3e7;
            border: 2px solid #e9d7c0;
            border-radius: 10px;
        }

        h1 {
            text-align: center;
            color: #987d61;
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }

        .card {
            background-color: #fff8f1;
            border: 1px solid #e9d7c0;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.05);
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .card img {
            width: 100%;
            max-height: 150px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 15px;
        }

        .card h3 {
            color: #2b1819;
            text-align: center;
        }

        .card p {
            color: #333;
            margin-bottom: 15px;
            text-align: center;
        }

        .card button {
            background-color: #987d61;
            color: #fff;
            padding: 8px 16px;
            font-size: 14px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .card button:hover {
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
        <a href="#">Home</a>
        <a href="#">Analysis</a>
        <a href="#">Community</a>
        <a href="#">Glossary</a>
    </div>

    <div class="container">
        <h1>Community Discussion</h1>

        <div class="grid">
            <div class="card">
                <img src="image/skincare14.jpg" alt="Dry Skin">
                <h3>How do you deal with dry patches?</h3>
                <p>I get really dry skin during winter. Any recommended moisturizers or home remedies?</p>
                <button>Join Discussion</button>
            </div>
            <div class="card">
                <img src="image/skincare15.jpg" alt="Sunscreen">
                <h3>Favorite sunscreen for oily skin?</h3>
                <p>I struggle with sunscreen making me shiny. What works for you?</p>
                <button>Join Discussion</button>
            </div>
            <div class="card">
                <img src="image/skn16.jpg" alt="Skin pH">
                <h3>Understanding Skin pH Balance</h3>
                <p>This article explores how the pH level of your skin can affect its health and appearance.</p>
                <button>Read</button>
            </div>
            <div class="card">
                <img src="image/skn17.jpg" alt="Diet and Skin">
                <h3>How diet affects skin clarity</h3>
                <p>Discover what foods can help or harm your skin clarity in this insightful piece.</p>
                <button>Read</button>
            </div>
            <div class="card">
                <img src="image/skn18.jpg" alt="Double Cleansing">
                <h3>Anyone tried double cleansing method?</h3>
                <p>Is it really helpful or just another marketing gimmick? Curious to know your thoughts!</p>
                <button>Join Discussion</button>
            </div>
            <div class="card">
                <img src="image/skn19.jpg" alt="Seasonal Skincare">
                <h3>Guide to Seasonal Skincare</h3>
                <p>A detailed guide on adjusting your skincare routine with the changing seasons.</p>
                <button>Read</button>
            </div>
        </div>
    </div>

    <footer>
        &copy; 2025 SKINPAIRS - All Rights Reserved
    </footer>
</body>
</html>

