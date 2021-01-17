import 'package:flutter/material.dart';
import 'package:flutter_mvvm/services/webservice.dart';
import 'package:flutter_mvvm/view_models/photo_view_model.dart';

class PhotoListViewModel extends ChangeNotifier {
  List<PhotoViewModel> photos = List<PhotoViewModel>();

  Future<void> fetchPhotos() async {
    final results = await Webservice().fetchPhotos();
    this.photos = results.map((item) => PhotoViewModel(photo: item)).toList();
    notifyListeners();
  }
}
