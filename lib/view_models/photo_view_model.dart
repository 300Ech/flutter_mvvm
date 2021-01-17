import 'package:flutter_mvvm/models/photo.dart';

class PhotoViewModel {
  final Photo photo;

  PhotoViewModel({this.photo});

  String get title {
    return this.photo.title;
  }

  String get thumbnailUrl {
    return this.photo.thumbnailUrl;
  }
}
