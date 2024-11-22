import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color customGreen;

  CustomAppBar({required this.title, required this.customGreen});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: customGreen,
      iconTheme: IconThemeData(color: Colors.white),
      toolbarHeight: 60.0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end, // Align the title to the right
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SvgPicture.asset(
            'assets/icons/customer-icon.svg',
            width: 20.0,
            height: 20.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40.0);
}
