import 'itemModel.dart';

class Section {
  String name;
  List<Item> items;

  Section({required this.name, required this.items});

  factory Section.fromJson(Map<String, dynamic> json) {
    final itemsJson = json['items'];
    final items = itemsJson.map((itemJson) => Item.fromJson(itemJson)).toList();
    return Section(name: json['name'], items: items);
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'items': items.map((item) => item.toJson()).toList(),
  };
}
