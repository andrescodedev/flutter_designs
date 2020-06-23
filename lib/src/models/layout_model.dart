import 'package:disenos/src/pages/slideshow_page.dart';
import 'package:flutter/material.dart';

class LayoutModel with ChangeNotifier {
  Widget _currentPage = SlideshowPage();

  Widget get getCurrentPage => this._currentPage;

  set setCurrentPage(Widget page) {
    this._currentPage = page;
    notifyListeners();
  }
}