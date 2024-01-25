<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.example.demo3.Result" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="ru">
<head>
  <meta charset="UTF-8">
  <title>Результат</title>
  <style>
    body {
      font-family: serif;
      color: #333;
    }

    head {
      text-align: center;
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

    a {
      display: block;
      width: 100px;
      margin: 20px auto;
      text-align: center;
      text-decoration: none;
      padding: 10px;
      background-color: #007bff;
      color: #fff;
      border-radius: 5px;
    }

    th {
      background-color: #f2f2f2;
    }

    canvas {
      display: block;
      margin: 20px auto; /* Center-align the canvas */
    }
  </style>
  <script type="text/javascript" src="Draw.js"></script>
</head>
<body>

<canvas id="coordinateCanvas" width="250" height="250"></canvas>
<table id="resultsTable">
  <tr>
    <th>R</th>
    <th>X</th>
    <th>Y</th>
    <th>Результат</th>
    <th>Текущее время</th>
    <th>Время выполнения скрипта</th>
  </tr>
  <%
    List<Result> results = (List<Result>) request.getSession().getAttribute("results");
    int lastIndex = results.size() - 1;
    Result lastResult = results.get(lastIndex);
    double x =0;
    double y =0;
    double r =0;
    x=lastResult.getX();
    y=lastResult.getY();
    r=lastResult.getR();
  %>
  <tr>
    <td><%=lastResult.getX()%></td>
    <td><%=lastResult.getY()%></td>
    <td><%=lastResult.getR()%></td>
    <td><%=lastResult.isInside() ? "Внутри" : "Вне"%></td>
    <td><%=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(lastResult.getTimestamp())%></td>
    <td><%=String.format("%.5f", lastResult.getRuntime())%> секунд</td>
  </tr>
  </table>
<a href="index.jsp">Вернутся на главную</a>
<script>
  const selectedX = <%=x%>;
  const selectedY = <%=y%>;
  const selectedR = <%=r%>;
  function getCheckedValue(name) {
    const elements = document.getElementsByName(name);
    for (let i = 0; i < elements.length; i++) {
      if (elements[i].checked) {
        return elements[i].value;
      }
    }
    return null;
  }
  const canvas = document.getElementById('coordinateCanvas');
  const context = canvas.getContext('2d');
  const centerX = canvas.width / 2;
  const centerY = canvas.height / 2;
  document.addEventListener("DOMContentLoaded", function () {
  drawStaticFigures();
  drawPoint(selectedX, selectedY, selectedR);
  });
</script>
</body>
</html>
