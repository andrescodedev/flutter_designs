import 'package:disenos/src/pages/animations_page.dart';
import 'package:disenos/src/pages/circular_graphics_page.dart';
import 'package:disenos/src/pages/emergency_page.dart';
import 'package:disenos/src/pages/headers_page.dart';
import 'package:disenos/src/pages/pinterest_page.dart';
import 'package:disenos/src/pages/slideshow_page.dart';
import 'package:disenos/src/pages/sliver_list_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final pageRoutes = <_Route>[
  _Route(FontAwesomeIcons.slideshare,'Slidesshow',SlideshowPage()),
  _Route(FontAwesomeIcons.ambulance,'Emergency',EmergencyPage()),
  _Route(FontAwesomeIcons.heading,'Headers',HeadersPage()),
  _Route(FontAwesomeIcons.peopleCarry,'Animation Square',AnimationsPage()),
  _Route(FontAwesomeIcons.circleNotch,'Circular Progress Bar',CircularGraphicsPage()),
  _Route(FontAwesomeIcons.pinterest,'Pinterest',PinterestPage()),
  _Route(FontAwesomeIcons.mobile,'Slivers',SliverListPage()),
];

class _Route {
  final IconData icon;
  final String title;
  final Widget page;

  _Route(this.icon, this.title, this.page);
}