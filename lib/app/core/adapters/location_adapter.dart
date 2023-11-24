import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart';
import '../domain/entities/coordinate_entity.dart';

class LocationAdapter {
  Location location = Location();
  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;

  Future<bool> isLocationServiceEnabled() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }
    return true;
  }

  Future<bool> checkLocationPermission() async {
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  Future<LocationData?> getCurrentLocation() async {
    bool hasPermission = await checkLocationPermission();
    bool locationServiceEnabled = await isLocationServiceEnabled();

    if (!hasPermission || !locationServiceEnabled) {
      return null;
    }

    _locationData = await location.getLocation();
    return _locationData;
  }

  // get placemark with geocoding
  Future<String?> getPlacemarkFromLocationData(
      CoordinateEntity coordinate) async {
    List<geocoding.Placemark> placemarks = [];
    try {
      placemarks = await geocoding.placemarkFromCoordinates(
          coordinate.latitude, coordinate.longitude);
    } catch (e) {
      return null;
    }
    if (placemarks.isNotEmpty) {
      geocoding.Placemark place = placemarks.first;
      return "${place.thoroughfare} - ${place.subLocality}, ${place.subAdministrativeArea} - ${place.administrativeArea}, ${place.postalCode} - ${place.country}";
    }
    return null;
  }
}
