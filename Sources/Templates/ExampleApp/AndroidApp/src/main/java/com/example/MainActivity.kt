package com.example

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material.Button
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Surface
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.lifecycle.LifecycleOwner

class MainActivity : ComponentActivity() {

    init {
        System.loadLibrary("native_lib")
    }

    // Native method declarations
    external fun helloFromJNI(): String
    external fun initializeEnvironment()
    external fun cleanup()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // Initialiser l'environnement natif
        initializeEnvironment()
        
        setContent {
            MaterialTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colors.background
                ) {
                    MainScreen(helloFromJNI())
                }
            }
        }
    }
    
    override fun onDestroy() {
        super.onDestroy()
        cleanup()
    }
}

@Composable
fun MainScreen(initialMessage: String) {
    val message = remember { mutableStateOf(initialMessage) }
    
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp),
        verticalArrangement = Arrangement.Center,
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Text(
            text = message.value,
            fontSize = 24.sp,
            modifier = Modifier.padding(bottom = 24.dp)
        )
        
        Button(
            onClick = {
                message.value = "Button clicked! Jetpack Compose works!"
            }
        ) {
            Text("Click me!")
        }
    }
}
