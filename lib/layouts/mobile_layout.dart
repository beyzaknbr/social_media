import 'package:flutter/material.dart';
import 'package:social_media/screens/pageview_screen/Profile_page.dart';
import 'package:social_media/screens/pageview_screen/reels_page.dart';
import 'package:social_media/screens/pageview_screen/search_page.dart';
import 'package:social_media/utils/colors.dart';

import '../screens/pageview_screen/feed.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  final PageController _pageController = PageController();
  int _page = 0;

  void onChangedPage(int page) {
    setState(() {
      _page = page;
    });
  }

  void nextPage(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: onChangedPage,
        children: [
          Feed(),
          SearchPage(),
          ReelsPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: textFieldColor,
            border: Border(
              top: BorderSide(
                width: 1,
                color: waveColor.withOpacity(0.2),
              ),
            )),
        height: 65,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  nextPage(0);
                },
                icon: Icon(
                  Icons.home_rounded,
                  color: _page == 0 ? Colors.black : null,
                )),
            IconButton(
                onPressed: () {
                  nextPage(1);
                },
                icon: Icon(Icons.search_rounded,
                    color: _page == 1 ? Colors.black : null)),
            IconButton(
                onPressed: () {
                  //gönderi paylaşma olacak
                },
                icon: Icon(
                  Icons.add_box_outlined,
                )),
            IconButton(
                onPressed: () {
                  nextPage(2);
                },
                icon: Icon(
                    _page != 2
                        ? Icons.movie_creation_outlined
                        : Icons.movie_creation_rounded,
                    color: _page == 2 ? Colors.black : null)),
            IconButton(
                onPressed: () {
                  nextPage(3);
                },
                icon: Icon(
                    _page != 3
                        ? Icons.account_circle_outlined
                        : Icons.account_circle_rounded,
                    color: _page == 3 ? Colors.black : null)),
          ],
        ),
      ),
    );
  }
}
