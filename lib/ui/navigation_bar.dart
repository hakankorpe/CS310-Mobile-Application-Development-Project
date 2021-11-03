import 'package:cs310_footwear_project/routes/profile_view.dart';
import 'package:flutter/material.dart';

class NavigationBar extends StatefulWidget {
  int index;
  NavigationBar({Key? key, required this.index}) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  NavigationBar get widget => super.widget;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: widget.index,
      selectedItemColor: Colors.black,
      selectedFontSize: 13,
      selectedIconTheme: const IconThemeData(
        color: Colors.black,
        size: 27,
      ),
      unselectedItemColor: Colors.grey,
      unselectedFontSize: 10,
      unselectedIconTheme: const IconThemeData(
        color: Colors.grey,
        size: 24,
      ),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
          ),
          label: "Search",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.category,
          ),
          label: "Category",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.account_circle,
          ),
          label: "Profile",
        ),
      ],
      onTap: (index) {
        setState(() {
          if (widget.index != index) {
            switch (index) {
              case 0:
                Navigator.pushNamedAndRemoveUntil(
                    context, "/home", (route) => false);
                break;
              case 1:
                Navigator.pushNamedAndRemoveUntil(
                    context, "/search", (route) => false);
                break;
              case 2:
                Navigator.pushNamedAndRemoveUntil(
                    context, "/categoryMain", (route) => false);
                break;
              case 3:
                Navigator.pushNamedAndRemoveUntil(
                    context, "/profile", (route) => false);
            }
          }
        });
      },
    );
  }
}
