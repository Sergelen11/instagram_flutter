import 'package:flutter/material.dart';
import 'package:instagram/models/usermodel.dart';
import 'package:instagram/screens/account.dart';
import 'package:instagram/screens/addpostscreen.dart';
import 'package:instagram/screens/favoritescreen.dart';
import 'package:instagram/screens/homescreen.dart';
import 'package:instagram/screens/searchscreen.dart';
import 'package:instagram/utils/custom_inkwell.dart';
import 'package:instagram/utils/sp_manager.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double _bottomPadding = 0.0;
  final PageController _pageController = PageController();
  late String token;
  late UserModel myInfo;
  // late MyFollowing myFollowInfo;
  // late List<UserPostModel> userposts;
  final List<IconData> _dummyData = [
    Icons.home,
    Icons.search,
    Icons.add,
    Icons.favorite,
    Icons.person,
  ];
  @override
  void initState() {
    print('initialized');
    // getAccestokenAndData();
    super.initState();
  }

  getAccestokenAndData() async {
    SpManager sharedPreference = SpManager();
    await sharedPreference.init();
    token = await sharedPreference.getAccessToken();
    // myInfo = await RemoteServices().getMyInfo(token: token!);
    // myFollowInfo = await RemoteServices().Following(token: token!);
  }

  @override
  Widget build(BuildContext context) {
    _bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.grey,
      body: PageView(
        controller: _pageController,
        children: const [
          homeScreen(),
          searchScreen(),
          AddPostScreen(),
          favoriteScreen(),
          accountScreen(),
        ],
      ),
      bottomNavigationBar: _customNavigationBar(),
    );
  }

  Widget _customNavigationBar() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 50 + _bottomPadding,
      padding: EdgeInsets.only(bottom: _bottomPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _dummyData.asMap().entries.map((entry) {
          int idx = entry.key;
          IconData val = entry.value;

          return CustomNavigationItem(
            index: idx,
            iconData: val,
            onClickListener: (selectedIndex) async {
              _pageController.animateToPage(
                selectedIndex,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );

              // if (selectedIndex == 4) {
              //   SpManager sharedPreference = SpManager();
              //   await sharedPreference.init();

              //   sharedPreference.saveAccessToken('');
              //   Get.offAllNamed(loginRoute);
              // } else {
              _pageController.jumpToPage(selectedIndex);
              // }
            },
          );
        }).toList(),
      ),
    );
  }
}

class CustomNavigationItem extends StatelessWidget {
  final int? index;
  final IconData? iconData;
  final Function(int)? onClickListener;

  const CustomNavigationItem({
    Key? key,
    this.index,
    this.iconData,
    this.onClickListener,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomInkWell(
            onTap: () {
              if (onClickListener != null) onClickListener!(index ?? 0);
            },
            child: SizedBox(
              width: 48,
              height: 48,
              child: Icon(
                iconData,
                color: Colors.black,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
