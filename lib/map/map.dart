import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:zoomcampus/api/api.dart';
import "dart:convert";
import 'package:http/http.dart' as http;
import 'package:zoomcampus/data/data.dart';

// class MyWidget extends StatefulWidget {
//   const MyWidget({super.key});

//   @override
//   State<MyWidget> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   @override
//   void initState() {
//     super.initState();
//     getCoordinates();
//   }

//   List listOfPoints = [];
//   List<LatLng> points = [];

//   // Fetch coordinates for the route
//   getCoordinates() async {
//     var response =
//         await http.get(getRouteUrl('77.5651,13.0308', '77.517156,13.066563'));
//     setState(() {
//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.body);
//         listOfPoints = data['features'][0]['geometry']['coordinates'];
//         points = listOfPoints
//             .map((p) => LatLng(p[1].toDouble(), p[0].toDouble()))
//             .toList();
//       }
//     });
//   }

//   // Fetch rider or passenger details
//   void fetchDetails(String role) async {
//     try {
//       // Replace with your actual API endpoint
//       var response = await http
//           .get(Uri.parse('http://192.168.31.48:8000/riderAcceptRide/'));
//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.body);
//         String email =
//             role == "rider" ? data['rider']['email'] : data['co']['email'];
//         String phone = role == "rider"
//             ? data['rider']['phone']
//             : data['passenger']['phone'];
//         showDetailsPopup(role, email, phone);
//       } else {
//         print("Failed to fetch details: ${response.body}");
//       }
//     } catch (e) {
//       print("Error fetching details: $e");
//     }
//   }

//   // Show a popup with rider/passenger details
//   void showDetailsPopup(String role, String email, String phone) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("${role == 'rider' ? 'Rider' : 'Passenger'} Details"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text("Email: $email"),
//               Text("Phone: $phone"),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text("Close"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           FlutterMap(
//             options: MapOptions(
//                 initialZoom: 15,
//                 initialCenter: LatLng(13.0246499014, 77.5589810974)),
//             children: [
//               TileLayer(
//                 urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                 userAgentPackageName: 'dev.fleaflet.flutter_map.example',
//               ),
//               MarkerLayer(
//                 markers: [
//                   Marker(
//                     point: LatLng(13.0308, 77.5651),
//                     width: 80,
//                     height: 80,
//                     child: const Icon(
//                       Icons.location_on,
//                       size: 40,
//                       color: Colors.red,
//                     ),
//                   ),
//                   Marker(
//                     point: LatLng(13.066563, 77.517156),
//                     width: 80,
//                     height: 80,
//                     child: const Icon(
//                       Icons.location_on,
//                       size: 40,
//                       color: Colors.red,
//                     ),
//                   ),
//                 ],
//               ),
//               PolylineLayer(
//                 polylines: [
//                   Polyline(
//                     points: points,
//                     color: Colors.blue,
//                     strokeWidth: 5,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           Positioned(
//             bottom: 20,
//             left: 20,
//             right: 20,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () => fetchDetails("rider"),
//                   child: Text("Rider Info"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () => fetchDetails("passenger"),
//                   child: Text("Passenger Info"),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import "dart:convert";
import 'package:http/http.dart' as http;
import 'package:zoomcampus/api/api.dart';
// import 'package:data/data.dart;

import 'package:zoomcampus/data/data.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  void initState() {
    super.initState();
    getCoordinates();
  }

  List listOfPoints = [];
  List<LatLng> points = [];

  // Fetch coordinates for the route
  getCoordinates() async {
    var response =
        await http.get(getRouteUrl('77.5651,13.0308', '77.517156,13.066563'));
    setState(() {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        listOfPoints = data['features'][0]['geometry']['coordinates'];
        points = listOfPoints
            .map((p) => LatLng(p[1].toDouble(), p[0].toDouble()))
            .toList();
      }
    });
  }

  // Fetch rider or passenger details
  // void fetchDetails(String role) async {
  //   try {
  //     // Replace with your actual API endpoint
  //     var response = await http
  //         .get(Uri.parse('http://192.168.31.48:8000/riderAcceptRide/'));
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       String email =
  //           role == "rider" ? data['rider']['email'] : data['co']['email'];
  //       String phone = role == "rider"
  //           ? data['rider']['phone']
  //           : data['passenger']['phone'];
  //       showDetailsPopup(role, email, phone);
  //     } else {
  //       print("Failed to fetch details: ${response.body}");
  //     }
  //   } catch (e) {
  //     print("Error fetching details: $e");
  //   }
  // }

  // Show a popup with rider/passenger details
  void showDetailsPopup(String role) {
    if (role == "rider") {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("${role == 'rider' ? 'Rider' : 'Passenger'} Details"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Email: $mail"),
                Text("Phone: $phNo"),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Close"),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("${role == 'rider' ? 'Rider' : 'Passenger'} Details"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Email: $mail"),
                Text("Phone: $coridedrphNo"),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Close"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
                initialZoom: 15,
                initialCenter: LatLng(13.0246499014, 77.5589810974)),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(13.0308, 77.5651),
                    width: 80,
                    height: 80,
                    child: const Icon(
                      Icons.location_on,
                      size: 40,
                      color: Colors.red,
                    ),
                  ),
                  Marker(
                    point: LatLng(13.066563, 77.517156),
                    width: 80,
                    height: 80,
                    child: const Icon(
                      Icons.location_on,
                      size: 40,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: points,
                    color: Colors.blue,
                    strokeWidth: 5,
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => showDetailsPopup("rider"),
                  child: Text("Rider Info"),
                ),
                ElevatedButton(
                  onPressed: () => showDetailsPopup("passenger"),
                  child: Text("Passenger Info"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}