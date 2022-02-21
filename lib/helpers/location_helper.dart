import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

const GOOGLE_API_KEY = 'AIzaSyDCNCbGegHrGH0sOJD-458sUuMINImERcQ';

class LocationHelper {
  static String genrateLocationPreviewImage(
      {double? latitude, double? longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
    final Response = await http.get(Uri.parse(url));
    return jsonDecode(Response.body)['results'][0]['formatted_address'];
  }
}

//AIzaSyBg9yn5JtQgKRFbg6FCTy4ewbF24kRuAYI

//my
//AIzaSyCN6RmSjyei4ds_bUIgRSrQZyKi6hYKX0g