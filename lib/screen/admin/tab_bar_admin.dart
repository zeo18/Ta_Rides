library flutter_tabbar_page;

import 'package:flutter/material.dart';

class TabBarPage extends StatelessWidget {
  final List<PageTabItemModel> pages;
  final bool isSwipable;
  final double tabHeight;
  final bool? distributeTabEvenly;
  final Color? tabBackgroundColor;
  final Alignment tabAlignment;
  final IndexedWidgetBuilder tabitemBuilder;
  final TabPageController controller;

  const TabBarPage(
      {Key? key,
      required this.pages,
      required this.tabitemBuilder,
      required this.controller,
      this.isSwipable = false,
      this.tabHeight = 50,
      this.distributeTabEvenly = true,
      this.tabBackgroundColor = Colors.white,
      this.tabAlignment = Alignment.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          Container(
            color: tabBackgroundColor,
            height: tabHeight,
            child: ValueListenableBuilder(
                valueListenable: controller.tabIndexChanged,
                builder: (context, chils, value) {
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      if (!distributeTabEvenly!) ...[
                        Align(
                            alignment: tabAlignment,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.zero,
                                itemCount: pages.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: tabitemBuilder)),
                      ] else ...[
                        ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.zero,
                            itemCount: pages.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: tabitemBuilder)
                      ]
                    ],
                  );
                }),
          ),
          ValueListenableBuilder(
              valueListenable: controller.tabIndexChanged,
              builder: (context, child, value) {
                return Flexible(
                  child: PageView.builder(
                      itemCount: pages.length,
                      physics: isSwipable
                          ? const BouncingScrollPhysics()
                          : const NeverScrollableScrollPhysics(),
                      controller: controller.pageController,
                      onPageChanged: (index) {
                        controller.tabIndexChanged.value = index;
                        controller.updateIndex(index);
                      },
                      itemBuilder: (context, index) {
                        return pages[index].page!;
                      }),
                );
              })
        ],
      ),
    );
  }
}

class PageTabItemModel {
  String? title;
  dynamic moreInfo;
  Widget? page;

  PageTabItemModel({this.title, this.moreInfo, this.page});
}

class TabPageController extends ChangeNotifier {
  int _currentTabIndex = 0;
  ValueNotifier<int> tabIndexChanged = ValueNotifier(0);
  final PageController _pageController = PageController();

  TabPageController();

  void onTabTap(int index) {
    _currentTabIndex = index;
    tabIndexChanged.value = index;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeIn,
    );
  }

  void updateIndex(int index) {
    _currentTabIndex = index;
  }

  PageController get pageController => _pageController;

  int get currentIndex => _currentTabIndex;
}
