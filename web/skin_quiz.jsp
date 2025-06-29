<%-- 
    Document   : skin_quiz
    Created on : Apr 23, 2025, 6:21:14 PM
    Author     : FAQIHAH
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Skin Type Quiz - SKINPAIRS</title>
    <style>
        body {
            font-family: Helvetica, Arial, sans-serif;
            background-color: #ffffff;
            margin: 0;
            padding: 0;
        }

        .quiz-container {
            max-width: 900px;
            margin: 50px auto;
            padding: 30px;
            background-color: #e9d7c0;
            border: 10px solid #ecc3a5;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
        }

        h1 {
            text-align: center;
            font-family: Monaco;
            color: #2b1819;
            font-size: 36px;
        }

        .progress-bar {
            background-color: #dae9ee;
            border-radius: 8px;
            overflow: hidden;
            margin-bottom: 30px;
        }

        .progress {
            background-color: #987d61;
            height: 20px;
            width: 0%;
            transition: width 0.3s ease-in-out;
        }

        .question {
            margin-top: 25px;
        }

        label {
            font-weight: bold;
            display: block;
            margin-bottom: 10px;
            font-size: 16px;
            color: #000000;
        }

        select {
            width: 100%;
            padding: 12px;
            font-size: 15px;
            border: 1px solid #987d61;
            border-radius: 6px;
        }

        button {
            margin-top: 40px;
            padding: 12px 20px;
            background-color: #987d61;
            color: #ffffff;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            width: 100%;
        }

        button:hover {
            background-color: #2b1819;
        }

        footer {
            margin-top: 50px;
            text-align: center;
            font-size: 14px;
            color: #555;
        }
    </style>
    <script>
        function updateProgressBar() {
            const total = 7;
            let answered = 0;
            for (let i = 1; i <= total; i++) {
                const value = document.getElementById("q" + i).value;
                if (value) answered++;
            }
            const percentage = Math.floor((answered / total) * 100);
            document.getElementById("progress").style.width = percentage + "%";
        }
    </script>
</head>
<body>

<div class="quiz-container">
    <h1>Skin Type Quiz</h1>

    <div class="progress-bar">
        <div id="progress" class="progress"></div>
    </div>

    <form action="SkinTypeQuizServlet" method="POST" oninput="updateProgressBar()">

        <div class="question">
            <label for="q1">1. How does your skin feel at the end of the day? 🌙</label>
            <select name="q1" id="q1" required>
                <option value="">Select</option>
                <option value="Oily">Oily</option>
                <option value="Dry">Dry</option>
                <option value="Normal">Normal</option>
                <option value="Combination">Combination</option>
                <option value="Acne-prone">Breaks out or inflamed</option>
            </select>
        </div>

        <div class="question">
            <label for="q2">2. How often do you experience breakouts? 🔴</label>
            <select name="q2" id="q2" required>
                <option value="">Select</option>
                <option value="Acne-prone">Frequently</option>
                <option value="Normal">Rarely</option>
                <option value="Dry">In cold weather</option>
                <option value="Oily">In hot weather</option>
                <option value="Combination">Only T-zone</option>
            </select>
        </div>

        <div class="question">
            <label for="q3">3. How does your skin feel after cleansing? 💧</label>
            <select name="q3" id="q3" required>
                <option value="">Select</option>
                <option value="Dry">Tight and dry</option>
                <option value="Oily">Greasy quickly</option>
                <option value="Normal">Balanced</option>
                <option value="Combination">Dry cheeks, oily T-zone</option>
                <option value="Acne-prone">Breaks out or stings</option>
            </select>
        </div>

        <div class="question">
            <label for="q4">4. What best describes your skin texture? ✨</label>
            <select name="q4" id="q4" required>
                <option value="">Select</option>
                <option value="Oily">Shiny and large pores</option>
                <option value="Dry">Rough or flaky</option>
                <option value="Normal">Smooth and even</option>
                <option value="Combination">Mixed texture</option>
                <option value="Acne-prone">Bumpy or inflamed</option>
            </select>
        </div>

        <div class="question">
            <label for="q5">5. How does your skin react to new products? 🧴</label>
            <select name="q5" id="q5" required>
                <option value="">Select</option>
                <option value="Sensitive">Often irritated</option>
                <option value="Oily">More oily</option>
                <option value="Dry">Tight or dry</option>
                <option value="Normal">No change</option>
                <option value="Acne-prone">Breakouts</option>
            </select>
        </div>

        <div class="question">
            <label for="q6">6. How does your skin behave in cold weather? ❄️</label>
            <select name="q6" id="q6" required>
                <option value="">Select</option>
                <option value="Dry">Feels flaky or tight</option>
                <option value="Normal">Stays the same</option>
                <option value="Oily">Less oily than usual</option>
                <option value="Acne-prone">More breakouts</option>
            </select>
        </div>

        <div class="question">
            <label for="q7">7. How often does your skin look shiny or oily? 💦</label>
            <select name="q7" id="q7" required>
                <option value="">Select</option>
                <option value="Oily">All the time</option>
                <option value="Combination">Only in T-zone</option>
                <option value="Normal">Sometimes</option>
                <option value="Dry">Rarely or never</option>
            </select>
        </div>

        <button type="submit">Get My Recommendations</button>
    </form>
</div>

<footer>
    &copy; 2025 SKINPAIRS by Nurfaqihah Zahirah Bt Zainal Ariffin (S61005)
</footer>

</body>
</html>
