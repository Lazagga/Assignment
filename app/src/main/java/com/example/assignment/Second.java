package com.example.assignment;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;

public class Second extends AppCompatActivity {

    private TextView hello;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second);

        hello = findViewById(R.id.hello);
        Intent intent = getIntent();
        String name = intent.getStringExtra("name");
        String studentNumber = intent.getStringExtra("studentNumber");

        String text = "안녕하세요 " + name + "님.\n당신의 학번은 " + studentNumber + "입니다.";
        hello.setText(text);
    }
}
