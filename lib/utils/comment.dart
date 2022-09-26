import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram/models/postmodel.dart';
import 'package:intl/intl.dart';

class CommentComponent extends StatefulWidget {
  const CommentComponent({Key? key, required this.comment}) : super(key: key);
  final Comment comment;
  @override
  State<CommentComponent> createState() => _CommentComponentState();
}

class _CommentComponentState extends State<CommentComponent> {
  late dynamic timedifference;
  late String time;
  @override
  void initState() {
    timedifference =
        DateTime.now().difference(widget.comment.createdAt!).inMinutes;
    time = 'minutes';
    if (timedifference > 60) {
      timedifference =
          DateTime.now().difference(widget.comment.createdAt!).inHours;
      time = 'hours';
    }
    if (timedifference > 24) {
      timedifference =
          DateTime.now().difference(widget.comment.createdAt!).inDays;
      time = 'days';
    }
    // if(timedifference > 30){
    //   timedifference =
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30 / 2),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${widget.comment.userId.username}",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Text(widget.comment.description),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "${timedifference} ${time} ago",
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[700]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Reply',
                            style: TextStyle(
                                fontSize: 10, color: Colors.grey[700]),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          const Icon(
            Icons.favorite,
            size: 20.0,
          ),
        ],
      ),
    );
  }
}
