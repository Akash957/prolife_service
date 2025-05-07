import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class LocationProvider with ChangeNotifier {
  String? _currentAddress;
  List<dynamic> _searchResults = [];
  final String apikey = 'AlzaSyLlkDIhqWEBbrwuVI8A_g6-IrRHJmolieX';

  String? get currentAddress => _currentAddress;

  List<dynamic> get searchResults => _searchResults;

  Future<void> getCurrentLocation() async {
    try {
      bool isEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isEnabled) {
        Fluttertoast.showToast(msg: 'Enable Location Services');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Fluttertoast.showToast(msg: 'Location permission denied');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Fluttertoast.showToast(msg: 'Permission permanently denied');
        return;
      }

      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks =
          await placemarkFromCoordinates(pos.latitude, pos.longitude);

      if (placemarks.isNotEmpty) {
        Placemark p = placemarks.first;
        _currentAddress =
            "${p.name}, ${p.locality}, ${p.administrativeArea}, ${p.country}";
        notifyListeners();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Location error: $e");
    }
  }

  Future<void> searchPlaces(String input) async {
    final url =
        "https://maps.gomaps.pro/maps/api/place/autocomplete/json?input=$input&key=$apikey";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _searchResults = data['predictions'] ?? [];
        notifyListeners();
      } else {
        Fluttertoast.showToast(msg: "Search failed: ${response.reasonPhrase}");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Search failed: $e");
    }
  }

  Future<String?> getPlaceDetails(String placeId) async {
    final url =
        'https://maps.gomaps.pro/maps/api/place/details/json?place_id=$placeId&key=$apikey';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data != null &&
            data['result'] != null &&
            data['result']['formatted_address'] != null) {
          return data['result']['formatted_address'];
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Details fetch failed: $e");
    }
    return null;
  }

  void clearSearch() {
    _searchResults.clear();
    notifyListeners();
  }

  void setAddress(String address) {
    _currentAddress = address;
    notifyListeners();
  }
}
