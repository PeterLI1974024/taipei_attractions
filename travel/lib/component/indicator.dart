import 'package:flutter/material.dart';

class SliderIndicator extends StatelessWidget {
  const SliderIndicator({
    Key? key,
    required this.imageContainer,
    required this.pageController,
    required int activePage,
  })  : _activePage = activePage,
        super(key: key);

  final List imageContainer;
  final PageController pageController;
  final int _activePage;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        height: 50,
        child: Container(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                  imageContainer.length - 1,
                  (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: InkWell(
                            onTap: () {
                              pageController.animateToPage(index,
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.easeIn);
                            },
                            child: CircleAvatar(
                              radius: 6,
                              backgroundColor: _activePage == index
                                  ? Color.fromARGB(255, 255, 213, 1)
                                  : Colors.white,
                            )),
                      ))),
        ));
  }
}
