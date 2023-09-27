class Music {
  int? page;
  int? perPage;
  int? totalItems;
  int? totalPages;
  List<Items>? items;

  Music(
      {this.page, this.perPage, this.totalItems, this.totalPages, this.items});

  Music.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['perPage'];
    totalItems = json['totalItems'];
    totalPages = json['totalPages'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['perPage'] = this.perPage;
    data['totalItems'] = this.totalItems;
    data['totalPages'] = this.totalPages;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? album;
  String? albumName;
  String? artWork;
  String? artist;
  String? artistName;
  String? audio;
  String? format;
  String? name;
  double? size;
  int? time;
  String? titel;
  String? collectionId;
  String? collectionName;
  String? country;
  String? created;
  String? id;
  String? updated;

  Items(
      {this.album,
      this.albumName,
      this.artWork,
      this.artist,
      this.artistName,
      this.audio,
      this.format,
      this.name,
      this.size,
      this.time,
      this.titel,
      this.collectionId,
      this.collectionName,
      this.country,
      this.created,
      this.id,
      this.updated});

  Items.fromJson(Map<String, dynamic> json) {
    album = json['Album'];
    albumName = json['Album_Name'];
    artWork =
        'http://pocketbase-32rnby.chbk.run/api/files/${json['collectionId']}/${json['id']}/${json['ArtWork']}';
    artist = json['Artist'];
    artistName = json['Artist_name'];
    audio =
        'http://pocketbase-32rnby.chbk.run/api/files/${json['collectionId']}/${json['id']}/${json['Audio']}';
    format = json['Format'];
    name = json['Name'];
    size = json['Size'];
    time = json['Time'];
    titel = json['Titel'];
    collectionId = json['collectionId'];
    collectionName = json['collectionName'];
    country = json['country'];
    created = json['created'];
    id = json['id'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Album'] = this.album;
    data['Album_Name'] = this.albumName;
    data['ArtWork'] = this.artWork;
    data['Artist'] = this.artist;
    data['Artist_name'] = this.artistName;
    data['Audio'] = this.audio;
    data['Format'] = this.format;
    data['Name'] = this.name;
    data['Size'] = this.size;
    data['Time'] = this.time;
    data['Titel'] = this.titel;
    data['collectionId'] = this.collectionId;
    data['collectionName'] = this.collectionName;
    data['country'] = this.country;
    data['created'] = this.created;
    data['id'] = this.id;
    data['updated'] = this.updated;
    return data;
  }
}
