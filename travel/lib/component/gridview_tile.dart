import 'package:flutter/material.dart';

class GridViewTile extends StatelessWidget {
  final String name;
  final String destric;
  final image;
  const GridViewTile(
      {super.key,
      required this.name,
      required this.destric,
      required this.image});

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
    ;
  }
}
