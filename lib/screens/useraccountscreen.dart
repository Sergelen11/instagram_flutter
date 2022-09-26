import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/models/followdata.dart';
import 'package:instagram/models/usermodel.dart';
import 'package:instagram/models/userpostmodel.dart';
import 'package:instagram/services/remoteservices.dart';
import 'package:instagram/utils/sp_manager.dart';
import 'package:instagram/utils/story.dart';
import 'package:instagram/utils/useraccount/usertab1.dart';
import 'package:instagram/utils/useraccount/usertab2.dart';
import 'package:instagram/utils/useraccount/usertab3.dart';
import 'package:instagram/utils/useraccount/usertab4.dart';

class UserAccountScreen extends StatefulWidget {
  const UserAccountScreen({Key? key}) : super(key: key);

  @override
  State<UserAccountScreen> createState() => _UserAccountScreenState();
}

class _UserAccountScreenState extends State<UserAccountScreen> {
  final String username = Get.arguments[0]['username'];
  final String userId = Get.arguments[0]['userId'];
  late bool isLoaded = false;

  String? token;
  bool isFollowed = false;
  List<UserPostModel>? userposts;
  MyFollowing? userfollowing;
  UserModel? userdata;

  @override
  void initState() {
    getAccessTokenAndData();
    super.initState();
  }

  getAccessTokenAndData() async {
    SpManager sharedPreference = SpManager();
    await sharedPreference.init();
    token = await sharedPreference.getAccessToken();
    userposts = await RemoteServices()
        .getAnotherUserPosts(token: token!, userId: userId);
    userdata =
        (await RemoteServices().getUserData(token: token, userId: userId))!;
    userfollowing =
        await RemoteServices().isUserFollowing(token: token, userId: userId);
    print(userfollowing);
    final dynamic isUserFollowed =
        await RemoteServices().isFollowed(token: token!, userId: userId);
    if (userposts != null &&
        userdata != null &&
        isUserFollowed != null &&
        userfollowing != null) {
      setState(() {
        isFollowed = isUserFollowed.isFollowing;
        isLoaded = true;
      });
    }
  }

  followUser() async {
    final followData = (await RemoteServices()
        .FollowUser(token: token!, userId: userId)) as dynamic;
    if (followData.statusCode == 200) {
      setState(() {
        isFollowed = !isFollowed;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Text(
            username,
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: false,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    print(token ?? '');
                  },
                  child: Icon(
                    Icons.notification_add_outlined,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Visibility(
          visible: isLoaded,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: Column(
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
                            children: [
                              Text(
                                '${userposts?.length}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
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
                                '${userfollowing?.follower.length}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Text(
                                'Followers',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '${userfollowing?.following.length}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
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
                  children: const [
                    Text(
                      "SRGLN",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0),
                      child: Text('helllo'),
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
                          followUser();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5)),
                          padding: const EdgeInsets.all(8),
                          child: Center(
                              child: isFollowed
                                  ? Text(
                                      'Following',
                                      style: TextStyle(fontSize: 16),
                                    )
                                  : Text(
                                      'Follow',
                                      style: TextStyle(fontSize: 16),
                                    )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
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
              Expanded(
                child: TabBarView(children: [
                  UserTab1(
                    userId: userId,
                    userposts: userposts,
                  ),
                  const UserTab2(),
                  const UserTab3(),
                  const UserTab4(),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
