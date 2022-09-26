import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/models/postmodel.dart';
import 'package:instagram/services/remoteservices.dart';
import 'package:instagram/utils/heartanimating.dart';
import 'package:instagram/utils/routes.dart';
import 'package:instagram/utils/sp_manager.dart';

class PostComponent extends StatefulWidget {
  final PostModel post;
  // ignore: use_key_in_widget_constructors
  const PostComponent({required this.post});

  @override
  State<PostComponent> createState() => _PostComponentState();
}

class _PostComponentState extends State<PostComponent> {
  bool isLiked = false;
  bool isAnimating = false;

  final String userId = '62e9dbefa86f1bc7f79be026';
  // ignore: prefer_typing_uninitialized_variables
  var liked;

  late String token;
  void LikePost(String id) async {
    setState(() {
      isLiked = !isLiked;
    });
    await RemoteServices().likePost(id: id, token: token);
  }

  @override
  void initState() {
    isLikedFunc();
    print(widget.post.comments.length);
    super.initState();
  }

  void isLikedFunc() async {
    SpManager sharedPreference = SpManager();
    await sharedPreference.init();
    token = await sharedPreference.getAccessToken();
    IsLiked? response = await RemoteServices().isUserLiked(id: widget.post.id);
    print(response?.isLiked);
    setState(() {
      isLiked = response?.isLiked as bool;
    });
  }

  @override
  Widget build(BuildContext context) {
    final IconData icon = isLiked ? Icons.favorite : Icons.favorite_outlined;
    final Color color = isLiked ? Colors.red : Colors.black;

    return Column(
      children: [
        //user post header
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
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(userAccountRoute, arguments: [
                        {
                          "username": widget.post.userId.username,
                          "userId": widget.post.userId.id,
                        }
                      ]);
                    },
                    child: Text(
                      widget.post.userId.username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const Icon(Icons.more_vert)
            ],
          ),
        ),
        //post picture
        GestureDetector(
          onDoubleTap: () {
            setState(() {
              isLiked = true;
              isAnimating = true;
            });
          },
          child: Stack(alignment: Alignment.center, children: [
            AspectRatio(
              aspectRatio: 1,
              child: SizedBox(
                width: double.infinity,
                height: 400,
                child: Image.network(fit: BoxFit.cover, widget.post.photoUrl),
              ),
            ),
            Opacity(
              opacity: isAnimating ? 1 : 0,
              child: HeartAnimationWidget(
                onEnd: () => setState(() {
                  isAnimating = false;
                }),
                isAnimating: isAnimating,
                duration: const Duration(milliseconds: 700),
                child: Icon(icon, color: color, size: 100),
              ),
            )
          ]),
        ),
        //post icons
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  HeartAnimationWidget(
                    isAnimating: isLiked,
                    isAlwaysAnimate: true,
                    child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        onPressed: () {
                          setState(() {
                            LikePost(widget.post.id);
                          });
                        },
                        icon: Icon(
                          icon,
                          color: color,
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(commentRoute, arguments: [
                        {
                          "postId": widget.post.id,
                          "token": token,
                          "comments": widget.post.comments,
                        }
                      ]);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Icon(Icons.chat_bubble_outline),
                    ),
                  ),
                  Icon(Icons.send),
                ],
              ),
              const Icon(Icons.bookmark_border_outlined),
            ],
          ),
        ),
        //show likes
        Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Container(
              child: (widget.post.likes.length == 0)
                  ? const Text('')
                  : (widget.post.likes.length == 1)
                      ? Row(
                          children: [
                            Text('Liked by '),
                            Text(widget.post.likes[0].userId.username,
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        )
                      : Row(children: [
                          Text('Liked by '),
                          Text(
                            widget.post.likes[0].userId.username,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(' and '),
                          Text("${widget.post.likes.length - 1}"),
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
