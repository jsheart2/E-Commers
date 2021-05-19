import 'package:flutter/material.dart';
import 'package:mystore/screens/form_page.dart';
import 'package:mystore/tabs/form_tabs.dart';
import 'package:mystore/tabs/home_tabs.dart';
import 'package:mystore/tabs/saved_tab.dart';
import 'package:mystore/tabs/search_tab.dart';
import 'package:mystore/widgets/bottom_tabs.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PageController _tabsPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: PageView(
                controller: _tabsPageController,
                onPageChanged: (num){
                  setState(() {
                    _selectedTab = num;
                  });
                },
                children: [
                  HomeTabs(),
                  SearchTab(),
                  SavedTab(),
                  FormPage(),
                ],
              ),
            ),
          BottomTabs(
            selectedTab: _selectedTab,
            tabPressed: (num){
              _tabsPageController.animateToPage(
                  num,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic);
            },
          ),
        ],
      ),
    );
  }
}
