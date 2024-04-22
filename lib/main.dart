import 'package:flutter/material.dart';
import 'package:world_timer_app_flutter/pages/choose_location.dart';
import 'package:world_timer_app_flutter/pages/home.dart';
import 'package:world_timer_app_flutter/pages/loading.dart';

void main() => runApp(MaterialApp(
  // home: Home(),
  routes: {
    '/': (context) => Loading(),
    '/home': (context) => Home(),
    '/location': (context) => ChooseLocation()
  },
));

