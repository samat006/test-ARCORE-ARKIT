package com.example.demo.service;

import com.example.demo.model.Place;
import com.example.demo.repository.PlaceRepository;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.http.HttpStatus;
import java.util.List;
import com.example.demo.dto.PlaceResponse;
import com.example.demo.dto.PlaceRequest;
@Service
public class PlaceService {

    private final PlaceRepository placeRepository;

    public PlaceService(PlaceRepository placeRepository) {
        this.placeRepository = placeRepository;
    }

    public List<PlaceResponse> getAllPlaces() {
      return placeRepository.findAll()
            .stream()
            .map(this::toResponse)
            .toList();
}

    public Place getPlaceById(int id) {
    Place place = placeRepository.findById(id).orElse(null);

    if (place == null) {
        throw new ResponseStatusException(
                HttpStatus.NOT_FOUND,
                "Place non trouvée"
        );
    }

    return place;
}

  public PlaceResponse createPlace(PlaceRequest request) {

    Place place = new Place(
            null,
            request.getName(),
            request.getLatitude(),
            request.getLongitude()
    );

    Place savedPlace = placeRepository.save(place);

    return toResponse(savedPlace);
}

    public Place updatePlace(Integer id, Place updatedPlace) {
        Place place = placeRepository.findById(id).orElse(null);

        if (place == null) {
            return null;
        }

        place.setName(updatedPlace.getName());
        place.setLatitude(updatedPlace.getLatitude());
        place.setLongitude(updatedPlace.getLongitude());

        return placeRepository.save(place);
    }

    public void deletePlace(int id) {
        placeRepository.deleteById(id);
    }

    public PlaceResponse toResponse(Place place) {
    return new PlaceResponse(
            place.getId(),
            place.getName(),
            place.getLatitude(),
            place.getLongitude()
    );
}
}