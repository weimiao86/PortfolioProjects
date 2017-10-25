package com.mad.weimiao.weatherbuddy;

import android.app.Activity;
import android.app.ListActivity;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.res.Configuration;
import android.os.Bundle;
import android.support.v7.app.AlertDialog;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;

import java.util.ArrayList;

public class SavedLocations extends ListActivity {

    private static final String LOCATION_AMOUNT = "location_amount";
    private static final String LAT = "lat";
    private static final String LNG = "lng";
    private final String[] LOCATIONS = {
            "LOCATION_0","LOCATION_1","LOCATION_2","LOCATION_3","LOCATION_4",
            "LOCATION_5","LOCATION_6","LOCATION_7","LOCATION_8","LOCATION_9"
    };
    private ArrayList<String> listItems= new ArrayList<>();
    private ArrayAdapter<String> adapter;
    private int LIST_INDEX;
    private int[] disList = new int[10];

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_saved_locations);
        Intent intent_get = getIntent();
        LIST_INDEX=0;
        Integer locationsAmount = intent_get.getIntExtra(LOCATION_AMOUNT,0);
        SharedPreferences sharedPre;
        String str;
        for(int i=0; i<=locationsAmount; i++){
            sharedPre = getApplicationContext().getSharedPreferences(LOCATIONS[i], MODE_PRIVATE);
            if(sharedPre.getBoolean("isUsed",false)){
                str = sharedPre.getString(LOCATIONS[i],"Untitled Location") + " (" + String.valueOf(sharedPre.getFloat(LAT,0))
                        + ", " + String.valueOf(sharedPre.getFloat(LNG,0)) + ")";
                listItems.add(LIST_INDEX,str);
                disList[LIST_INDEX]=i;
                LIST_INDEX+=1;
            }
        }

        adapter = new ArrayAdapter<>(this,
                android.R.layout.simple_list_item_1, listItems);
        setListAdapter(adapter);

        getListView().setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> myAdapter, View myView, int myItemInt, long mylng) {
                String selectedFromList = (String) (getListView().getItemAtPosition(myItemInt));
                Intent returnIntent = new Intent();
                if(selectedFromList.isEmpty()){
                    setResult(Activity.RESULT_CANCELED, returnIntent);
                    finish();
                }else {
                    //returnIntent.putExtra("selected", selectedFromList);
                    returnIntent.putExtra("selected",disList[myItemInt]);
                    setResult(Activity.RESULT_OK, returnIntent);
                    //System.out.println(selectedFromList);
                    finish();
                }
            }
        });

        getListView().setOnItemLongClickListener(new AdapterView.OnItemLongClickListener(){
            @Override
            public boolean onItemLongClick(AdapterView<?> parent, View view, final int position, long id) {
                final int deleteIndex = disList[position];
                new AlertDialog.Builder(SavedLocations.this)
                        .setTitle("Warning")
                        .setMessage("Delete this location?")
                        .setPositiveButton("Delete", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog, int which) {
                                SharedPreferences spref = getApplicationContext().getSharedPreferences(LOCATIONS[deleteIndex], MODE_PRIVATE);
                                SharedPreferences.Editor editor = spref.edit();
                                editor.putBoolean("isUsed",false);
                                editor.apply();
                                updateList();
                                adapter.notifyDataSetChanged();
                            }
                        })
                        .setNegativeButton("Cancel", null)
                        .create()
                        .show();
                return true;
            }
        });
    }

    void updateList(){
        Intent intent_get = getIntent();
        LIST_INDEX=0;
        Integer locationsAmount = intent_get.getIntExtra(LOCATION_AMOUNT,0);
        SharedPreferences sharedPre;
        String str;
        listItems.clear();
        for(int i=0; i<=locationsAmount; i++){
            sharedPre = getApplicationContext().getSharedPreferences(LOCATIONS[i], MODE_PRIVATE);
            if(sharedPre.getBoolean("isUsed",false)){
                str = sharedPre.getString(LOCATIONS[i],"None") + "(" + String.valueOf(sharedPre.getFloat(LAT,0))
                        + String.valueOf(sharedPre.getFloat(LNG,0)) + ")";
                listItems.add(LIST_INDEX,str);
                disList[LIST_INDEX]=i;
                LIST_INDEX+=1;
            }
        }
    }

    @Override
    public void onConfigurationChanged(Configuration newConfig)
    {
        super.onConfigurationChanged(newConfig);
        if(newConfig.orientation == Configuration.ORIENTATION_LANDSCAPE)
        {
            startActivity(new Intent(this, MainActivity.class));
        }
    }
}
