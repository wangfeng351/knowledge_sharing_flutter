class Share {
  int id;
  String author;
  String downloadUrl;
  bool isOriginal;
  int price;
  String summary;
  String title;
  String cover;

  Share(
      {
      this.id,
      this.author,
      this.downloadUrl,
      this.isOriginal,
      this.price,
      this.summary,
      this.title,
      this.cover});

  Share.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author = json['author'];
    downloadUrl = json['downloadUrl'];
    isOriginal = json['isOriginal'];
    price = json['price'];
    summary = json['summary'];
    title = json['title'];
    cover = json['cover'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['author'] = this.author;
    data['downloadUrl'] = this.downloadUrl;
    data['isOriginal'] = this.isOriginal;
    data['price'] = this.price;
    data['summary'] = this.summary;
    data['title'] = this.title;
    data['cover'] = this.cover;
    return data;
  }
}
