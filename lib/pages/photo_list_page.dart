import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mvvm/services/webservice.dart';
import 'package:flutter_mvvm/view_models/photo_list_view_model.dart';
import 'package:flutter_mvvm/widgets/photo_list.dart';
import 'package:get_version/get_version.dart';
import 'package:ota_update/ota_update.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class PhotoListPage extends StatefulWidget {
  @override
  _PhotoListPageState createState() => _PhotoListPageState();
}

class _PhotoListPageState extends State<PhotoListPage> {
  String _projectVersion = '';
  String _projectAppID = '';
  OtaEvent currentEvent;
  ProgressDialog progressDialog;

  @override
  void initState() {
    super.initState();

    initPlatformState();
    Provider.of<PhotoListViewModel>(context, listen: false).fetchPhotos();
  }

  initPlatformState() async {
    String projectVersion;
    String projectAppID;

    try {
      projectVersion = await GetVersion.projectCode;
      projectAppID = await GetVersion.appID;
    } on PlatformException {
      projectVersion = 'Failed to get project version or app id.';
    }

    if (!mounted) return;

    setState(() {
      _projectVersion = projectVersion;
      _projectAppID = projectAppID;
    });

    fetchUpdates();
  }

  fetchUpdates() async {
    var appId = _projectAppID;
    final updates = await Webservice().fetchUpdates();

    updates.forEach((e) {
      if (e.appid == appId) {
        if (e.appversion > int.parse(_projectVersion)) {
          tryOtaUpdate(e.url);
        }
      }
    });
  }

  Future<void> tryOtaUpdate(String updateUrl) async {
    try {
      progressDialog = new ProgressDialog(context,
          type: ProgressDialogType.Normal,
          isDismissible: false,
          showLogs: false);
      progressDialog.show();

      OtaUpdate()
          .execute(updateUrl, destinationFilename: 'apprelease.apk')
          .listen(
        (OtaEvent event) {
          setState(() => currentEvent = event);
        },
      );
    } catch (e) {
      print('Failed to make OTA update. Details: $e');
    }

    progressDialog.hide();
  }

  @override
  Widget build(BuildContext context) {
    if (currentEvent == null) {
      return Container();
    }

    if (currentEvent.status != OtaStatus.DOWNLOADING) {
      if (progressDialog != null) progressDialog.hide();
    }

    print("currentEvent: " + currentEvent.status.toString());

    final vm = Provider.of<PhotoListViewModel>(context);

    return Scaffold(
        appBar: AppBar(title: Text("Photos")),
        body: Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(children: <Widget>[
              Expanded(child: PhotoList(photos: vm.photos))
            ])));
  }
}
