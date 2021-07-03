import 'package:whoops/model/whoop_model.dart';

class User {
  final String id;
  final String email;
  List<Whoop> whoops;

  User(this.id, this.email, [this.whoops = null]);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        email = json['email'] as String,
        whoops = null;
}
