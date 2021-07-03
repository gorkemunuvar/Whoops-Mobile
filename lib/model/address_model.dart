class Address {
  final String amenity;
  final String road;
  final String neighbourhood;
  final String village;
  final String town;
  final String county;
  final String province;
  final String region;
  final String postcode;
  final String country;
  final String countryCode;

  Address(
    this.amenity,
    this.road,
    this.neighbourhood,
    this.village,
    this.town,
    this.county,
    this.province,
    this.region,
    this.postcode,
    this.country,
    this.countryCode,
  );

  Map<String, dynamic> toJson() => {
        'amenity': this.amenity,
        'road': this.road,
        'neighbourhood': this.neighbourhood,
        'village': this.village,
        'county': this.county,
        'town': this.town,
        'province': this.province,
        'region': this.region,
        'postcode': this.postcode,
        'country': this.country,
        'country_code': this.countryCode,
      };

  Address.fromJson(dynamic json)
      : amenity = json['amenity'],
        road = json['road'],
        neighbourhood = json['neighbourhood'],
        village = json['village'],
        town = json['town'],
        county = json['county'],
        province = json['province'],
        region = json['region'],
        postcode = json['postcode'],
        country = json['country'],
        countryCode = json['country_code'];
}
