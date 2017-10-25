package com.mad.weimiao.weatherbuddy.model;

/**
 * Created by mira67 on 11/3/16.
 */

public class ZipToLatLon {
    public ZiptoLat zipLat = new ZiptoLat();
    public ZiptoLon zipLon = new ZiptoLon();
    public byte[] iconData;

    public class ZiptoLat {
        private float latFromZip;
        public float getLatFromZip(){
            return latFromZip;
        }
        public void setLatFromZip(float lat){
            this.latFromZip = lat;
        }

    }
    public class ZiptoLon {
        private float lonFromZip;
        public float getLonFromZip(){
            return lonFromZip;
        }
        public void setLonFromZip(float lon){
            this.lonFromZip = lon;
        }
    }
}
