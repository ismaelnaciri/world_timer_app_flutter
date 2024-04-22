import 'package:flutter/material.dart';
import 'package:world_timer_app_flutter/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locations = [
    WorldTime(endPoint: '/Europe/London', location: 'London', flagUrl: 'uk.png'),
    WorldTime(endPoint: '/Europe/Berlin', location: 'Athens', flagUrl: 'greece.png'),
    WorldTime(endPoint: '/Africa/Cairo', location: 'Cairo', flagUrl: 'egypt.png'),
    WorldTime(endPoint: '/Africa/Nairobi', location: 'Nairobi', flagUrl: 'kenya.png'),
    WorldTime(endPoint: '/America/Chicago', location: 'Chicago', flagUrl: 'usa.png'),
    WorldTime(endPoint: '/America/New_York', location: 'New York', flagUrl: 'usa.png'),
    WorldTime(endPoint: '/Asia/Seoul', location: 'Seoul', flagUrl: 'south_korea.png'),
    WorldTime(endPoint: '/Asia/Jakarta', location: 'Jakarta', flagUrl: 'indonesia.png'),
    WorldTime(endPoint: '/Europe/Madrid', location: 'Spain', flagUrl: 'spain.png'),
  ];

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();
    Navigator.pop(context, {
      "time": instance.time,
      "location": instance.location,
      "flag": instance.flagUrl,
      'isDaytime': instance.isDayTime,
    });
  }

  @override
  Widget build(BuildContext context) {
    locations.sort((a, b) => a.location.compareTo(b.location));

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text("Choose a location"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder (
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              color: Colors.grey[300],
              child: ListTile(
                onTap: () {
                  updateTime(index);
                },
                title: Text(
                  locations[index].location,
                ),
                leading: CircleAvatar(
                  backgroundImage: AssetImage("assets/${locations[index].flagUrl}"),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
