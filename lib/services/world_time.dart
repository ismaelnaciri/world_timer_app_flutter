import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class WorldTime {

  String location;
  late String time;
  String flagUrl;
  String endPoint; //location url for api endpoint

  late bool isDayTime;


  WorldTime({ required this.location, required this.flagUrl, required this.endPoint });

  Future<void> getTime() async {
    try {
      var url = Uri.https('worldtimeapi.org', 'api/timezone$endPoint');
      Response response = await get(url);
      Map data = jsonDecode(response.body);
      var datetime = data["datetime"];
      var offsetString = data["utc_offset"].toString();
      var offset = Duration(hours: int.parse(offsetString.substring(0, 3)));
      DateTime now = DateTime.parse(datetime);
      now = now.add(offset);

      isDayTime = now.hour > 6 && now.hour < 20;
      initializeDateFormatting("es");
      Intl.defaultLocale = 'es';

      String formattedTime = DateFormat('HH:mm').format(now);
      time = formattedTime;

      print("time: $now");
    } catch (e) {
      print("Error getting the data from this url: $e");
      time = "could not get time data";
    }
  }

}