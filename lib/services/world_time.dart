import 'package:http/http.dart';
import 'dart:convert';

class WorldTime {
  String location; // location name for the UI
  String time; // time in location
  String flag; // url to an asset flag icon
  String url; // location url to the API endpoint

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    // Make request
    Response response = await get('http://worldtimeapi.org/api/timezone/$url');
    Map data = jsonDecode(response.body);

    // print(data);

    // Get properties
    String datetime = data['datetime'];
    String offset = data['utc_offset'].substring(1, 3);

    // Create datetime object
    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset)));
    // Set time property
    time = now.toString();
  }
}