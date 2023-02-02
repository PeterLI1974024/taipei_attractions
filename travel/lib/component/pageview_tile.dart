import 'package:flutter/material.dart';

class PageViewTile extends StatelessWidget {
  final image;
  final String name;
  final String destric;

  const PageViewTile(
      {required this.image, required this.name, required this.destric});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          image:
              DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              Text(
                destric,
                style: TextStyle(fontSize: 16, color: Colors.white),
              )
            ]),
      ),
    );
  }
}
