package com.example.demo.controller;

import com.example.demo.model.Place;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
public class PlaceController {

    private List<Place> places = new ArrayList<>();

    @GetMapping("/places")
    public List<Place> getPlaces() {
        return places;
    }

    @GetMapping("/places/{id}")
    public Place getPlace(@PathVariable int id) {
        for (Place place : places) {
            if (place.getId() == id) {
                return place;
            }
        }

        return null;
    }

    @PostMapping("/places")
    public Place createPlace(@RequestBody Place place) {
        places.add(place);
        return place;
    }

    @PutMapping("/places/{id}")
    public Place updatePlace(
            @PathVariable int id,
            @RequestBody Place updatedPlace) {

        for (Place place : places) {
            if (place.getId() == id) {
                place.setName(updatedPlace.getName());
                place.setLatitude(updatedPlace.getLatitude());
                place.setLongitude(updatedPlace.getLongitude());

                return place;
            }
        }

        return null;
    }

    @DeleteMapping("/places/{id}")
    public void deletePlace(@PathVariable int id) {
        places.removeIf(place -> place.getId() == id);
    }
}