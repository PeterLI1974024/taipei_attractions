import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'model/attraction_detail.dart';
import 'component/indicator.dart';

class Description extends StatefulWidget {
  final String introduction;
  final String name;
  final String address;
  final String destric;
  final String telephone;
  final String remind;
  final String url;
  final image;

  Description(
      {required this.name,
      required this.address,
      required this.destric,
      required this.telephone,
      required this.image,
      required this.introduction,
      required this.remind,
      required this.url,
      super.key});

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description>
    with TickerProviderStateMixin {
  int _activePage = 0;
  final PageController pageController = PageController();
  final imageContainer = [];
  void getImage() {
    for (var eachImage in widget.image) {
      imageContainer.add(eachImage['src']);
    }
    print(imageContainer.length);
  }

  @override
  void initState() {
    getImage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(66, 242, 238, 238),
                    offset: Offset(0.0, 2.0),
                    blurRadius: 6.0),
              ]),
          child: Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
              child: PageView.builder(
                  controller: pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _activePage = page;
                    });
                  },
                  itemCount: imageContainer.length,
                  itemBuilder: ((context, index) {
                    return Image.network(
                      imageContainer[index + 1],
                      fit: BoxFit.cover,
                    );
                  })),
            ),
            SliderIndicator(
                imageContainer: imageContainer,
                pageController: pageController,
                activePage: _activePage)
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            child: Align(
              child: TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey[500],
                  indicatorColor: Color.fromARGB(255, 211, 189, 124),
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: tabController,
                  tabs: [
                    Tab(
                      text: '場景資訊',
                    ),
                    Tab(
                      text: '旅遊介紹',
                    )
                  ]),
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 236, 234, 230),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
            child: TabBarView(controller: tabController, children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(fontSize: 26),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.destric,
                        style: TextStyle(fontSize: 18),
                      ),
                      widget.remind.isNotEmpty
                          ? const SizedBox(
                              height: 10,
                            )
                          : SizedBox(
                              height: 0,
                            ),
                      widget.remind.isNotEmpty
                          ? Icon(
                              Icons.info,
                              color: Color.fromARGB(255, 187, 159, 75),
                            )
                          : SizedBox(height: 0),
                      Text(
                        widget.remind,
                        style: TextStyle(fontSize: 20),
                      ),
                      widget.remind.isNotEmpty
                          ? SizedBox(height: 10)
                          : SizedBox(
                              height: 0,
                            ),
                      Icon(
                        Icons.explore,
                        color: Color.fromARGB(255, 176, 160, 115),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.address,
                        style: TextStyle(fontSize: 18),
                      ),
                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        print('pressed');
                                        final Uri url = Uri(
                                            scheme: 'tel',
                                            path: widget.telephone);
                                        await launch(url.toString());
                                      },
                                      icon: Icon(Icons.call,
                                          size: 30,
                                          color: Color.fromARGB(
                                              255, 162, 119, 115)),
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          final Uri url = Uri(
                                              scheme: 'link', path: widget.url);
                                          await launch(url.toString());
                                        },
                                        icon: Icon(
                                          Icons.home,
                                          size: 30,
                                          color: Color.fromARGB(
                                              255, 162, 119, 115),
                                        ))
                                  ],
                                )
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    widget.introduction,
                    style: GoogleFonts.nunito(fontSize: 22),
                  ),
                ),
              ),
            ]),
          ),
        )
      ],
    ));
  }
}
