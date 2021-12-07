
class CoffeeExtraItems {
  int? id;
  String? name;
  int? extraId;
  String? price;

  int get priceNum => price == null || price!.isEmpty ? 0 : int.parse(price!);


  CoffeeExtraItems({this.id, this.name, this.extraId, this.price});

  CoffeeExtraItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    extraId = json['extra_id'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['extra_id'] = this.extraId;
    data['price'] = this.price;
    return data;
  }
}