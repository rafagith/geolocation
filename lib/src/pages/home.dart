import 'package:flutter/material.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var location = new Location();
  bool _loading = false;
  String _coordinates = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Geolocation'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _coordinates == null
                ? CircularProgressIndicator()
                : Text(_coordinates),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                shape: CircleBorder(),
                child: Icon(Icons.gps_not_fixed, size: 35.0),
                onPressed: !this._loading
                    ? () {
                        setState(() {
                          this._loading = true;
                          this._coordinates = null;
                        });
                        this._getLocation().then((userLocation) {
                          setState(() {
                            this._coordinates =
                                'Location =>  latitude: ${userLocation.latitude.toString()} longitude: ${userLocation.longitude.toString()}';
                            this._loading = false;
                          });
                        });
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<LocationData> _getLocation() async {
    return location.getLocation();
  }
}