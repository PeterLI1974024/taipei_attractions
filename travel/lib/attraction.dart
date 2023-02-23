import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model/attraction_detail.dart';
import 'component/pageview_tile.dart';
import 'component/gridview_tile.dart';
import 'description.dart';
import 'package:provider/provider.dart';
import 'model/content.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Attraction extends StatefulWidget {
  const Attraction({super.key});

  @override
  State<Attraction> createState() => _AttractionState();
}

class _AttractionState extends State<Attraction> {
  bool hasMore = true;
  final controller = ScrollController();
  List<AttractionDetail> attractionDetails = [];

  final String requestUrl =
      'https://www.travel.taipei/open-api/zh-tw/Attractions/All?categoryIds=17&page=1';
  Future getRecommend() async {
    final response = await http
        .get(Uri.parse(requestUrl), headers: {'accept': 'application/json'});
    final recommendData = jsonDecode(response.body);

    for (var eachAttraction in recommendData['data']) {
      final recommendDetail = AttractionDetail(
          id: eachAttraction['id'],
          name: eachAttraction['name'],
          introduction: eachAttraction['introduction'],
          destric: eachAttraction['distric'],
          tele: eachAttraction['tel'],
          images: eachAttraction['images'],
          address: eachAttraction['address'],
          remind: eachAttraction['remind'],
          url: eachAttraction['url']);

      attractionDetails.add(recommendDetail);
    }
  }

  @override
  void initState() {
    getRecommend();
    Provider.of<Content>(context, listen: false).getAttraction();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        Provider.of<Content>(context, listen: false).page++;
        Provider.of<Content>(context, listen: false).getAttraction();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 237, 242, 245),
        body: SafeArea(child: Consumer<Content>(
          builder: ((context, content, child) {
            return Column(
              children: [
                Container(
                  width: 400,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '找尋台北最美景點?',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.notoSans(fontSize: 30),
                      ),
                      Row(
                        children: [
                          content.buildIcon(0),
                          content.buildIcon(1),
                          content.buildIcon(2),
                          content.buildIcon(3)
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '推薦行程',
                          style: GoogleFonts.sail(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '更多',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 115, 162, 203)),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  height: 200,
                  decoration:
                      BoxDecoration(color: Color.fromARGB(255, 243, 241, 235)),
                  child: PageView.builder(
                      controller: PageController(viewportFraction: 0.8),
                      itemCount: attractionDetails.length,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: ((context) {
                              return Description(
                                image: attractionDetails[index].images,
                                name: attractionDetails[index].name,
                                destric: attractionDetails[index].destric,
                                introduction:
                                    attractionDetails[index].introduction,
                                telephone: attractionDetails[index].tele,
                                address: attractionDetails[index].address,
                                remind: attractionDetails[index].remind,
                                url: attractionDetails[index].url,
                              );
                            })));
                          },
                          child: PageViewTile(
                            image: attractionDetails[index].images[0]['src'],
                            destric: attractionDetails[index].destric,
                            name: attractionDetails[index].name,
                          ),
                        );
                      })),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '${content.text}',
                        style: GoogleFonts.sail(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 244, 242, 238)),
                    child: content.attractionDetailForGrid.isNotEmpty
                        ? GridView.builder(
                            controller: controller,
                            semanticChildCount:
                                content.attractionDetailForGrid.length,
                            itemCount:
                                content.attractionDetailForGrid.length + 1,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: ((context, index) {
                              if (index <
                                  content.attractionDetailForGrid.length) {
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: ((context) {
                                        return Description(
                                          image: content
                                              .attractionDetailForGrid[index]
                                              .images,
                                          name: content
                                              .attractionDetailForGrid[index]
                                              .name,
                                          destric: content
                                              .attractionDetailForGrid[index]
                                              .destric,
                                          introduction: content
                                              .attractionDetailForGrid[index]
                                              .introduction,
                                          telephone: content
                                              .attractionDetailForGrid[index]
                                              .tele,
                                          address: content
                                              .attractionDetailForGrid[index]
                                              .address,
                                          remind: content
                                              .attractionDetailForGrid[index]
                                              .remind,
                                          url: content
                                              .attractionDetailForGrid[index]
                                              .url,
                                        );
                                      })));
                                    },
                                    child: GridViewTile(
                                        name: content
                                            .attractionDetailForGrid[index]
                                            .name,
                                        destric: content
                                            .attractionDetailForGrid[index]
                                            .destric,
                                        image: content
                                            .attractionDetailForGrid[index]
                                            .images[0]['src']));
                              } else {
                                print(content.attractionDetailForGrid.length);
                                return hasMore
                                    ? Center(child: CircularProgressIndicator())
                                    : Text('no more data');
                              }
                              ;
                            }))
                        : Center(
                            child: SpinKitCircle(
                            color: Color.fromARGB(255, 208, 190, 26),
                            size: 50,
                          )),
                  ),
                )
              ],
            );
          }),
        )));
  }
}
