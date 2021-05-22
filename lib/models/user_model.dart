import 'package:notes_on_map/models/whoop_model.dart';

class User {
  final int id;
  final String email;
  final int whoopCount;
  final List<Whoop> whoops;

  User(this.id, this.email, this.whoopCount, [this.whoops]);

  factory User.fromJson(dynamic json) {
    if (json['whoops'] != null) {
      var whoopObjsJson = json['whoops'] as List;
      List<Whoop> _whoops =
          whoopObjsJson.map((whoopJson) => Whoop.fromJson(whoopJson)).toList();

      return User(
        json['id'] as int,
        json['email'] as String,
        json['whoopCount'] as int,
        _whoops,
      );
    } else {
      return User(
        json['id'] as int,
        json['email'] as String,
        json['whoopCount'] as int,
      );
    }
  }
}
