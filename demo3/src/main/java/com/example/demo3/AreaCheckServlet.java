package com.example.demo3;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
@WebServlet("/area-check")
public class AreaCheckServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        long startTime = System.nanoTime();
        double x = Double.parseDouble(request.getParameter("x"));
        double y = Double.parseDouble(request.getParameter("y"));
        double R = Double.parseDouble(request.getParameter("R"));
        boolean isPointInside = checkPoint(x, y, R);

        HttpSession session = request.getSession();
        List<Result> results = (List<Result>) session.getAttribute("results");

        if (results == null) {
            results = new ArrayList<>();
            session.setAttribute("results", results);
        }
        long elapsedTimeNano = System.nanoTime() - startTime;
        double executionTime = elapsedTimeNano / 1e6;
        Result result = new Result(x, y, R, isPointInside, new Date(), executionTime);
        results.add(result);
        session.setAttribute("results", results);
        request.getSession().setAttribute("lastResult", result);

        RequestDispatcher dispatcher = request.getRequestDispatcher("result.jsp");
        dispatcher.forward(request, response);
    }

    private boolean checkPoint(double x, double y, double R) {
        boolean quarterCircle = (x >= 0 && y >= 0 && (x * x + y * y <= R * R));
        boolean rectangle = (x <= 0 && x >= -R / 2 && y <= 0 && y >= -R);
        boolean triangle = (x >= 0 && x <= R / 2 && y >= 0 && y <= (R / 2) - x);
        return quarterCircle || rectangle || triangle;
    }
}
