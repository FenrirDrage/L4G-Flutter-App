import 'package:flutter/material.dart';
import 'package:projeto/pages/addEvent.dart';
import 'package:projeto/pages/myEvent.dart';
import 'package:projeto/pages/home.dart';
import 'package:projeto/pages/profile.dart';

// ignore: must_be_immutable
class BaseWidget extends StatefulWidget {
  int currentPageIndex;

  BaseWidget({Key? key, required this.currentPageIndex}) : super(key: key);

  @override
  State<BaseWidget> createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        HomeScreen(),
        MyEvents(),
        AddEvent(),
        Profile()
      ][widget.currentPageIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color(0xFF000B45),
        ),
        child: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: widget.currentPageIndex,
          onTap: (index) {
            setState(() {
              widget.currentPageIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon:
                  buildIconWithCircle(Icons.home, widget.currentPageIndex == 0),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: buildIconWithCircle(
                  Icons.gamepad_rounded, widget.currentPageIndex == 1),
              label: 'My Events',
            ),
            BottomNavigationBarItem(
              icon:
                  buildIconWithCircle(Icons.add, widget.currentPageIndex == 2),
              label: 'Add Events',
            ),
            BottomNavigationBarItem(
              icon: buildIconWithCircle(
                  Icons.person, widget.currentPageIndex == 3),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIconWithCircle(IconData icon, bool isSelected) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (isSelected)
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              shape: BoxShape.rectangle,
              color: Colors.white,
            ),
          ),
        Icon(icon, color: isSelected ? Color(0XFF000B45) : Colors.white),
      ],
    );
  }
}
