import 'package:flutter/material.dart';

import '../Screens/home.dart';
import '../Screens/qiblah_screen.dart';

enum MenuState { home, qiblah }

class CustomBottomNavBar extends StatelessWidget with ChangeNotifier {
  CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    const Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 25, 63),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  icon: const Icon(Icons.home),
                  color: MenuState.home == selectedMenu
                      ? Colors.orange
                      : inActiveIconColor,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const MyHomePage()));
                  }),
              IconButton(
                  icon: const Icon(Icons.upload),
                  color: MenuState.qiblah == selectedMenu
                      ? Colors.orange
                      : inActiveIconColor,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const QiblahScreen()));
                  }),
            ],
          )),
    );
  }
}
