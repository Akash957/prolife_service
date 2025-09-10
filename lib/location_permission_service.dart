import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPermissionService {
  static const String disclosure = '''
This app collects location data to enable features like
- Continuous Safety Tracking
- Geofence Alerts
- Trip History

even when the app is closed or not in use.
Data is not sold and can be turned off anytime in settings.
  ''';

  static Future<void> requestLocationPermission(BuildContext context) async {
    // Step 1: Show Prominent Disclosure
    final accepted = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (c) => AlertDialog(
        title: const Text("Location Permission Required"),
        content: SingleChildScrollView(child: Text(disclosure)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(c, true),
            child: const Text("Continue"),
          ),
        ],
      ),
    );

    if (accepted != true) return;

    // Step 2: Ask for Foreground Location
    final fgStatus = await Permission.locationWhenInUse.request();

    if (fgStatus.isGranted) {
      // Step 3: Ask for Background (if app really needs it)
      final bgStatus = await Permission.locationAlways.request();

      if (bgStatus.isGranted) {
        debugPrint("Background location granted ✅");
      } else {
        debugPrint("Background location denied ❌");
      }
    } else {
      debugPrint("Foreground location denied ❌");
    }
  }
}
