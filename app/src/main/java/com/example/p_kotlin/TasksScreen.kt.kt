package com.example.p_kotlin

import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Button
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.focus.focusModifier
import androidx.compose.ui.unit.dp

@Composable
fun TasksScreen(
    onBack: () -> Unit
) {
    val modifier = Modifier.padding(42.dp)
    Button(
        modifier= modifier,
        onClick = {
            onBack()
        }
    ) {
        Text("Retour")
    }
}