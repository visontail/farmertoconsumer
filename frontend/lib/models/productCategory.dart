class ProductCategory {
  final int _id;
  final String _name;

  ProductCategory({
    required int id,
    required String name,
  })  : _id = id,
        _name = name;

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'],
      name: json['name'],
    );
  }

  int get id => _id;
  String get name => _name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductCategory && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
