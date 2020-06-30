import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Gps extends StatefulWidget {
  @override
  _GpsState createState() => _GpsState();
}

class _GpsState extends State<Gps> {
  //최초 위치
  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(37.5331327, 126.9543673),
    zoom: 14.4746,
  );

  double latitude;
  double longitude;
  GoogleMapController _controller;
  Position position;
  Set<Circle> _circles = HashSet<Circle>();
  final Map<String, Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    Future.delayed(Duration(seconds:3), () => _moveToCurrentLocation());
  }

  //현재 위치 가져오기
  Future<void> _getCurrentLocation() async {
    position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print('position : ${position}');

    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId("current"),
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(title: '현재 위치'),
      );
      _markers["Current Location"] = marker;
      _setCircles();
    });
  }

  //현재 위치로 카메라 이동
  void _moveToCurrentLocation() {
    setState(() {
      _controller
          .animateCamera(CameraUpdate.newLatLng(LatLng(latitude, longitude)));
    });
  }

  //현재 위치 반경 표시
  void _setCircles() {
    _circles.add(
      Circle(
          circleId: CircleId("0"),
          center: LatLng(latitude, longitude),
          radius: 300,
          strokeWidth: 1,
          fillColor: Color.fromRGBO(102, 51, 153, .5)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Gps',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 40),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: initialLocation,
              markers: _markers.values.toSet(),
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
              },
              zoomControlsEnabled: false,
              circles: _circles,
            ),
          ),
          Text('현재 위치가 지도상의 반경과 일치합니까?', style: TextStyle(fontSize: 18.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 100,
                width: 100,
                margin: EdgeInsets.all(20),
                child: RaisedButton(
                  onPressed: () {
                    //TODO - 일치할 때 로직
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  color: Colors.cyan,
                  child: Icon(Icons.done, size: 50, color: Colors.white),
                ),
              ),
              Container(
                height: 100,
                width: 100,
                margin: EdgeInsets.all(20),
                child: RaisedButton(
                  onPressed: () {
                    //TODO - 불일치할 때 로직
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  color: Colors.red,
                  child: Icon(Icons.close, size: 50, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          FloatingActionButton(
            child: Icon(Icons.location_searching),
            onPressed: () {
              _moveToCurrentLocation();
            },
            tooltip: '현재 위치로',
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
          ),
        ],
      ),
    );
  }
}
