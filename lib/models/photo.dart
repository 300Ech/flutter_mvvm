class Photo {

  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
        albumId: int.parse(json["albumId"].toString()),
        id: int.parse(json["id"].toString()),
        title: json["title"],
        url: json["url"],
        thumbnailUrl: json["thumbnailUrl"]
    );
  }
}