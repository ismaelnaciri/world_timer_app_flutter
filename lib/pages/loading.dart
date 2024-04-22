import 'package:flutter/material.dart';
import 'package:world_timer_app_flutter/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late Future<void> _setupWorldTimeFuture;
  bool _initComplete = false;

  @override
  void initState() {
    super.initState();
    _setupWorldTimeFuture = setupWorldTime();
  }

  Future<void> setupWorldTime() async {
    try {
      WorldTime instance = WorldTime(
        location: "Berlin",
        flagUrl: "germany.png",
        endPoint: "/Europe/Berlin",
      );
      await instance.getTime();
      _initComplete = true;
      if (_initComplete) {
        Navigator.pushReplacementNamed(context, "/home", arguments: {
          "time": instance.time,
          "location": instance.location,
          "flag": instance.flagUrl,
          'isDaytime': instance.isDayTime,
        });
      }
    } catch (e) {
      print("Error setting up world time: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 80.0,
        ),
      )
    );
  }
}
