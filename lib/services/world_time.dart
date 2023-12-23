import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  late String time;
  late String flag;
  late String url;
  late bool isDaytime;

  WorldTime({required this.location, required this.flag, required this.url});
  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        // print(data);
        String datetime = data['datetime'];
        String offsetString = data['utc_offset'];

        // Parse the offset string to get the hours and minutes.
        int hours = int.parse(offsetString.substring(1, 3)); // Extract hours
        int minutes = int.parse(offsetString.substring(4));
        int offset = (offsetString[0] == '+')
            ? hours
            : -hours; // Determine sign based on offsetString[0]

        DateTime now = DateTime.parse(datetime);
        now = now.add(Duration(hours: offset, minutes: minutes));
        isDaytime = now.hour > 6 && now.hour <= 18;
        // isDaytime = datetime.contains("AM") &&
        //     now.hour > 6 &&
        //     datetime.contains("PM") &&
        //     now.hour < 6;
        time = DateFormat.jm().format(now);
      } else {
        print('Failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle HTTP request error
      print('Error fetching data: $error');
      time = 'Unable to get time data';
    }
  }
}
