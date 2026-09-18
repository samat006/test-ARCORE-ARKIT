package com.example.demo.dto;

public class PlaceResponse {

    private Integer id;
    private String name;
    private double latitude;
    private double longitude;

    public PlaceResponse() {
    }

    public PlaceResponse(Integer id, String name, double latitude, double longitude) {
        this.id = id;
        this.name = name;
        this.latitude = latitude;
        this.longitude = longitude;
    }

    public Integer getId() {
        return id;
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