import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:farmertoconsumer/screens/profile/profile.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color color;

  CustomAppBar({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color,
      iconTheme: IconThemeData(color: Colors.white),
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back-arrow-2.svg', // Path to your custom SVG icon
          height: 20.0, // Optional: Set the height of the icon
          width: 20.0,  // Optional: Set the width of the icon
        ), // Customize the icon here (e.g., custom back arrow)
        onPressed: () {
          Navigator.pop(context);
        },
      ),
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
        GestureDetector(
          onTap: () {
            // Add your onTap functionality here
            print('Icon clicked');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SvgPicture.asset(
              'assets/icons/customer-icon.svg',
              width: 20.0,
              height: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40.0);
}
