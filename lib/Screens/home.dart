import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import '../Services/NotificationServices/initialization.dart';
import '../Services/NotificationServices/prayer_times.dart';
import '../Widgets/nav_bar.dart';
import '../Widgets/prayer_time_box.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Initialization notificationService = Initialization();
  PrayersTimes prayersTimes = PrayersTimes();
  // late PrayerTimes prayerTimes;
  Future<Map<String, dynamic>>? futureData;

  @override
  initState() {
    super.initState();
    tz.initializeTimeZones();
    futureData = prayersTimes.getPrayerTimes();
  }

  final currenttime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 35, 73),
      appBar: AppBar(
        title: const Text(
          "ذكـــرنــي",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 0, 25, 63),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Center(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: 60,
                          width: 300,
                          child: ElevatedButton(
                            onPressed: () {
                              prayersTimes.getPrayerTimes();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 0, 25, 63)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    'تنبيه عند موعد الصلاة',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Icon(
                                  Icons.alarm,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        pTbox("أذان الفجر", snapshot.data!['FagrTime']),
                        pTbox("الشروق", snapshot.data!['SunriseTime']),
                        pTbox("أذان الظهر", snapshot.data!['DhuhrTime']),
                        pTbox("أذان العصر", snapshot.data!['AsrTime']),
                        pTbox("أذان المغرب", snapshot.data!['MaghribTime']),
                        pTbox("أذان العشاء", snapshot.data!['IshaTime']),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const Center(child: Text("LOADING ..."));
        },
        future: futureData,
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
