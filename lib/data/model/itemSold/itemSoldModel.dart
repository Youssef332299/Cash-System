class ItemSold {
  String name;
  int count;
  double total;

  ItemSold({required this.name, required this.count, required this.total});

  factory ItemSold.fromJson(Map<String, dynamic> json) {
    return ItemSold(name: json['name'], count: json['count'], total: json['total']);
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'count': count,
    'total': total,
  };
}