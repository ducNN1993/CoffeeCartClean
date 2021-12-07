

class CoffeeImages {
  String? fullSize;
  String? thumbnail;

  CoffeeImages({this.fullSize, this.thumbnail});

  CoffeeImages.fromJson(Map<String, dynamic> json) {
    fullSize = json['full_size'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_size'] = this.fullSize;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}