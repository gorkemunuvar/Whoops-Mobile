class Whoop {
  final String title;
  final double latitude;
  final double longitude;
  final int time;

  Whoop(this.title, this.latitude, this.longitude, this.time);

  Whoop.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        time = json['time'];
}
