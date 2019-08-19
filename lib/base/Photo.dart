/// Photo data bean of Flickr
class Photo {
  final String id;
  final String owner;
  final String secret;
  final String server;
  final String farm;
  final String title;
  final String ispublic;
  final String isfriend;
  final String isfamily;

  Photo(
      {this.id,
      this.owner,
      this.secret,
      this.server,
      this.farm,
      this.title,
      this.ispublic,
      this.isfriend,
      this.isfamily});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'].toString(),
      owner: json['owner'].toString(),
      secret: json['secret'].toString(),
      server: json['server'].toString(),
      farm: json['farm'].toString(),
      title: json['title'].toString(),
      ispublic: json['ispublic'].toString(),
      isfriend: json['isfriend'].toString(),
      isfamily: json['isfamily'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'owner': owner,
        'secret': secret,
        'server': server,
        'farm': farm,
        'title': title,
        'ispublic': ispublic,
        'isfriend': isfriend,
        'isfamily': isfamily,
      };

  @override
  String toString() {
    return this.toJson().toString();
  }
}
