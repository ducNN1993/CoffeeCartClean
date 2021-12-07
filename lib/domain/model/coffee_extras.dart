

class CoffeeExtras {
  int? id;
  String? name;
  String? min;
  String? max;

  int get minNum => min == null || min!.isEmpty ? 0 : int.parse(min!);
  int get maxNum => max == null || max!.isEmpty ? 0 : int.parse(max!);



  CoffeeExtras({this.id, this.name, this.min, this.max});



  CoffeeExtras.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    min = json['min'];
    max = json['max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['min'] = this.min;
    data['max'] = this.max;
    return data;
  }
}