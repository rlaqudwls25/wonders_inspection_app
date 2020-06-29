import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class Bluetooth extends StatefulWidget {
  @override
  _BluetoothState createState() => _BluetoothState();
}

class _BluetoothState extends State<Bluetooth> {

  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;

  BluetoothConnection connection;

  int _deviceState;

  bool isDisconnecting = false;

  Map<String, Color> colors = {
    'onBorderColor': Colors.green,
    'offBorderColor': Colors.red,
    'neutralBorderColor': Colors.transparent,
    'onTextColor': Colors.green[700],
    'offTextColor': Colors.red[700],
    'neutralTextColor': Colors.blue,
  };


  bool get isConnected => connection != null && connection.isConnected;


  List<BluetoothDevice> _devicesList = [];
  BluetoothDevice _device;
  bool _connected = false;
  bool _isButtonUnavailable = false;

  @override
  void initState() {
    super.initState();


    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    _deviceState = 0; // neutral


    enableBluetooth();


    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
        if (_bluetoothState == BluetoothState.STATE_OFF) {
          _isButtonUnavailable = true;
        }
        getPairedDevices();
      });
    });
  }

  @override
  void dispose() {

    if (isConnected) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }

    super.dispose();
  }


  Future<void> enableBluetooth() async {

    _bluetoothState = await FlutterBluetoothSerial.instance.state;


    if (_bluetoothState == BluetoothState.STATE_OFF) {
      await FlutterBluetoothSerial.instance.requestEnable();
      await getPairedDevices();
      return true;
    } else {
      await getPairedDevices();
    }
    return false;
  }


  Future<void> getPairedDevices() async {
    List<BluetoothDevice> devices = [];

    // To get the list of paired devices
    try {
      devices = await _bluetooth.getBondedDevices();
    } on PlatformException {
      print("Error");
    }

    // It is an error to call [setState] unless [mounted] is true.
    if (!mounted) {
      return;
    }

    // Store the [devices] list in the [_devicesList] for accessing
    // the list outside this class
    setState(() {
      _devicesList = devices;
    });
  }

  // Now, its time to build the UI
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text("블루투스", style: TextStyle(color: Colors.black ,fontWeight: FontWeight.bold),),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.red,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.refresh,
                color: Colors.black,
                size: 15,
              ),
              label: Text(
                "새로고침",
                style: TextStyle(
                  color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              splashColor: Colors.black,
              onPressed: () async {
                // So, that when new devices are paired
                // while the app is running, user can refresh
                // the paired devices list.
                await getPairedDevices().then((_) {
                  show('Device list refreshed');
                });
              },
            ),
          ],
        ),
        body: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Visibility(
                visible: _isButtonUnavailable &&
                    _bluetoothState == BluetoothState.STATE_ON,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.yellow,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '블루투스 연결',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Switch(
                      value: _bluetoothState.isEnabled,
                      onChanged: (bool value) {
                        future() async {
                          if (value) {
                            await FlutterBluetoothSerial.instance
                                .requestEnable();
                          } else {
                            await FlutterBluetoothSerial.instance
                                .requestDisable();
                          }

                          await getPairedDevices();
                          _isButtonUnavailable = false;

                          if (_connected) {
                            _disconnect();
                          }
                        }

                        future().then((_) {
                          setState(() {});
                        });
                      },
                    )
                  ],
                ),
              ),
              Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "연결된 장치",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '장치:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                              ),
                            ),
                            DropdownButton(
                              items: _getDeviceItems(),
                              onChanged: (value) =>
                                  setState(() => _device = value),
                              value: _devicesList.isNotEmpty ? _device : null,
                            ),
                            RaisedButton(
                              color: Colors.black,
                              onPressed: _isButtonUnavailable
                                  ? null
                                  : _connected ? _disconnect : _connect,
                              child:
                              Text(_connected ? 'Disconnect' : 'Connect', style: TextStyle(color: Colors.white),),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: new BorderSide(
                              color:
                                  _deviceState == 0
                                  ? colors['neutralBorderColor']
                                  : _deviceState == 1
                                  ? colors['onBorderColor']
                                  : colors['offBorderColor'],
                              width: 3,

                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          elevation: _deviceState == 0 ? 4 : 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    "장치 1",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black
                                    ),
                                  ),
                                ),
                                FlatButton(
                                  onPressed: _connected
                                      ? _sendOnMessageToBluetooth
                                      : null,
                                  child: Text("ON"),
                                ),
                                FlatButton(
                                  onPressed: _connected
                                      ? _sendOffMessageToBluetooth
                                      : null,
                                  child: Text("OFF"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.blue,
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(height: 30, ),
                        RaisedButton(
                          color: Colors.black,
                          elevation: 4,
                          child: Text("블루투스 설정" ,style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                          onPressed: () {
                            FlutterBluetoothSerial.instance.openSettings();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Create the List of devices to be shown in Dropdown Menu
  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devicesList.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text('없음'),
      ));
    } else {
      _devicesList.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name),
          value: device,
        ));
      });
    }
    return items;
  }

  // Method to connect to bluetooth
  void _connect() async {
    setState(() {
      _isButtonUnavailable = true;
    });
    if (_device == null) {
      show('장치를 찾을 수 없습니다');
    } else {
      if (!isConnected) {



        await BluetoothConnection.toAddress(_device.address)
            .then((_connection) {
          print('Connected to the device');
          connection = _connection;
          setState(() {
            _connected = true;
          });

          connection.input.listen(null).onDone(() {
            if (isDisconnecting) {
              print('Disconnecting locally!');
            } else {
              print('Disconnected remotely!');
            }
            if (this.mounted) {
              setState(() {});
            }
          });
        }).catchError((error) {
          print('Cannot connect, exception occurred');
          print(error);
        });
        show('연결 완료');

        setState(() => _isButtonUnavailable = false);
      }
    }
  }

  // void _onDataReceived(Uint8List data) {
  //   // Allocate buffer for parsed data
  //   int backspacesCounter = 0;
  //   data.forEach((byte) {
  //     if (byte == 8 || byte == 127) {
  //       backspacesCounter++;
  //     }
  //   });
  //   Uint8List buffer = Uint8List(data.length - backspacesCounter);
  //   int bufferIndex = buffer.length;

  //   // Apply backspace control character
  //   backspacesCounter = 0;
  //   for (int i = data.length - 1; i >= 0; i--) {
  //     if (data[i] == 8 || data[i] == 127) {
  //       backspacesCounter++;
  //     } else {
  //       if (backspacesCounter > 0) {
  //         backspacesCounter--;
  //       } else {
  //         buffer[--bufferIndex] = data[i];
  //       }
  //     }
  //   }
  // }

  // Method to disconnect bluetooth
  void _disconnect() async {
    setState(() {
      _isButtonUnavailable = true;
      _deviceState = 0;
    });

    await connection.close();
    show('연결이 안됨');
    if (!connection.isConnected) {
      setState(() {
        _connected = false;
        _isButtonUnavailable = false;
      });
    }
  }

  // Method to send message,
  // for turning the Bluetooth device on
  void _sendOnMessageToBluetooth() async {
    connection.output.add(utf8.encode("1" + "\r\n"));
    await connection.output.allSent;
    show('Device Turned On');
    setState(() {
      _deviceState = 1; // device on
    });
  }

  // Method to send message,
  // for turning the Bluetooth device off
  void _sendOffMessageToBluetooth() async {
    connection.output.add(utf8.encode("0" + "\r\n"));
    await connection.output.allSent;
    show('Device Turned Off');
    setState(() {
      _deviceState = -1; // device off
    });
  }

  // Method to show a Snackbar,
  // taking message as the text
  Future show(
      String message, {
        Duration duration: const Duration(seconds: 3),
      }) async {
    await new Future.delayed(new Duration(milliseconds: 100));
    _scaffoldKey.currentState.showSnackBar(
      new SnackBar(
        content: new Text(
          message,
        ),
        duration: duration,
      ),
    );
  }
}