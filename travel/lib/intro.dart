import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'attraction.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 199, 223, 234),
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/taipeidoor.png'),
            Text(
              'Explore the beauty of Taipei city',
              style: GoogleFonts.paprika(
                fontSize: 22,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
                'we will show you all the popular attractions in Taiepi'),
            const SizedBox(
              height: 150,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return Attraction();
                })));
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 97, 146, 174),
                      borderRadius: BorderRadius.circular(40)),
                  padding:
                      EdgeInsets.only(top: 20, bottom: 20, right: 40, left: 40),
                  child: Icon(
                    Icons.double_arrow,
                    size: 35,
                    color: Colors.white,
                  )),
            ),
          ],
        )));
  }
}
