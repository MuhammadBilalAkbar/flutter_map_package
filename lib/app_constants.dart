import 'package:latlong2/latlong.dart';

class AppConstants {
  // static const String mapBoxAccessToken =
  //     'sk.eyJ1IjoibXVoYW1tYWRiaWxhbDIwNzMiLCJhIjoiY2xna3Q5OTJhMDNldTNxcWlreDdidmQ0cCJ9._glRO_C9h9YuR7nQj5N18w';

  static const String mapBoxAccessToken =
      'pk.eyJ1IjoibXVoYW1tYWRiaWxhbDIwNzMiLCJhIjoiY2xmeTcxenhuMHZwdjNtcXFza3Q3MHRkaiJ9.CVCQ7Xendlq-nfbVMOi8eA';

  static const String urlTemplate =
      'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token=$mapBoxAccessToken';

  // static const String mapBoxStyleId =
  //     'mapbox://styles/muhammadbilal2073/clg7q94wj000501pmbg4a8ia7';

  static const String mapBoxStyleDarkId = 'mapbox/dark-v11';
  static const String mapBoxStyleOutdoorId = 'mapbox/outdoors-v12';
  static const String mapBoxStyleStreetId = 'mapbox/streets-v12';
  static const String mapBoxStyleNightId = 'mapbox/navigation-night-v1';

  static final myLocation = LatLng(51.5, -0.09);
}
