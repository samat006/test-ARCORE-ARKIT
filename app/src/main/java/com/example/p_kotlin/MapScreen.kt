package com.example.p_kotlin

import androidx.compose.runtime.Composable
import org.maplibre.compose.map.MaplibreMap
import org.maplibre.compose.camera.CameraPosition
import  org.maplibre.spatialk.geojson.Position
import org.maplibre.compose.map.rememberMapState
import org.maplibre.compose.style.BaseStyle

@Composable
fun MapScreen() {

    val mapState = rememberMapState(
        baseStyle = BaseStyle.Uri(
            "https://tiles.openfreemap.org/styles/liberty"
        ),
        initialCameraPosition = CameraPosition(
            target = Position(
                latitude = 42.63,
                longitude = 8.93
            ),
            zoom = 10.0
        )
    )

    MaplibreMap(
        state = mapState,
        overlay = {}
    )
}