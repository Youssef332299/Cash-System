class OnPrepModel {
  String name;
  int count;
  double total;

  OnPrepModel({required this.name, required this.count, required this.total});

  factory OnPrepModel.fromJson(Map<String, dynamic> json) {
    return OnPrepModel(name: json['name'], count: json['count'], total: json['total']);
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'count': count,
    'total': total,
  };
}