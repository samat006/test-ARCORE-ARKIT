package com.example.demo.controller;

import com.example.demo.model.Place;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class PlaceController {

    @GetMapping("/places")
    public Place getPlaces() {
        return new Place("L'Île-Rousse", 42.633, 8.937);
    }
}