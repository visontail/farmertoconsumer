class QuantityUnit {
  final int _id;
  final String _name;

  QuantityUnit({
    required int id,
    required String name,
  })  : _id = id,
        _name = name;

  factory QuantityUnit.fromJson(Map<String, dynamic> json) {
    return QuantityUnit(
      id: json['id'],
      name: json['name'],
    );
  }

  int get id => _id;
  String get name => _name;
}
