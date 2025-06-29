<%-- 
    Document   : Homepage
    Created on : Jun 23, 2025, 3:38:46 PM
    Author     : FAQIHAH
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>SKINPAIRS Homepage</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        /* Reset and layout */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Helvetica Neue', sans-serif;
            background-color: #ffffff;
            color: #333;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 15px 50px;
            background-color: #fff;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .logo {
            display: flex;
            align-items: center;
            font-size: 22px;
            font-weight: bold;
        }

        .logo i {
            color: #7c6a54;
            margin-right: 10px;
        }

        nav {
            display: flex;
            gap: 30px;
        }

        nav a {
            font-weight: 500;
            color: #333;
            padding: 5px 10px;
            border-radius: 4px;
        }

        nav a:hover {
            background-color: #f5f5f5;
        }

        .hero {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 80px 20px 40px;
        }

        .hero h1 {
            font-size: 36px;
            margin-bottom: 10px;
        }

        .hero p {
            font-size: 18px;
            color: #777;
        }

        .search-box {
            margin-top: 40px;
            background-color: #fff;
            border-radius: 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            display: flex;
            align-items: center;
            padding: 20px 30px;
            width: 90%;
            max-width: 800px;
        }

        .search-box input {
            flex: 1;
            border: none;
            outline: none;
            font-size: 16px;
            padding: 10px;
        }

        .search-options {
            display: flex;
            gap: 15px;
        }

        .search-options button {
            background-color: #f3f3f3;
            border: none;
            padding: 8px 12px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 5px;
            transition: background-color 0.2s ease;
        }

        .search-options button:hover {
            background-color: #e0e0e0;
        }
        
        .search-container {
    background-color: #ffffff;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    padding: 30px;
    max-width: 800px;
    margin: 30px auto;
    border-radius: 20px;
    text-align: center;
}

.search-input {
    width: 90%;
    padding: 15px 20px;
    font-size: 16px;
    border: 2px solid #ddd;
    border-radius: 30px;
    margin-bottom: 20px;
    box-sizing: border-box;
}

.search-buttons {
    display: flex;
    justify-content: center;
    gap: 15px;
}

.search-btn {
    padding: 10px 20px;
    border-radius: 25px;
    background-color: #f6f6f6;
    border: 1px solid #ccc;
    font-size: 14px;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    gap: 8px;
}

.search-btn i {
    font-size: 16px;
}

.search-btn:hover {
    background-color: #e6f0f2;
    color: #000;
}

   .section-container {
    padding: 50px 60px;
    background-color: #fffaf6;
}

.section-header {
    margin-bottom: 25px;
    text-align: left;
}

.section-header h2 {
    font-size: 26px;
    margin-bottom: 5px;
    color: #333;
}

.section-header p {
    color: #777;
    font-size: 14px;
}

.card-carousel {
    display: flex;
    overflow-x: auto;
    scroll-snap-type: x mandatory;
    gap: 20px;
    padding: 20px 0;
    scroll-behavior: smooth;
}

.card-carousel::-webkit-scrollbar {
    height: 8px;
}

.card-carousel::-webkit-scrollbar-thumb {
    background-color: #d0d0d0;
    border-radius: 10px;
}

.product-card {
    flex: 0 0 auto;
    width: 220px;
    scroll-snap-align: start;
    background-color: #fff;
    border: 1.5px solid #f0e4d8;
    border-radius: 12px;
    box-shadow: 0 3px 6px rgba(0,0,0,0.06);
    transition: transform 0.2s ease;
    padding: 18px;
}

.product-card:hover {
    transform: translateY(-4px);
}

.product-info {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    gap: 8px;
}

.brand-name {
    font-size: 16px;
    font-weight: 600;
    color: #333;
}

.product-name {
    font-size: 14px;
    font-weight: 400;
    color: #666;
    line-height: 1.4;
}

.match-badge {
    margin-top: 5px;
    background-color: #ffe5b4;
    color: #7a4e00;
    padding: 6px 12px;
    font-size: 12px;
    border-radius: 20px;
    font-weight: 500;
}

.carousel-wrapper {
    position: relative;
    display: flex;
    align-items: center;
}

.carousel-btn {
    background-color: #fff;
    border: 1px solid #ddd;
    color: #555;
    width: 35px;
    height: 35px;
    border-radius: 50%;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    cursor: pointer;
    z-index: 10;
    transition: background-color 0.2s ease;
}

.carousel-btn:hover {
    background-color: #f0f0f0;
}

.carousel-btn.left {
    margin-right: 10px;
}

.carousel-btn.right {
    margin-left: 10px;
}

.product-type {
    font-size: 13px;
    color: #888;
    margin-top: 6px;
}

.match-badge {
    background-color: #d3f1d6;
    color: #2e7d32;
    padding: 6px 12px;
    font-size: 13px;
    border-radius: 20px;
    font-weight: bold;
}

     
    </style>
</head>
<body>

<header>
    <div class="logo">
        <i class="fa-solid fa-flask"></i> SKINPAIRS
    </div>
    <nav>
        <a href="#">Glossary</a>
        <a href="#">Community</a>
        <a href="#">Profile</a>
        <a href="#">Logout</a>
    </nav>
</header>

<section class="hero">
    <h1>Welcome back<c:if test="${not empty username}">, ${username}</c:if>!</h1>
<c:if test="${not empty skinType}">
    <p>Your skin type: <strong>${skinType}</strong></p>
</c:if>
<c:if test="${empty skinType}">
    <p><a href="skin_quiz.jsp">Take our skin quiz</a> to get personalized results!</p>
</c:if>

    <div class="search-container">
        <form action="SearchServlet" method="GET">
            <input type="text" name="query" placeholder="Paste ingredients or search" class="search-input" />
            <div class="search-buttons">
                <button type="button" class="search-btn"><i class="fas fa-image"></i> Image</button>
                <button type="submit" class="search-btn"><i class="fas fa-clone"></i> Find dupes</button>
                <button type="button" class="search-btn"><i class="fas fa-sliders-h"></i> Filters</button>
            </div>
        </form>
    </div>
</section>

<section class="section-container">
    <div class="section-header">
        <h2>Recommended for Your Skin Type</h2>
        <p>Based on your skin type analysis</p>
    </div>

    <c:choose>
        <c:when test="${not empty recommendedProducts}">
       <div class="carousel-wrapper">
    <button class="carousel-btn left" onclick="scrollCarousel(-1)">
        <i class="fas fa-chevron-left"></i>
    </button>

    <div class="card-carousel" id="productCarousel">
        <c:forEach var="product" items="${recommendedProducts}">
            <div class="product-card">
                <div class="product-info">
                    <h4 class="brand-name">${product.brand}</h4>
                    <p class="product-name">${product.name}</p>

                    <span class="match-badge">
                        ${product.matchPercentage}% Match
                    </span>

                    <span class="product-type">${product.type}</span>
                </div>
            </div>
        </c:forEach>
    </div>

    <button class="carousel-btn right" onclick="scrollCarousel(1)">
        <i class="fas fa-chevron-right"></i>
    </button>
</div>

        </c:when>
        <c:otherwise>
            <p style="text-align: center; color: #999; margin-top: 30px;">
                No product recommendations found for your skin type.
            </p>
        </c:otherwise>
    </c:choose>
</section>

<script>
function scrollCarousel(direction) {
    const carousel = document.getElementById('productCarousel');
    const scrollAmount = 250; // adjust scroll amount here
    carousel.scrollBy({
        left: direction * scrollAmount,
        behavior: 'smooth'
    });
}
</script>

</body>
</html>

