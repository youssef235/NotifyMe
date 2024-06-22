import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notify_me/Services/NotificationServices/initialization.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';
import 'package:adhan/adhan.dart';
import 'package:geolocator/geolocator.dart';

class PrayersTimes {
  String fajr = '';
  Initialization notificationService = Initialization();
  Future<Map<String, dynamic>> getPrayerTimes() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final myCoordinates = Coordinates(position.longitude, position.latitude);
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;
    final prayerTimes = PrayerTimes.today(myCoordinates, params);

    String FagrTime = DateFormat.jm().format(prayerTimes.fajr);
    String SunriseTime = DateFormat.jm().format(prayerTimes.sunrise);
    String DhuhrTime = DateFormat.jm().format(prayerTimes.dhuhr);
    String AsrTime = DateFormat.jm().format(prayerTimes.asr);
    String MaghribTime = DateFormat.jm().format(prayerTimes.maghrib);
    String IshaTime = DateFormat.jm().format(prayerTimes.isha);

    final currenttime = DateTime.now();

    fajr = DateFormat.jm().format(prayerTimes.fajr);

    if (prayerTimes.fajr.toLocal().isAfter(currenttime)) {
      schedulePrayerTimeNotification(prayerTimes.fajr.toLocal(), 'الفجر');
    }

    if (prayerTimes.dhuhr.toLocal().isAfter(currenttime)) {
      schedulePrayerTimeNotification(prayerTimes.dhuhr.toLocal(), 'الظهر');
    }

    if (prayerTimes.asr.toLocal().isAfter(currenttime)) {
      schedulePrayerTimeNotification(prayerTimes.asr.toLocal(), 'العصر');
    }

    if (prayerTimes.maghrib.toLocal().isAfter(currenttime)) {
      schedulePrayerTimeNotification(prayerTimes.maghrib.toLocal(), 'المغرب');
    }

    if (prayerTimes.isha.toLocal().isAfter(currenttime)) {
      schedulePrayerTimeNotification(prayerTimes.isha.toLocal(), 'العشاء');
    }
    Map<String, dynamic> data = {
      "FagrTime": FagrTime,
      "SunriseTime": SunriseTime,
      "DhuhrTime": DhuhrTime,
      "AsrTime": AsrTime,
      "MaghribTime": MaghribTime,
      "IshaTime": IshaTime,
    };
    return data;
  }

  void schedulePrayerTimeNotification(
      DateTime prayerTime, String prayerName) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'id',
      'name',
      channelDescription: "prayer",
      importance: Importance.max,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('adan'),
      priority: Priority.max,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    final formattedTime = DateFormat('h:mm a').format(prayerTime);

    await notificationService.flutterLocalNotificationsPlugin.zonedSchedule(
      prayerName.hashCode,
      'Prayer Time',
      ' حان الآن موعداذان $prayerName',
      tz.TZDateTime.from(prayerTime, tz.local),
      notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
