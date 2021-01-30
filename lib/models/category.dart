class Category {
  String id;
  String title;

  Category({
    this.id,
    this.title,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['label'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['id'] = this.id;
    return data;
  }

}
