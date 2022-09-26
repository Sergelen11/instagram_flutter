import 'package:flutter/material.dart';
import 'package:instagram/models/followdata.dart';
import 'package:instagram/models/usermodel.dart';
import 'package:instagram/services/remoteservices.dart';
import 'package:instagram/utils/account/accounttab1.dart';
import 'package:instagram/utils/account/accounttab2.dart';
import 'package:instagram/utils/account/accounttab3.dart';
import 'package:instagram/utils/account/accounttab4.dart';
import 'package:instagram/utils/sp_manager.dart';
import 'package:instagram/utils/story.dart';

// ignore: camel_case_types
class accountScreen extends StatefulWidget {
  const accountScreen({Key? key}) : super(key: key);
  // final String token;
  @override
  State<accountScreen> createState() => _accountScreenState();
}

// ignore: camel_case_types
class _accountScreenState extends State<accountScreen> {
  bool isLoaded = false;
  UserModel? myInfo;
  MyFollowing? myFollowInfo;
  String? token;
  @override
  void initState() {
    // getData();
    super.initState();
  }

  // getData() async {
  //   SpManager sharedPreference = SpManager();
  //   await sharedPreference.init();
  //   token = await sharedPreference.getAccessToken();
  //   myInfo = await RemoteServices().getMyInfo(token: token!);
  //   myFollowInfo = await RemoteServices().Following(token: token);
  //   setState(() {
  //     isLoaded = true;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${myInfo?.username}',
                    style: const TextStyle(color: Colors.black),
                  ),
                  const Icon(
                    Icons.menu,
                    color: Colors.black,
                  )
                ],
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          shape: BoxShape.circle,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: const [
                                Text(
                                  "1",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  'Posts',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "${myFollowInfo?.follower.length}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                const Text(
                                  'Followers',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "${myFollowInfo?.following.length}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                const Text(
                                  'Following',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${myInfo?.username}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Text('${myInfo?.bio}'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            print(myFollowInfo);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5)),
                            padding: const EdgeInsets.all(8),
                            child: const Center(
                              child: Text(
                                'Edit profile',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Row(
                    children: [
                      StoryComponent(name: 'story1'),
                      StoryComponent(name: 'story2'),
                      StoryComponent(name: 'story3'),
                      StoryComponent(name: 'story4'),
                    ],
                  ),
                ),
                const TabBar(labelColor: Colors.black, tabs: [
                  Tab(icon: Icon(Icons.grid_on_outlined)),
                  Tab(icon: Icon(Icons.video_call)),
                  Tab(icon: Icon(Icons.shop)),
                  Tab(icon: Icon(Icons.person)),
                ]),
                const Expanded(
                  child: TabBarView(children: [
                    AccountTab1(),
                    AccountTab2(),
                    AccountTab3(),
                    AccountTab4(),
                  ]),
                )
              ],
            )),
      ),
    );
  }
}
