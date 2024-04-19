import 'package:flutter/material.dart';

class BottomNavController {
  final PageController _pageController = PageController(initialPage: 1);
  int _selectedIndex = 1;

  void navigateTo(int index) {
    _pageController.jumpToPage(index);
    _selectedIndex = index;
  }

  int get currentIndex => _pageController.page?.round() ?? 0;

  PageController get controller => _pageController;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int index) {
    _selectedIndex = index;
    navigateTo(index);
  }
}
