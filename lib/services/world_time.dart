import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the UI
  String time; // time in location
  String flag; // url to an asset flag icon
  String url; // location url to the API endpoint
  bool isDaytime; // true or false if daytime or not

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      // Make request
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      // print(data);

      // Get properties
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0, 3);

      // Create datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // Set time property
      isDaytime = now.hour >= 6 && now.hour <= 19;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('Caught error: $e');
      time = 'Error - could not retrieve time data';
    }
  }
}
