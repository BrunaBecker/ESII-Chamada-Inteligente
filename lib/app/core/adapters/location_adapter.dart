import 'package:location/location.dart';

class LocationAdapter {

    Location location = Location();
    bool _serviceEnabled = false;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    bool isLocationServiceEnabled() async {
        _serviceEnabled = await location.serviceEnabled();
        if (!_serviceEnabled) {
            _serviceEnabled = await location.requestService();
            if (!_serviceEnabled) {
                return false;
            }
        }
        return true;
    }

    bool checkLocationPermission() async {
        _permissionGranted = await location.hasPermission();
        if (_permissionGranted == PermissionStatus.denied) {
            _permissionGranted = await location.requestPermission();
            if (_permissionGranted != PermissionStatus.granted) {
                return false;
            }
        }
        return true;
    }

    Future<LocationData> getCurrentLocation() async {
        hasPermission = await checkLocationPermission();
        isLocationServiceEnabled = await isLocationServiceEnabled();

        if(!hasPermission || !isLocationServiceEnabled) {
            return null;
        }

        _locationData = await location.getLocation();
        return _locationData;
    }
}