package com.example.p_kotlin

import androidx.compose.foundation.layout.Column
import androidx.compose.material3.Button
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.foundation.layout.padding
import androidx.compose.ui.unit.dp

@Composable
fun HomeScreen(
    onNavigateToTasks: () -> Unit,
    onNavigateToMap: () -> Unit
) {
    val modifier = Modifier.padding(42.dp)

    Column {

        Button(
            modifier = modifier,
            onClick = {
                onNavigateToTasks()
            }
        ) {
            Text("Voir mes tâches")
        }

        Button(
            onClick = {
                onNavigateToMap()
            }
        ) {
            Text("Map")
        }
    }
}