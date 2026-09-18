package com.example.demo.dto;

public class PlaceRequest {

    private String name;
    private double latitude;
    private double longitude;

    public PlaceRequest() {
    }

    public String getName() {
        return name;
    }

    public double getLatitude() {
        return latitude;
    }

    public double getLongitude() {
        return longitude;
    }
}