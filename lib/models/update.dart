class Update {
  final String appid;
  final int appversion;
  final String url;

  Update({this.appid, this.appversion, this.url});

  factory Update.fromJson(Map<String, dynamic> json) {
    return Update(
      appid: json["appid"],
      appversion: int.parse(json["appversion"].toString()),
      url: json["url"],
    );
  }
}
