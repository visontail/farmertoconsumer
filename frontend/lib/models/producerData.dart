class ProducerData {
  final int _id;
  final String _description;

  ProducerData({
    required int id,
    required String description,
  })  : _id = id,
        _description = description;
  
  factory ProducerData.fromJson(Map<String, dynamic> json) {
    return ProducerData(
      id: json['id'],
      description: json['description'],
    );
  }
  
  int get id => _id;
  String get description => _description;
}
