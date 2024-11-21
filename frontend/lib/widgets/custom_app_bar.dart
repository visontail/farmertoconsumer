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
      toolbarHeight: 40.0,
      title: Text(
        title,
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            'assets/icons/logo.svg',
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
