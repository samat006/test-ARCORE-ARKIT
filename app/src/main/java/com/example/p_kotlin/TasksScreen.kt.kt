
package com.example.p_kotlin

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Button
import androidx.compose.material3.Checkbox
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp

@Composable
fun TasksScreen(
    onBack: () -> Unit
) {
    var modifier = Modifier.padding(92.dp)

    val tasks = listOf(
        "Apprendre Kotlin",
        "Découvrir Compose",
        "Apprendre Android"
    )
    var checkedTasks by remember {
        mutableStateOf(
            listOf(false, false, false)
        )
    }
    Column(
        modifier = Modifier.fillMaxSize(),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ){
        tasks.forEachIndexed { index, task ->

            Row {

                Checkbox(
                    checked = checkedTasks[index],
                    onCheckedChange = { checked ->

                        val newList = checkedTasks.toMutableList()

                        newList[index] = checked

                        checkedTasks = newList
                    }
                )

                Text(task)
            }
        }

        }

        Button(
            onClick = {
                onBack()
            }
        ) {
            Text("Retour")
        }

      /*  if (checkedTasks) {
            Text("☑ Apprendre Kotlin")
        } else {
            Text("☐ Apprendre Kotlin")
        }*/
    }

