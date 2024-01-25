package com.example.demo3;

import java.util.Date;

public class Result {
    private double x;
    private double y;
    private double R;
    private boolean isInside;
    private Date timestamp;
    private double runtime;

    public Result(double x, double y, double R, boolean isInside, Date timestamp, double runtime) {
        this.x = x;
        this.y = y;
        this.R = R;
        this.isInside = isInside;
        this.timestamp = timestamp;
        this.runtime =runtime;
    }

    public double getR() {
        return R;
    }
    public double getX() {
        return x;
    }
    public double getY() {
        return y;
    }
    public boolean isInside() {
        return isInside;
    }
    public Date getTimestamp(){
        return timestamp;
    }
    public double getRuntime(){
        return runtime;
    }
}

