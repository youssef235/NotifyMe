import 'package:flutter/material.dart';
import 'Services/NotificationServices/initialization.dart';

import 'Screens/home.dart';
import 'Services/NotificationServices/prayer_times.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // to initialize the notificationservice.
  Initialization().initNotification();
  PrayersTimes().getPrayerTimes();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(),
    );
  }
}
