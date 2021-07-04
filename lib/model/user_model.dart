import 'package:whoops/model/whoop_model.dart';

class User {
  final String id;
  final String username;
  final String email;
  final String aboutMe;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String twitterUsername;
  final String instagramUsername;
  final String facebookUsername;
  List<Whoop> whoops;

  User(
    this.id,
    this.username,
    this.email, {
    this.aboutMe,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.twitterUsername,
    this.instagramUsername,
    this.facebookUsername,
    this.whoops,
  });

  Map<String, String> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'about_me': aboutMe,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'twitter_username': twitterUsername,
      'instagram_username': instagramUsername,
      'facebook_username': facebookUsername,
    };
  }

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        username = json['username'] as String,
        email = json['email'] as String,
        aboutMe = json['about_me'] as String,
        firstName = json['first_name'] as String,
        lastName = json['last_name'] as String,
        phoneNumber = json['phone_number'] as String,
        twitterUsername = json['twitter_username'] as String,
        instagramUsername = json['instagram_username'] as String,
        facebookUsername = json['facebook_username'] as String,
        whoops = null;
}
