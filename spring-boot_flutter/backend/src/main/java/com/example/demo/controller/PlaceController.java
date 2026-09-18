
package com.example.demo.controller;

import com.example.demo.model.Place;
import com.example.demo.service.PlaceService;
import org.springframework.web.bind.annotation.*;
import com.example.demo.dto.PlaceResponse;
import com.example.demo.dto.PlaceRequest;

import java.util.List;

@RestController
public class PlaceController {

    private final PlaceService placeService;

    public PlaceController(PlaceService placeService) {
        this.placeService = placeService;
    }

    @GetMapping("/places")
    public List<PlaceResponse> getPlaces() {
        return placeService.getAllPlaces();
    }

    @GetMapping("/places/{id}")
    public PlaceResponse getPlace(@PathVariable int id) {
        return placeService.toResponse(placeService.getPlaceById(id));
    }

    @PostMapping("/places")
    public PlaceResponse createPlace(@RequestBody PlaceRequest request) {
        return placeService.createPlace(request);
    }

    @PutMapping("/places/{id}")
    public Place updatePlace(
            @PathVariable int id,
            @RequestBody Place updatedPlace) {

        return placeService.updatePlace(id, updatedPlace);
    }

    @DeleteMapping("/places/{id}")
    public void deletePlace(@PathVariable int id) {
        placeService.deletePlace(id);
    }
}

