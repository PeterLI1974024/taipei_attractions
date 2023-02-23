import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:travel/model/attraction_detail.dart';

class Content extends ChangeNotifier {
  List<AttractionDetail> attractionDetailForGrid = [];

  int _selectedIndex = 0;
  int page = 1;
  String _requestedUrl =
      'https://www.travel.taipei/open-api/zh-tw/Attractions/All?page=1';
  String _text = '旅遊景點';
  List<IconData> icons = [
    Icons.synagogue,
    Icons.restaurant,
    Icons.local_library,
    Icons.shopping_bag,
  ];
  List<Text> iconName = [Text('寺廟'), Text('食物'), Text('藝術'), Text('購物')];
  List<String> categoryIds = [
    'https://www.travel.taipei/open-api/zh-tw/Attractions/All?categoryIds=14&page=',
    'https://www.travel.taipei/open-api/zh-tw/Attractions/All?categoryIds=144&page=',
    'https://www.travel.taipei/open-api/zh-tw/Attractions/All?categoryIds=15&page=',
    'https://www.travel.taipei/open-api/zh-tw/Attractions/All?categoryIds=145&page='
  ];

  get selectedIndex => _selectedIndex;
  get text => _text;
  get requestedUrl => _requestedUrl;
  Widget buildIcon(int index) {
    return Padding(
      padding: const EdgeInsets.all(19.1),
      child: Column(
        children: [
          GestureDetector(
            onTap: (() {
              _selectedIndex = index;
              _text = iconName[index].data.toString();
              _requestedUrl = categoryIds[index];
              attractionDetailForGrid.clear();
              page = 1;
              getAttraction();
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

  Future<void> getAttraction() async {
    final String requestUrl = requestedUrl + page.toString();
    final response = await http
        .get(Uri.parse(requestUrl), headers: {'accept': 'application/json'});
    final attractionData = jsonDecode(response.body);

    for (var eachAttraction in attractionData['data']) {
      final attractionDetail = AttractionDetail(
          id: eachAttraction['id'],
          name: eachAttraction['name'],
          introduction: eachAttraction['introduction'],
          destric: eachAttraction['distric'],
          tele: eachAttraction['tel'],
          images: eachAttraction['images'],
          address: eachAttraction['address'],
          remind: eachAttraction['remind'],
          url: eachAttraction['url']);
      attractionDetailForGrid.add(attractionDetail);
    }

    attractionDetailForGrid.removeWhere(
      (element) => element.images.isEmpty,
    );

    notifyListeners();
  }
}
