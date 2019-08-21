/// Photo data bean of Flickr
class Photo {
  final String id;
  final String owner;
  final String secret;
  final String server;
  final String farm;
  final String title;
  final String ispublic; // int 1/0
  final String isfriend; // int 1/0
  final String isfamily; // int 1/0

  get isPublicBool => int.parse(ispublic ?? "0");

  get isFriendBool => int.parse(isfriend ?? "0");

  get isFamilyBool => int.parse(isfamily ?? "0");

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

  factory Photo.fromDatabaseMap(Map<String, dynamic> json) {
    return Photo(
      id: json['id'].toString(),
      owner: json['owner'].toString(),
      secret: json['secret'].toString(),
      server: json['server'].toString(),
      farm: json['farm'].toString(),
      title: json['title'].toString(),
      ispublic: json['ispublic'],
      isfriend: json['isfriend'],
      isfamily: json['isfamily'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'owner': owner,
        'secret': secret,
        'server': server,
        'farm': farm,
        'title': title,
        'ispublic': isPublicBool, // int
        'isfriend': isFriendBool, // int
        'isfamily': isFamilyBool, // int
      };

  Map<String, String> toDatabaseType() => {
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
    return this.toDatabaseType().toString() + '\n';
  }
}
