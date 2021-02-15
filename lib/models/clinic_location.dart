import 'package:google_maps_flutter/google_maps_flutter.dart';

class Clinic {
  String name;
  String address;
  String description;
  String thumbnail;
  LatLng locationCordinates;

  Clinic(
      {this.name,
      this.address,
      this.description,
      this.thumbnail,
      this.locationCordinates});
}

// list of shops and its info
final List<Clinic> clinicDetails = [
  Clinic(
      name: 'Love Your Teeth Dental Clinic',
      address: 'Chagal, Kathmandu',
      description: '📞 01-4282219\nOpens and close: 9AM - 7PM',
      locationCordinates: LatLng(27.701830065912485, 85.29982222846189),
      thumbnail:
          'https://scontent.fktm8-1.fna.fbcdn.net/v/t1.0-9/68836873_102089914502275_2545263371263934464_o.jpg?_nc_cat=102&ccb=3&_nc_sid=e3f864&_nc_ohc=1F78h7QUg04AX-cw5hi&_nc_ht=scontent.fktm8-1.fna&oh=afa85ee8af69ec39abfb01703e636b89&oe=60497EC6'),
  Clinic(
      name: 'Love Your Teeth Dental Clinic',
      address: 'Bafal, Kathmandu',
      description: '📞 9818287999\nOpens and close: 10AM - 6PM',
      locationCordinates: LatLng(27.718568, 85.331130),
      thumbnail:
          'https://lh3.googleusercontent.com/JbhltzhdF8MljaymcStdFWTkWFjNmyREXrSCsfcrWkFkay5N4ObMaYkJi0P0rfS28Bj8zTDpqs2LmUG-=w1080-h608-p-no-v0'),
  Clinic(
      name: 'Love Your Teeth Dental Clinic',
      address: 'Koteswor, Lalitpur',
      description: '📞 01-4282219\nOpens and close: 9AM - 7PM',
      locationCordinates: LatLng(27.679417, 85.319258),
      thumbnail:
          'https://scontent.fktm8-1.fna.fbcdn.net/v/t1.0-9/68836873_102089914502275_2545263371263934464_o.jpg?_nc_cat=102&ccb=3&_nc_sid=e3f864&_nc_ohc=1F78h7QUg04AX-cw5hi&_nc_ht=scontent.fktm8-1.fna&oh=afa85ee8af69ec39abfb01703e636b89&oe=60497EC6'),
];