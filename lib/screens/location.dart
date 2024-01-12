import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart'; // Updated import for latlong2

class OpenStreetMapApiService {
  final String baseUrl = 'https://nominatim.openstreetmap.org/';

  // Insert your API key here
  final String apiKey = 'https://overpass-api.de/api/interpreter?data=';

  Future<List<dynamic>> fetchNearbyPlaces(double lat, double lon, String placeType) async {
    String url = '${baseUrl}search?format=json&lat=$lat&lon=$lon&zoom=18&addressdetails=1&q=$placeType&key=$apiKey'; // Include API key in the URL

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class NearbyPlacesController extends GetxController {
  final OpenStreetMapApiService _apiService = OpenStreetMapApiService();

  RxList<dynamic> pharmacies = [].obs;
  RxList<dynamic> hospitals = [].obs;

  Future<void> fetchNearbyPlaces(double lat, double lon) async {
    try {
      pharmacies.value = await _apiService.fetchNearbyPlaces(lat, lon, 'pharmacy');
      hospitals.value = await _apiService.fetchNearbyPlaces(lat, lon, 'hospital');
    } catch (e) {
      print('Error: $e');
    }
  }
}

class DistanceCalculator {
  static Future<double> calculateDistance(double startLat, double startLon, double endLat, double endLon) async {
    double distanceInMeters = await Geolocator.distanceBetween(startLat, startLon, endLat, endLon);
    return distanceInMeters;
  }
}

class location extends StatelessWidget {

  TextEditingController distanceController = TextEditingController();


  final NearbyPlacesController nearbyPlacesController = Get.put(NearbyPlacesController());

  var selectedPlace = {
    'lat': '27.1767', // Agra Latitude
    'lon': '78.0081', // Agra Longitude
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Places Map'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: distanceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Distance (in meters)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                double userLat = 27.1767; // Agra Latitude
                double userLon = 78.0081; // Agra Longitude
                await nearbyPlacesController.fetchNearbyPlaces(userLat, userLon);
              },
              child: Text('Fetch Nearby Places'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Obx(
                    () => (nearbyPlacesController.pharmacies.isEmpty &&
                    nearbyPlacesController.hospitals.isEmpty)
                    ? Center(child: Text('No places found'))
                    : FlutterMap(
                  options: const MapOptions(
                    initialCenter: LatLng(27.1767, 78.0081), // Agra as default center
                    initialZoom: 13.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: [
                        for (var pharmacy in nearbyPlacesController.pharmacies)
                          Marker(
                            width: 40.0,
                            height: 40.0,
                            point: LatLng(
                              double.parse(pharmacy['lat']),
                              double.parse(pharmacy['lon']),
                            ),
                            child: Builder( builder: (_) => Icon(Icons.local_pharmacy, color: Colors.green),)
                          ),
                        for (var hospital in nearbyPlacesController.hospitals)
                          Marker(
                            width: 40.0,
                            height: 40.0,
                            point: LatLng(
                              double.parse(hospital['lat']),
                              double.parse(hospital['lon']),
                            ),
                           child: Builder( builder: (_) => Icon(Icons.local_hospital, color: Colors.red),)
                          ),
                      ],
                    ),
                    if (selectedPlace.isNotEmpty)
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: [
                              LatLng(27.1767, 78.0081), // Agra as starting point
                              LatLng(
                                double.parse(selectedPlace['lat']!),
                                double.parse(selectedPlace['lon']!),
                              ),
                            ],
                            color: Colors.black,
                            strokeWidth: 2.0,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                double distance = double.tryParse(distanceController.text) ?? 0.0;
                if (distance > 0 && selectedPlace.isNotEmpty) {
                  double endLat = double.tryParse(selectedPlace['lat'] ?? '') ?? 0.0;
                  double endLon = double.tryParse(selectedPlace['lon'] ?? '') ?? 0.0;
                  double userLat = 27.1767; // Replace with user's actual location
                  double userLon = 78.0081;

                  double calculatedDistance =
                  await DistanceCalculator.calculateDistance(userLat, userLon, endLat, endLon);
                  if (calculatedDistance <= distance) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('You are within $distance meters of the selected place.'),
                      ),
                    );
                    // Perform navigation logic or other actions
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('The selected place is beyond $distance meters.'),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Enter a valid distance and select a place.'),
                    ),
                  );
                }
              },
              child: Text('Check Path'),
            ),
          ],
        ),
      ),
    );
  }
}
