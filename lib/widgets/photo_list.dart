import 'package:flutter/material.dart';
import 'package:flutter_mvvm/view_models/photo_view_model.dart';

class PhotoList extends StatelessWidget {
  final List<PhotoViewModel> photos;

  PhotoList({this.photos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.photos.length,
      itemBuilder: (context, index) {
        final post = this.photos[index];

        return ListTile(
          contentPadding: EdgeInsets.all(10),
          leading: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(post.thumbnailUrl)),
                borderRadius: BorderRadius.circular(6)),
            width: 50,
            height: 100,
          ),
          title: Text(post.title),
        );
      },
    );
  }
}
