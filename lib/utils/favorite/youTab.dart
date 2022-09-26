import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class youTab extends StatelessWidget {
  const youTab({Key? key}) : super(key: key);
  final Color borderColor = const Color.fromARGB(255, 209, 204, 204);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 48,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Follow Requests'),
          ),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: Color.fromARGB(255, 209, 204, 204)))),
        ),
        Container(
          width: double.infinity,
          height: 105,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('New',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(44 / 2),
                            child: Container(
                              child: Image.network(
                                  'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60'),
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  'karennne',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(' liked your photo.'),
                                Text(' 1h'),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Container(),
                            flex: 2,
                          ),
                          Container(
                              width: 44,
                              height: 44,
                              color: Colors.black,
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://images.unsplash.com/photo-1475924156734-496f6cac6ec1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fG5hdHVyZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
                                fit: BoxFit.cover,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: Color.fromARGB(255, 209, 204, 204)))),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              children: [
                Text('New',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(44 / 2),
                        child: Container(
                          child: Image.network(
                              'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60'),
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'karennne',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(' liked your photo.'),
                            Text(' 1h'),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Container(),
                        flex: 2,
                      ),
                      Container(
                          width: 44,
                          height: 44,
                          color: Colors.black,
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://images.unsplash.com/photo-1475924156734-496f6cac6ec1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fG5hdHVyZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
                            fit: BoxFit.cover,
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
