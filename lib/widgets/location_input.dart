import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:path/path.dart' as path;
import 'package:place_app/helpers/location_helper.dart';
import 'package:place_app/screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;
  LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _preivewImageUrl;

  void _showPreview(double lat, double lng) {
    print(lat);
    print(lng);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Location Selected'),
      ),
    );
    // final staticMapImageUrl = LocationHelper.genrateLocationPreviewImage(
    //   latitude: lat,
    //   longitude: lng,
    // );

    // setState(() {
    //   _preivewImageUrl = staticMapImageUrl;
    // });
  }

  Future<void> _getCurrentLocation() async {
    try {
      final locData = await Location().getLocation();
      _showPreview(locData.latitude!, locData.longitude!);
      widget.onSelectPlace(locData.latitude, locData.longitude);
    } catch (error) {
      return;
    }
    //print('latitude : ${locData.latitude}');
    //print('longitude : ${locData.longitude}');
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 2.5,
              color: Theme.of(context).primaryColor,
            ),
          ),
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          child: _preivewImageUrl == null
              // ignore: prefer_const_constructors
              ? Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _preivewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: _getCurrentLocation,
              //color: Theme.of(context).accentColor,
              //textColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
            ),
            SizedBox(
              width: 10,
            ),
            ElevatedButton.icon(
              onPressed: _selectOnMap,
              //color: Theme.of(context).accentColor,
              //textColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
            )
          ],
        )
      ],
    );
  }
}
