// import 'package:flutter/material.dart';
// import 'package:instagram/models/usermodel.dart';
// import 'package:instagram/screens/account.dart';
// import 'package:instagram/screens/addpostscreen.dart';
// import 'package:instagram/screens/homescreen.dart';
// import 'package:instagram/screens/reels.dart';
// import 'package:instagram/screens/searchscreen.dart';
// import 'package:instagram/screens/favoritescreen.dart';
// import 'package:instagram/services/remoteservices.dart';
// import 'package:instagram/utils/colors.dart';
// import 'package:instagram/utils/sp_manager.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final PageController _pageController = PageController();
//   int selectedIndex = 0;
//   String? token;
//   late List<UserModel>? myInfo;
//   void navigateBottomBar(int index) {
//     // setState(() {
//     //   selectedIndex = index;
//     // });
//     _pageController.animateToPage(
//       selectedIndex,
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//     );
//   }

//   @override
//   void initState() {
//     print('initialized');
//     // getAccestokenAndData();
//     super.initState();
//   }

//   // getAccestokenAndData() async {
//   //   SpManager sharedPreference = SpManager();
//   //   await sharedPreference.init();
//   //   token = await sharedPreference.getAccessToken();
//   //   print('called');
//   //   myInfo = await RemoteServices().getMyInfo(token: token) as List<UserModel>?;
//   //   print(myInfo);
//   // }

//   final List<Widget> childrens = [
//     homeScreen(),
//     const searchScreen(),
//     const AddPostScreen(),
//     const favoriteScreen(),
//     const accountScreen(),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: childrens[selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//           currentIndex: selectedIndex,
//           onTap: navigateBottomBar,
//           type: BottomNavigationBarType.fixed,
//           items: [
//             BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.home,
//                   color: selectedIndex == 0 ? Colors.grey[900] : secondaryColor,
//                 ),
//                 label: ''),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.search,
//                     color:
//                         selectedIndex == 1 ? Colors.grey[900] : secondaryColor),
//                 label: ''),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.add_box_rounded,
//                     color:
//                         selectedIndex == 2 ? Colors.grey[900] : secondaryColor),
//                 label: ''),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.favorite,
//                     color:
//                         selectedIndex == 3 ? Colors.grey[900] : secondaryColor),
//                 label: ''),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.person,
//                     color:
//                         selectedIndex == 4 ? Colors.grey[900] : secondaryColor),
//                 label: ''),
//           ]),
//     );
//   }
// }
