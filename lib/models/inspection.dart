import 'package:flutter/material.dart';

class Inspection with ChangeNotifier{
  String blue;
  String bluetooth;
  String camera;
  String compass;
  String direction;
  String flash;
  String gps;
  String green;
  String mike;
  String multitouch;
  String proximity;
  String red;
  String vibration;
  String wifi;
  String touch;

  Inspection(
      {this.blue,
      this.bluetooth,
      this.camera,
      this.compass,
      this.direction,
      this.flash,
      this.gps,
      this.green,
      this.mike,
      this.multitouch,
      this.proximity,
      this.red,
      this.vibration,
      this.wifi,
      this.touch});

  String getBlue() => blue;
  String getBluetooth() => bluetooth;
  String getCamera() => camera;
  String getCompass() => compass;
  String getDirection() => direction;
  String getFlash() => flash;
  String getGps() => gps;
  String getGreen() => green;
  String getMike() => mike;
  String getMultiTouch() => multitouch;
  String getProximity() => proximity;
  String getRed() => red;
  String getVibration() => vibration;
  String getWifi() => wifi;
  String getTouch() => touch;

  void setBlue(String blue){
    this.blue = blue;
    notifyListeners();
  }
  void setBluetooth(String bluetooth){
    this.bluetooth = bluetooth;
    notifyListeners();
  }
  void setCamera(String camera){
    this.camera = camera;
    notifyListeners();
  }
  void setCompass(String compass){
    this.compass = compass;
    notifyListeners();
  }
  void setDirection(String direction){
    this.direction = direction;
    notifyListeners();
  }
  void setFlash(String flash){
    this.flash = flash;
    notifyListeners();
  }
  void setGps(String gps){
    this.gps = gps;
    notifyListeners();
  }
  void setGreen(String green){
    this.green = green;
    notifyListeners();
  }
  void setMike(String mike){
    this.mike = mike;
    notifyListeners();
  }
  void setMultiTouch(String multitouch){
    this.multitouch = multitouch;
    notifyListeners();
  }
  void setProximity(String proximity){
    this.proximity = proximity;
    notifyListeners();
  }
  void setRed(String red){
    this.red = red;
    notifyListeners();
  }
  void setVibration(String vibration){
    this.vibration = vibration;
    notifyListeners();
  }
  void setWifi(String wifi){
    this.wifi = wifi;
    notifyListeners();
  }
  void setTouch(String touch){
    this.touch = touch;
    notifyListeners();
  }
  void initData(){

  }

  Map<String, dynamic> toJson() => {
        'blue': blue,
        'bluetooth': bluetooth,
        'camera': camera,
        'compass': compass,
        'direction': direction,
        'flash': flash,
        'gps': gps,
        'green': green,
        'mike': mike,
        'multiTouch': multitouch,
        'proximity': proximity,
        'red': red,
        'vibration': vibration,
        'wifi': wifi,
        'touch': touch
      };

  Inspection.fromJson(Map<String, dynamic> json)
      : blue = json['blue'],
        bluetooth = json['bluetooth'],
        camera = json['camera'],
        compass = json['compass'],
        direction = json['direction'],
        flash = json['flash'],
        gps = json['gps'],
        green = json['green'],
        mike = json['mike'],
        multitouch = json['multitouch'],
        proximity = json['proximity'],
        red = json['red'],
        vibration = json['vibration'],
        wifi = json['wifi'],
        touch = json['touch'];
}
