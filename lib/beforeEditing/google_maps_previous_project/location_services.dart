/*

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LocationServices {
AIzaSyCWjJ5ak4lUEwI2ruUvbYk6NuHoN6dgVp4
  final String key = "AIzaSyCLh1CD87NOueRMsxZB-xNJJLuAtCRM6Os";
  final String key1 = "AIzaSyCAIwTPctnSM2PWcbK6cMdlZaSgEYIKp5U";

  Future<String> getPlaceId(String input) async {
    print("0");

    String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key1';

    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);
    print("1");
    print("${json} Json");
    print("2");

    var placeId = json['candidates'][0]['place_id'] as String;

    print("${placeId} ]]]]]]]]]]LLLllllllllLLLLLLLLLLLLLLLLLLL");

    return placeId;
  }

  Future<Map<String, dynamic>> getPlace(String input) async {
    final placeId = await getPlaceId(input);

    String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';
    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);

    var result = json['result'] as Map<String, dynamic>;

    print(result);
    return result;
  }

  Future<void> getDirections(String origin, String destination) async {
    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&key=$key';

    var response = await http.get(Uri.parse(url));
    var json =  convert.jsonDecode(response.body);

    print(json);


  }
}

*/
