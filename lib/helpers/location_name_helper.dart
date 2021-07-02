import 'package:notes_on_map/models/address_model.dart';

class LocationNameHelper {
  static String getLocation(Address address) {
    String location = '', country;
    if (address.county != null)
      location = address.county;
    else if (address.town != null)
      location = address.town;
    else if (address.village != null) location = address.village;

    country = address.countryCode != null || address.countryCode != ''
        ? address.countryCode.toUpperCase()
        : address.country;

    if (location == '')
      location += '${address.province}, $country';
    else
      location += ', ${address.province}, $country';

    return location;
  }
}
