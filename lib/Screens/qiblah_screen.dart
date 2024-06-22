import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:notify_me/Services/QiblahServices/qiblah_compass.dart';

import '../Widgets/nav_bar.dart';

class QiblahScreen extends StatefulWidget {
  const QiblahScreen({super.key});

  @override
  State<QiblahScreen> createState() => _QiblahScreenState();
}

class _QiblahScreenState extends State<QiblahScreen> {
  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "قـبلةالصـــلاة",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 0, 25, 63),
      ),
      //   backgroundColor: Color.fromARGB(255, 0, 35, 73),
      body: FutureBuilder(
        future: _deviceSupport,
        builder: (_, AsyncSnapshot<bool?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error.toString()}"),
            );
          }
          if (snapshot.data!) {
            return QiblahCompass();
          } else {
            return const Center(
              child: Text("Your device is not supported"),
            );
          }
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.qiblah),
    );
  }
}
