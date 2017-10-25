package com.mad.weimiao.weatherbuddy;

import com.mad.weimiao.weatherbuddy.model.Weather;
import com.mad.weimiao.weatherbuddy.model.WeatherLocation;
import com.mad.weimiao.weatherbuddy.model.ZipToLatLon;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;


class GetWeather {
    static Weather getWeather(String data) throws JSONException  {
        Weather weather = new Weather();

        //create JSONObject from the data
        JSONObject jObj = new JSONObject(data);

        //start extracting the info
        WeatherLocation loc = new WeatherLocation();

        JSONObject coordObj = getObject("coord", jObj);
        loc.setLatitude(getFloat("lat", coordObj));
        loc.setLongitude(getFloat("lon", coordObj));

        JSONObject sysObj = getObject("sys", jObj);
        loc.setCountry(getString("country", sysObj));
        loc.setSunrise(getInt("sunrise", sysObj));
        loc.setSunset(getInt("sunset", sysObj));
        loc.setCity(getString("name", jObj));
        weather.location = loc;

        //get weather info (This is an array)
        JSONArray jArr = jObj.getJSONArray("weather");

        //use only the first value
        JSONObject JSONWeather = jArr.getJSONObject(0);
        weather.currentCondition.setWeatherId(getInt("id", JSONWeather));
        weather.currentCondition.setDescr(getString("description", JSONWeather));
        weather.currentCondition.setCondition(getString("main", JSONWeather));
        weather.currentCondition.setIcon(getString("icon", JSONWeather));

        JSONObject mainObj = getObject("main", jObj);
        weather.currentCondition.setHumidity(getInt("humidity", mainObj));
        weather.currentCondition.setPressure(getInt("pressure", mainObj));
        weather.temperature.setMaxTemp(getFloat("temp_max", mainObj));
        weather.temperature.setMinTemp(getFloat("temp_min", mainObj));
        weather.temperature.setTemp(getFloat("temp", mainObj));

        // Wind
        JSONObject wObj = getObject("wind", jObj);
        weather.wind.setSpeed(getFloat("speed", wObj));
        weather.wind.setDeg(getFloat("deg", wObj));

        // Clouds
        JSONObject cObj = getObject("clouds", jObj);
        weather.clouds.setPerc(getInt("all", cObj));

        // We download the icon to show
        return weather;
    }

    static ZipToLatLon getLocFromZip(String data) throws JSONException{
        ZipToLatLon zipToLL = new ZipToLatLon();
        //create JSONObject from the data
        JSONObject jObj = new JSONObject(data);
        JSONArray jArr = jObj.getJSONArray("results");
        JSONObject JSON_Index0 = jArr.getJSONObject(0);
        JSONObject JSON_Geometry = getObject("geometry",JSON_Index0);
        JSONObject JSONLatLon = getObject("location", JSON_Geometry);
        zipToLL.zipLat.setLatFromZip(getFloat("lat",JSONLatLon));
        zipToLL.zipLon.setLonFromZip(getFloat("lng",JSONLatLon));
        return zipToLL;
    }

    private static JSONObject getObject(String tagName, JSONObject jObj)  throws JSONException {
        return jObj.getJSONObject(tagName);
    }

    private static String getString(String tagName, JSONObject jObj) throws JSONException {
        return jObj.getString(tagName);
    }

    private static float  getFloat(String tagName, JSONObject jObj) throws JSONException {
        return (float) jObj.getDouble(tagName);
    }

    private static int  getInt(String tagName, JSONObject jObj) throws JSONException {
        return jObj.getInt(tagName);
    }
}
