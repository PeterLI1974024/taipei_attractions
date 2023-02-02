import 'package:flutter/material.dart';

class PictureIcon extends StatelessWidget {
  IconData icon;
  final String text;
  PictureIcon({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(19.1),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  color: Color.fromARGB(255, 148, 183, 202)),
              child: Icon(
                color: Color.fromARGB(255, 241, 243, 245),
                icon,
                size: 35,
              ),
            ),
          ),
          Text(text)
        ],
      ),
    );
  }
}
