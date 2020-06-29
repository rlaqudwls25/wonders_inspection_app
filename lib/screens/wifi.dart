import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class Wifi extends StatefulWidget {
  @override
  _WifiState createState() => _WifiState();
}

class _WifiState extends State<Wifi> {
  String networkStatus = 'null';
  bool connectNetwork = false;
  String wifiIP;

  @override
  void initState() {
    super.initState();
    initConnect();
  }

  initConnect() async {
    ConnectivityResult connectResult;
    connectResult = await Connectivity().checkConnectivity();
    updateStatus(connectResult);
  }

  updateStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.wifi) {
      String wifiName;
      wifiName = (await Connectivity().getWifiName()).toString();
      wifiIP = (await Connectivity().getWifiIP()).toString();
      setState(() {
        networkStatus = result.toString() + "/" + wifiName + "/" + wifiIP;
        connectNetwork = true;
      });
    } else if (result == ConnectivityResult.mobile) {
      setState(() {
        networkStatus = result.toString();
        connectNetwork = false;
      });
    } else if (result == ConnectivityResult.none) {
      setState(() {
        networkStatus = result.toString();
        connectNetwork = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
            onTap: () {

            },
            child: Center(
              child: Container(
                height: 100,
                width: 100,
                margin: EdgeInsets.all(20),
                child: Icon(Icons.wifi, size: 50, color: Colors.white),
                decoration: BoxDecoration(
                    color: Colors.red,
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
          Text(
            connectNetwork ? '와이파이가 연결 되었습니다.' : '와이파이를 연결해주세요.',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
