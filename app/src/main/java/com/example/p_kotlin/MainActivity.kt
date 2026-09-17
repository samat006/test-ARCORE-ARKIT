package com.example.p_kotlin

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.navigation.compose.rememberNavController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable


class MainActivity : ComponentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContent {

            val navController = rememberNavController()

            NavHost(
                navController = navController,
                startDestination = "home"
            ) {

                composable("home") {
                    HomeScreen(
                        onNavigateToTasks = {
                            navController.navigate("tasks")
                        }, onNavigateToMap = {
                            navController.navigate("map")
                        }
                    )
                }
                composable("tasks") {
                    TasksScreen(
                        onBack = {
                            navController.popBackStack()
                        }
                    )
                }
                composable("map"){
                    MapScreen()
                }
            }
        }
    }
}
/*
class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

       setContent {
            val taches = listOf(
                "Apprendre Kotlin",
                "Découvrir Compose",
                "Créer TaskFlow"
            )
            val tachesm = mutableListOf(
                "Apprendre Kotlin",
                "Découvrir Compose"
            )
            var tache by remember {
                mutableStateOf(
                    listOf(
                        "Apprendre Kotlin",
                        "Découvrir Compose"
                    )
                )
            }

            tachesm.add("Créer ")

            var nouvelleTache by remember {
                mutableStateOf("")
            }
            Column(
                //modifier = Modifier.padding(42.dp)
                modifier = Modifier.fillMaxSize(),
                horizontalAlignment = Alignment.CenterHorizontally,

                verticalArrangement = Arrangement.Center


                ) {
                var compteur by remember { mutableStateOf(0) }

                Text("Bienvenue sur TaskFlow 🚀")
                Text("Compteur : $compteur")

                Button(
                    onClick = {
                        compteur++
                    }
                ) {
                    Text("+1")
                }
                Button(
                    onClick = {
                        tache = tache + nouvelleTache
                    }
                ) {
                    Text("Ajouter une tâche")
                }
                LazyColumn {
                    item {
                        Text("Apprendre Kotlin")
                    }

                    item {
                        Text("Découvrir Compose")
                    }

                }

                LazyColumn {
                    items(tache) { tache ->
                        Card {
                            Text(tache)
                        }
                    }
                }
                TextField(
                    value = nouvelleTache,
                    onValueChange = {
                        nouvelleTache = it
                    }
                )
            }
        }
    }
}*/