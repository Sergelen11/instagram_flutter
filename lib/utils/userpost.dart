import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram/models/userpostmodel.dart';
import 'package:instagram/services/remoteservices.dart';
import 'package:instagram/utils/sp_manager.dart';

class UserPostComponent extends StatefulWidget {
  final UserPostModel post;
  // ignore: use_key_in_widget_constructors
  const UserPostComponent({required this.post});

  @override
  State<UserPostComponent> createState() => _UserPostComponentState();
}

class _UserPostComponentState extends State<UserPostComponent> {
  late String token;
  var isLiked = false;
  var liked;
  void LikePost(String id) async {
    setState(() {
      isLiked = isLiked;
    });
    // liked = await RemoteServices().likePost();
    print(isLiked);
  }

  @override
  void initState() {
    getAccessToken();
    super.initState();
    // setState(() {
    //   isLiked = widget.post.userId.id == userId;
    // });
  }

  getAccessToken() async {
    SpManager sharedPreference = SpManager();
    await sharedPreference.init();
    token = await sharedPreference.getAccessToken();
  }

  postEditing(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('editing dialog'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('delete post'),
                onPressed: () async {
                  print(widget.post.id);
                  final response = await RemoteServices()
                      .deletePost(token: token, postId: widget.post.id);
                  print(response);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40 / 2),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        shape: BoxShape.circle,
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.post.userId.username,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () => postEditing(context),
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 400,
          child: Image.network(fit: BoxFit.cover, widget.post.photoUrl),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () => LikePost(widget.post.id),
                      child: (isLiked)
                          ? Icon(Icons.favorite)
                          : Icon(Icons.favorite_border)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Icon(Icons.chat_bubble_outline),
                  ),
                  Icon(Icons.send),
                ],
              ),
              Icon(Icons.bookmark_border_outlined),
            ],
          ),
        ),
        //likes
        Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Container(
              child: (widget.post.likes.length == 0)
                  ? Text('')
                  : (widget.post.likes.length == 1)
                      ? Row(
                          children: [
                            Text('Liked by '),
                            // Text(widget.post.likes[0].userId.username,
                            //     style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        )
                      : Row(children: [
                          Text('Liked by '),
                          // Text(
                          //   widget.post.likes[0].userId.username,
                          //   style: TextStyle(fontWeight: FontWeight.bold),
                          // ),
                          Text(' and '),
                          Text("${widget.post.likes.length}"),
                          Text(' others')
                        ]),
            )),

        //captions
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8),
          child: Row(
            children: [
              RichText(
                text:
                    TextSpan(style: TextStyle(color: Colors.black), children: [
                  TextSpan(
                      text: widget.post.userId.username + ' ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: widget.post.description),
                ]),
              ),
            ],
          ),
        ),
        //comments
      ],
    );
  }
}

// class LikeWidget extends StatelessWidget {
//   final List<Like> likes;
//   LikeWidget({required this.likes});

//   @override
//   Widget build(BuildContext context) {
//     return Text((() {
//       if (likes.length == 0) {
//         return '';
//       }

//       return Container(
//         child: Text(
//             'Liked by ${likes[0].userId.username} and others ${likes.length}'),
//       );
//     })());
//   }
// }
