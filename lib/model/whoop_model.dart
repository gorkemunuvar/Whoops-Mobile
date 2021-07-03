import 'address_model.dart';

class Whoop {
  final String title;
  final double latitude;
  final double longitude;
  final int time;
  final String dateCreated;
  final String startingTime;
  final String endingTime;
  final List<dynamic> tags;
  final Address address;

  Whoop(
    this.title,
    this.latitude,
    this.longitude,
    this.time,
    this.tags,
    this.address, {
    this.dateCreated,
    this.startingTime,
    this.endingTime,
  });

  Map<String, dynamic> toJson() => {
        'title': this.title,
        'latitude': this.latitude,
        'longitude': this.longitude,
        'time': this.time,
        'tags': this.tags,
        'address': this.address.toJson(),
      };

  Whoop.fromJson(dynamic json)
      : title = json['title'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        time = json['time'],
        dateCreated = json['date_created'],
        startingTime = json['starting_time'],
        endingTime = json['ending_time'],
        tags = json['tags'],
        address = Address.fromJson(json['address']);
}
