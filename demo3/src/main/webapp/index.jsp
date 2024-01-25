<%@ page import="com.example.demo3.Result" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Проверка точки</title>
    <style>
        body {
            font-family: serif;
            color: #333;
        }
        .container {
            width: 800px;
            margin: 0 auto;
        }
        .header {
            font-family: serif;
            color: #007bff;
            font-size: 20px;
            margin-bottom: 20px;
        }

        .canvas-container {
            position: relative;
        }
        canvas {
            border: 1px solid #000;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
    <script type="text/javascript" src="handleImageClick.js"></script>
    <script type="text/javascript" src="Draw.js"></script>
    <script type="text/javascript" src="validate.js"></script>
    <script type="text/javascript" src="InputLimit.js"></script>
</head>
<body>
<div class="container">
    <div class="header">
        ФИО:Вайкус Яков Михайлович<br>
        Группа: P3224<br>
        Вариант: 25048
    </div></div>
<div class="container">
    <h1>Проверка точки</h1>
    <form action="controller" method="get" onsubmit="return validateForm()">
        <label>X-координата:</label>
        <br>
        <label><input type="radio" name="x" value="-2"> -2</label>
        <label><input type="radio" name="x" value="-1.5"> -1.5</label>
        <label><input type="radio" name="x" value="-1"> -1</label>
        <label><input type="radio" name="x" value="-0.5"> -0.5</label>
        <label><input type="radio" name="x" value="0"> 0</label>
        <label><input type="radio" name="x" value="0.5"> 0.5</label>
        <label><input type="radio" name="x" value="1"> 1</label>
        <label><input type="radio" name="x" value="1.5"> 1.5</label>
        <label><input type="radio" name="x" value="2"> 2</label>
        <br>
        <label class="input-label" for="y">Y-координата:</label>
        <br>
        <input class="input-field" type="number" name="y" id="y" required min="-3" max="3" maxlength="2" oninput="limitInputLength(this, 2)">
        <br>
        <label>Радиус:</label>
        <br>
        <label><input type="radio" name="R" value="1"> 1</label>
        <label><input type="radio" name="R" value="1.5"> 1.5</label>
        <label><input type="radio" name="R" value="2"> 2</label>
        <label><input type="radio" name="R" value="2.5"> 2.5</label>
        <label><input type="radio" name="R" value="3"> 3</label>
        <br>
        <input type="submit" value="Проверить" id ="SubmitButton" onclick="updateCanvas()">
        <span id="errorMessage" class="message"></span>

    </form>
    <div id="coordinateImage" onclick="handleImageClick()"></div>
    <div class="canvas-container">
        <canvas id="coordinateCanvas" width="250" height="250"></canvas>
    </div>
    <table>
        <tr>
            <th>X</th>
            <th>Y</th>
            <th>R</th>
            <th>Результат</th>
            <th>Время</th>
            <th>Время выполнения</th>
        </tr>
        <%
            List<Result> results = (List<Result>) request.getSession().getAttribute("results");
            if (results != null && !results.isEmpty()) {
                for (Result result : results) {
                    double executionTime=result.getRuntime()/1000;
        %>
        <tr>
            <td><%= result.getX() %></td>
            <td><%= result.getY() %></td>
            <td><%= result.getR() %></td>
            <td><%= result.isInside() ? "Внутри" : "Вне" %></td>
            <td><%= new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(result.getTimestamp()) %></td>
            <td><%= String.format("%.5f", executionTime) %> секунд</td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="6">Нет результатов проверок.</td>
        </tr>
        <%
            }
        %>
    </table>
</div>
<script>
    const notification = document.getElementById("errorMessage");
    function showMessage(messageArea, message) {
        messageArea.textContent = message;
        messageArea.style.display = "block";
        setTimeout(function () {
            messageArea.style.display = "none"
        }, 8000);
    }
    function handleImageClick(event) {
        const rInput = document.querySelector('input[name="R"]:checked');
        if (!rInput ) {
            showMessage(notification,"Please select values for  R.");
            return false;
        }
    const newR = parseFloat(getCheckedValue('R'));
    const rect = canvas.getBoundingClientRect()
        const centerX = rect.width / 2;
        const centerY = rect.height / 2;
        const offsetX = event.clientX - rect.left;
        const offsetY = event.clientY - rect.top;
        const normalizedX = (offsetX - centerX) / (rect.width / 2);
        const normalizedY = (centerY - offsetY) / (rect.height / 2);

        drawPoint(normalizedX*3.47, normalizedY*3.47, newR);
        addToTable(normalizedX*3.47, normalizedY*3.47, newR);
}</script>
<script>
    document.getElementById('coordinateCanvas').addEventListener('click', handleImageClick);
    document.getElementById('SubmitButton').addEventListener('submit', function (event) {
        event.preventDefault();
        updateCanvas();
    });

    document.querySelectorAll('input[name="R"]').forEach(radioButton => {
        radioButton.addEventListener('change', updateCanvas);
    });

    document.querySelectorAll('input[name="x"]').forEach(radioButton => {
        radioButton.addEventListener('change', updateCanvas);
    });
    const canvas = document.getElementById('coordinateCanvas');
    const context = canvas.getContext('2d');
    const centerX = canvas.width / 2;
    const centerY = canvas.height / 2;
    updateCanvas()
</script>
</body>
</html>