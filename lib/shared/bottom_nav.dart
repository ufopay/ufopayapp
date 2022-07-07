import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  var _pathList = ['/about', '/add_card', '/profile'];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.gift,
            size: 20,
          ),
          label: '首頁',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.plus,
            size: 20,
          ),
          label: '新增',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.circleUser,
            size: 20,
          ),
          label: '我的',
        ),
      ],
      currentIndex: () {
        String p = ModalRoute.of(context)?.settings.name ?? "";
        var idx = _pathList.indexOf(p);
        idx += idx == -1 ? 1 : 0;
        return idx;
      }(),
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: (int index) {
        Navigator.pushReplacementNamed(context, _pathList[index]);
      },
    );
  }
}
