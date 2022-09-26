import 'package:flutter/material.dart';
import 'package:instagram/utils/favorite/followingtab.dart';
import 'package:instagram/utils/favorite/youTab.dart';

// ignore: camel_case_types
class favoriteScreen extends StatelessWidget {
  const favoriteScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const TabBar(
                // unselectedLabelStyle: Colors.redAccent,
                // labelStyle: TextStyle(color: Colors.grey),
                labelColor: Colors.black,
                tabs: [
                  Tab(
                    text: 'Following',
                  ),
                  Tab(
                    text: 'You',
                  ),
                ]),
          ),
          body: const TabBarView(children: [
            followingTab(),
            youTab(),
          ]),
        ));
  }
}
