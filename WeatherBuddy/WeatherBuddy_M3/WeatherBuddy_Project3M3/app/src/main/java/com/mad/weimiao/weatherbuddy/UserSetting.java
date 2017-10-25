package com.mad.weimiao.weatherbuddy;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.EditText;
import android.widget.ToggleButton;

public class UserSetting extends AppCompatActivity {
    private String NICKNAME;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_user_setting);
        Intent intent = getIntent();
        NICKNAME = intent.getStringExtra("nickname");
        boolean soundOff = intent.getBooleanExtra("isSoundOff",false);
        EditText nickname = (EditText)findViewById(R.id.nicknameText);
        nickname.setText(NICKNAME);
        ToggleButton soundToggle = (ToggleButton)findViewById(R.id.soundToggle);
        soundToggle.setChecked(soundOff);
    }

    void saveSettings(View view){
        EditText nickname = (EditText)findViewById(R.id.nicknameText);
        ToggleButton soundToggle = (ToggleButton)findViewById(R.id.soundToggle);
        String newNickname = nickname.getText().toString();
        boolean newSound = soundToggle.isChecked();
        Intent intent = new Intent();
        intent.putExtra("nickname",newNickname);
        intent.putExtra("isSoundOff", newSound);
        setResult(Activity.RESULT_OK,intent);
        finish();
    }
}
