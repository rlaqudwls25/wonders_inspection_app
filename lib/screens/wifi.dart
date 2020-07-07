import 'dart:io';
import 'package:flutter/foundation.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connectivity/connectivity.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:wifi_hunter/wifi_hunter.dart';
import 'package:app_settings/app_settings.dart';

class Wifi extends StatefulWidget {
  @override
  _WifiState createState() => _WifiState();
}

class _WifiState extends State<Wifi> {
  String _connectionStatus = 'Unknown';
  String _status = '';
  String _wifiName = '';
  String _wifiBSSID = '';
  String _wifiIP = '';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  WiFiInfoWrapper _wifiObject;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  //Wifi 스캔
  Future<WiFiInfoWrapper> scanWiFi() async {
    WiFiInfoWrapper wifiObject;

    try {
      wifiObject = await WiFiHunter.huntRequest;
    } on PlatformException {}

    return wifiObject;
  }

  //Wifi 핸들러
  Future<void> scanHandler() async {
    _wifiObject = await scanWiFi();
    print("WiFi Results (SSIDs) : ");
    for (var i = 0; i < _wifiObject.ssids.length; i++) {
      print("- " + _wifiObject.ssids[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    //연결 중 로딩바 설정
    ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
    pr.style(
        message: '연결 중..',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: Container(
            padding: EdgeInsets.all(15.0), child: CircularProgressIndicator()),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 7.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w600));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(
          'Wifi',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () async {
              if (_connectionStatus.split('\n')[0] !=
                  'ConnectivityResult.wifi') {
                scanHandler();
                await pr.show();
                Timer.periodic(Duration(milliseconds: 500), (timer) {
                  if (_connectionStatus.split('\n')[0] ==
                      'ConnectivityResult.wifi') {
                    pr.hide();
                    timer.cancel();
                  }
                });
              }
            },
            child: Center(
              child: Container(
                height: 100,
                width: 100,
                margin: EdgeInsets.all(20),
                child: Icon(Icons.wifi, size: 50, color: Colors.white),
                decoration: BoxDecoration(
                    color: _connectionStatus.split('\n')[0] ==
                            'ConnectivityResult.wifi'
                        ? Colors.cyan
                        : Colors.red,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[500],
                        offset: Offset(4.0, 4.0),
                        blurRadius: 10.0,
                        spreadRadius: 1.0,
                      ),
                    ]),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 50.0)),
          _connectionStatus.split('\n')[0] == 'ConnectivityResult.wifi'
              ? Text(
                  '와이파이 연결됨',
                  style: TextStyle(fontSize: 18),
                )
              : Text(
                  '위 버튼을 눌러 와이파이를 연결해주세요.',
                  style: TextStyle(fontSize: 18),
                ),
          SizedBox(height: 50),
          Container(
            width: 350,
            margin: EdgeInsets.only(bottom: 20.0),
            child: Text('※ 와이파이가 지속적으로 연결이 되지 않는다면 아래 설정 버튼을 눌러 수동으로 연결해주세요.',
                style: TextStyle(fontSize: 13.0, color: Colors.grey)),
          ),
          RaisedButton(
            child: Text('설정'),
            onPressed: () => AppSettings.openWIFISettings(),
          ),
          SizedBox(height: 50),
          _connectionStatus.split('\n')[0] == 'ConnectivityResult.wifi'
              ? Container(
                  height: 100,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(),
                  ),
                  child: Text(
                    _connectionStatus.split('\n')[0] ==
                            'ConnectivityResult.wifi'
                        ? '이름 : $_wifiName\nMac Addr : $_wifiBSSID\nIP주소 : $_wifiIP'
                        : '',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  //와이파이 연결상태 업데이트
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        String wifiName, wifiBSSID, wifiIP;

        try {
          if (!kIsWeb && Platform.isIOS) {
            LocationAuthorizationStatus status =
                await _connectivity.getLocationServiceAuthorization();
            if (status == LocationAuthorizationStatus.notDetermined) {
              status =
                  await _connectivity.requestLocationServiceAuthorization();
            }
            if (status == LocationAuthorizationStatus.authorizedAlways ||
                status == LocationAuthorizationStatus.authorizedWhenInUse) {
              wifiName = await _connectivity.getWifiName();
            } else {
              wifiName = await _connectivity.getWifiName();
            }
          } else {
            wifiName = await _connectivity.getWifiName();
          }
        } on PlatformException catch (e) {
          print(e.toString());
          wifiName = "Failed to get Wifi Name";
        }

        try {
          if (!kIsWeb && Platform.isIOS) {
            LocationAuthorizationStatus status =
                await _connectivity.getLocationServiceAuthorization();
            if (status == LocationAuthorizationStatus.notDetermined) {
              status =
                  await _connectivity.requestLocationServiceAuthorization();
            }
            if (status == LocationAuthorizationStatus.authorizedAlways ||
                status == LocationAuthorizationStatus.authorizedWhenInUse) {
              wifiBSSID = await _connectivity.getWifiBSSID();
            } else {
              wifiBSSID = await _connectivity.getWifiBSSID();
            }
          } else {
            wifiBSSID = await _connectivity.getWifiBSSID();
          }
        } on PlatformException catch (e) {
          print(e.toString());
          wifiBSSID = "Failed to get Wifi BSSID";
        }

        try {
          wifiIP = await _connectivity.getWifiIP();
        } on PlatformException catch (e) {
          print(e.toString());
          wifiIP = "Failed to get Wifi IP";
        }

        setState(() {
          _connectionStatus = '$result\n'
              'Name: $wifiName\n'
              'Mac Addr: $wifiBSSID\n'
              'IP: $wifiIP\n';
          _status = _connectionStatus.split('\n')[0];
          _wifiName = wifiName;
          _wifiBSSID = wifiBSSID;
          _wifiIP = wifiIP;
        });
        break;
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }
}
