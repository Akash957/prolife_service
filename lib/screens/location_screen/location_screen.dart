import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../bottonNavigation/botton_nav.dart';
import '../../provider/location_provider.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back_rounded),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: "Search for your location/society/apartment",
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          value.isNotEmpty
                              ? locationProvider.searchPlaces(value)
                              : locationProvider.clearSearch();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  await locationProvider.getCurrentLocation();
                  if (locationProvider.currentAddress != null) {
                    // If address is available, navigate to BottomNavScreen
                    Get.to(() => const BottomNavScreen());
                  }
                },
                child: const Row(
                  children: [
                    Icon(Icons.my_location, color: Colors.red),
                    SizedBox(width: 8),
                    Text(
                      'Use current location',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              if (locationProvider.searchResults.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: locationProvider.searchResults.length,
                    itemBuilder: (context, index) {
                      final place = locationProvider.searchResults[index];
                      return ListTile(
                          leading: const Icon(Icons.location_on),
                          title: Text(place['description']),
                          onTap: () async {
                            final address = await locationProvider
                                .getPlaceDetails(place['place_id']);
                            if (address != null) {
                              locationProvider.setAddress(address);
                              locationProvider.clearSearch();
                              Get.to(() => const BottomNavScreen());
                            }
                          });
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
