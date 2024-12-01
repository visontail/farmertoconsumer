import '../models/producerData.dart';

class AuthenticatedUser {
  final int _id;
  final String _name;
  final String _email;
  final ProducerData? _producerData;

  AuthenticatedUser({
    required int id,
    required String name,
    required String email,
    ProducerData? producerData,
  })  : _id = id,
        _name = name,
        _email = email,
        _producerData = producerData;

  factory AuthenticatedUser.fromJson(Map<String, dynamic> json) {
    return AuthenticatedUser(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      producerData: json['producerData'] != null
          ? ProducerData.fromJson(json['producerData'])
          : null,
    );
  }

  int get id => _id;
  String get name => _name;
  String get email => _email;
  ProducerData? get producerData => _producerData;
  bool get isProducer => _producerData != null;
}
