import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'model/attraction_detail.dart';
import 'component/indicator.dart';

class Description extends StatefulWidget {
  final String introduction;
  final String name;
  //  final String address;
  final String destric;
  //  final String telephone;
  final image;

  Description(
      {required this.name,
      // required this.address,
      required this.destric,
      // required this.telephone,
      required this.image,
      required this.introduction,
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
            height: 300,
            child: TabBarView(controller: tabController, children: [
              Container(
                width: MediaQuery.of(context).size.width,
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
