/// Photo data bean of Flickr
class Photo {
  final String id;
  final String owner;
  final String secret;
  final String server;
  final int farm;
  final String title;
  final int ispublic;
  final int isfriend;
  final int isfamily;

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
      id: json['id'],
      owner: json['owner'],
      secret: json['secret'],
      server: json['server'],
      farm: json['farm'],
      title: json['title'],
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
        'ispublic': ispublic,
        'isfriend': isfriend,
        'isfamily': isfamily,
      };
}
