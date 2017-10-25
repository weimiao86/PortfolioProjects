Project3-MileStone3

-Wei Miao

- App title: WeatherBuddy

This app can not run on emulator due to updating googlePlay service error, so please test on Android devices.

The weather information from the weather API is not very accurate for locations out of US.

Apk available on PlayStore: https://play.google.com/store/apps/details?id=com.mad.weimiao.weatherbuddy

- App features:

1. Report the current weather of selected location in voice and show the weather info on map.

2. Background image would change with the weather condition.

3. Help menu button and help content in a dialog view.

4. Users can save favorite locations and get the weather of saved locations by selecting in saved locations list.

5. Users can set a nickname for greeting in "Settings", and turn on/off audio report.

- User Flow:

1. At start, the app will locate to current location as default location. Click the "GetWeather" button then the App will report the current weather of current location, and show weather info on the map.

2. To change location, drag the marker(long press) on map directly or input the zip code. Then click "GetWeather" to get current weather of the selected location.

3. To back to the current location, click the "Current Location" icon on map; To zoom in and out, use pinch gesture or use the "+/-" toolbar on the map.

4. When the "GetWeather" button clicked, the App will check the zip code EditText first, if it is empty, App will get location from map marker; if the zip code area is not empty, but it is not in 5-digit format, the app will alert user in voice; if the zip code in 5-digit numbers, the App will show the zip code location on map and report the current weather of it.

5. To save a location, get the weather of that location first, then click favorite button in menu bar. Otherwise, the location would be saved as untitled.

6. The greeting message would change among "good morning", "good afternoon" and "good evening" according to the hour of a day.

- Functionality logic:

1. App start -> get location(default or user input or saved) -> get weather of selected location -> display weather on map and report weather in voice.

2. On the first time start after installation, the app will check and ask permission for location.

3. The app gets location from google maps API and get weather from weather API.

- Problem occurred:

The app would crash when change the device orientation in sub activity and then back to the main activity.

- Reference:

Google maps API for Android:

https://developers.google.com/maps/documentation/android-api/start

https://github.com/googlemaps/android-samples

Openweathermap API for Android:

https://openweathermap.org/current

https://openweathermap.org/examples

Android Text to Speech:

https://developer.android.com/reference/android/speech/tts/TextToSpeech.html

Android SharedPreferences:

https://developer.android.com/reference/android/content/SharedPreferences.html
