package com.example

import android.app.Activity
import android.os.Bundle
import android.widget.LinearLayout
import android.widget.TextView
import android.widget.Button
import android.view.Gravity
import android.view.ViewGroup.LayoutParams
import android.view.View

class MainActivity : Activity(), View.OnClickListener {

    init {
        System.loadLibrary("native_lib")
    }

    // Native method declarations
    external fun helloFromJNI(): String
    
    // TextView reference as a field
    private var messageTextView: TextView? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Create a vertical LinearLayout as the root view
        val layout = LinearLayout(this)
        layout.orientation = LinearLayout.VERTICAL
        layout.gravity = Gravity.CENTER
        layout.layoutParams = LayoutParams(
            LayoutParams.MATCH_PARENT,
            LayoutParams.MATCH_PARENT
        )

        // Add a TextView displaying JNI string
        messageTextView = TextView(this)
        messageTextView?.text = helloFromJNI()
        messageTextView?.textSize = 24f
        messageTextView?.gravity = Gravity.CENTER

        // Add a Button
        val button = Button(this)
        button.text = "Click me!"
        button.setOnClickListener(this)

        // Add views to layout
        layout.addView(messageTextView)
        layout.addView(button)

        // Set content view to the layout
        setContentView(layout)
    }
    
    // Implement onClick directly in the Activity
    override fun onClick(v: View) {
        messageTextView?.text = "Button clicked!"
    }
}
