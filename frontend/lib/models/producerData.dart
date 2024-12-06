class ProducerData {
  final int _id;
  final String _description;
  final String _contact;

  ProducerData({
    required int id,
    required String description,
    required String contact
  })  : _id = id,
        _description = description,
        _contact = contact;

  factory ProducerData.fromJson(Map<String, dynamic> json) {
    return ProducerData(
      id: json['id'],
      contact: json['contact'],
      description: json['description'],
    );
  }

  int get id => _id;
  String get description => _description;
  String get contact => _contact;
}
