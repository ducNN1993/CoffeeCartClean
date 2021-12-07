

import 'package:coffeecarttest/domain/model/index.dart';

class CoffeeDetail {
  int? id;
  String? name;
  int? price;
  int? beforeSalePrice;
  String? description;
  String? fullDescription;
  int? order;
  CoffeeCategory? category;
  CoffeeImages? images;
  List<CoffeeExtras>? extras;
  List<CoffeeExtraItems?>? extraItems;
  List<String?>? tags;
  String? availability;

  CoffeeDetail(
      {this.id,
        this.name,
        this.price,
        this.beforeSalePrice,
        this.description,
        this.fullDescription,
        this.order,
        this.category,
        this.images,
        this.extras,
        this.extraItems,
        this.tags,
        this.availability});

  CoffeeDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    beforeSalePrice = json['before_sale_price'];
    description = json['description'];
    fullDescription = json['full_description'];
    order = json['order'];
    category = json['category'] != null
        ? new CoffeeCategory.fromJson(json['category'])
        : null;
    images =
    json['images'] != null ? new CoffeeImages.fromJson(json['images']) : null;
    if (json['extras'] != null) {
      extras = [];
      json['extras'].forEach((v) {
        extras!.add(CoffeeExtras.fromJson(v));
      });
    }
    if (json['extra_items'] != null) {
      extraItems = [];
      json['extra_items'].forEach((v) {
        extraItems!.add( CoffeeExtraItems.fromJson(v));
      });
    }
    tags = json['tags'].cast<String>();
    availability = json['availability'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['before_sale_price'] = this.beforeSalePrice;
    data['description'] = this.description;
    data['full_description'] = this.fullDescription;
    data['order'] = this.order;
    data['category'] = this.category?.toJson();
    data['images'] = this.images?.toJson();
    data['extras'] = this.extras?.map((v) => v.toJson()).toList();
    data['extra_items'] = this.extraItems?.map((v) => v?.toJson()).toList();
    data['tags'] = this.tags;
    data['availability'] = this.availability;
    return data;
  }
}