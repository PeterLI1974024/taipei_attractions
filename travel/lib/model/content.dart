import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Content extends ChangeNotifier {
  int _selectedIndex = 0;
  String _text = '旅遊景點';
  List<IconData> icons = [
    Icons.synagogue,
    Icons.restaurant,
    Icons.local_library,
    Icons.shopping_bag,
  ];
  List<Text> iconName = [Text('寺廟'), Text('食物'), Text('藝術'), Text('購物')];

  get selectedIndex => _selectedIndex;
  get text => _text;
  Widget buildIcon(int index) {
    return Padding(
      padding: const EdgeInsets.all(19.1),
      child: Column(
        children: [
          GestureDetector(
            onTap: (() {
              _selectedIndex = index;
              _text = iconName[index].data.toString();
              ;
              notifyListeners();
            }),
            child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: _selectedIndex == index
                        ? Color.fromARGB(255, 148, 183, 202)
                        : Color(0xFFE7EBEE)),
                child: Icon(
                  icons[index],
                  color: selectedIndex == index
                      ? Color.fromARGB(255, 241, 243, 245)
                      : Color(0xFFB4C1C4),
                  size: 35,
                )),
          ),
          iconName[index]
        ],
      ),
    );
  }
}
