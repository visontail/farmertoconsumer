import 'package:farmertoconsumer/models/producerData.dart';

class User {
  final int _id;
  final String _name;
  final ProducerData? _producerData;

  User({
    required int id,
    required String name,
    ProducerData? producerData,
  })  : _id = id,
        _name = name,
        _producerData = producerData;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      producerData: json['producerData'] != null
          ? ProducerData.fromJson(json['producerData'])
          : null,
    );
  }

  int get id => _id;
  String get name => _name;
  ProducerData? get producerData => _producerData;
}
