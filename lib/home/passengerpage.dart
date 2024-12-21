// // import 'package:flutter/material.dart';

// // import '../controller/fetchRider.dart';

// // class PassengerPage extends StatefulWidget {
// //   @override
// //   _PassengerPageState createState() => _PassengerPageState();
// // }

// // class _PassengerPageState extends State<PassengerPage> {
// //   Future<List<dynamic>>? _ridersFuture;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _ridersFuture = fetchRiders();
// //   }

// //   void _selectRider(dynamic rider) {
// //     // Handle rider selection logic here
// //     print("Selected Rider: ${rider['name']}");
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(content: Text("Rider ${rider['name']} selected!")),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Select Rider"),
// //       ),
// //       body: FutureBuilder<List<dynamic>>(
// //         future: _ridersFuture,
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return Center(child: CircularProgressIndicator());
// //           } else if (snapshot.hasError) {
// //             return Center(
// //               child: Text("Failed to load riders: ${snapshot.error}"),
// //             );
// //           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
// //             return Center(
// //               child: Text("Rides not available"),
// //             );
// //           }

// //           final riders = snapshot.data!;
// //           return ListView.builder(
// //             itemCount: riders.length,
// //             itemBuilder: (context, index) {
// //               final rider = riders[index];
// //               return Card(
// //                 margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
// //                 child: ListTile(
// //                   leading: CircleAvatar(
// //                     child: Text(rider['name'][0]),
// //                   ),
// //                   title: Text(rider['name']),
// //                   subtitle: Text("Location: ${rider['location']}\nRating: ${rider['rating']}"),
// //                   trailing: ElevatedButton(
// //                     onPressed: () => _selectRider(rider),
// //                     child: Text("Select"),
// //                   ),
// //                 ),
// //               );
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'dart:convert'; // For JSON decoding
// import 'package:http/http.dart' as http;

// class PassengerPage extends StatefulWidget {
//   const PassengerPage({Key? key}) : super(key: key);

//   @override
//   _PassengerPageState createState() => _PassengerPageState();
// }

// class _PassengerPageState extends State<PassengerPage> {
//   List<Map<String, dynamic>> data = []; // List to hold passenger or rider data
//   bool isLoading = true; // Loading indicator
//   bool hasError = false;
//   String selectedCategory = 'Passengers'; // Default category

//   // Backend URLs for fetching data
//   final String passengerApiUrl = 'https://example.com/api/passengers'; // Replace with your API URL
//   final String riderApiUrl = 'https://example.com/api/riders'; // Replace with your API URL

//   @override
//   void initState() {
//     super.initState();
//     fetchData(); // Fetch initial data
//   }

//   Future<void> fetchData() async {
//     setState(() {
//       isLoading = true;
//       hasError = false;
//     });

//     try {
//       final apiUrl = selectedCategory == 'Passengers' ? passengerApiUrl : riderApiUrl;
//       final response = await http.get(Uri.parse(apiUrl));

//       if (response.statusCode == 200) {
//         // Parse the JSON response
//         final List<dynamic> jsonData = jsonDecode(response.body);
//         setState(() {
//           data = jsonData
//               .map((item) => {
//                     'name': item['name'] ?? 'Unknown',
//                     'destination': item['destination'] ?? 'Unknown',
//                     'time': item['time'] ?? 'N/A',
//                   })
//               .toList();
//           isLoading = false;
//         });
//       } else {
//         throw Exception('Failed to fetch data');
//       }
//     } catch (e) {
//       setState(() {
//         hasError = true;
//         isLoading = false;
//       });
//       print('Error: $e');
//     }
//   }

//   void switchCategory(String category) {
//     setState(() {
//       selectedCategory = category;
//     });
//     fetchData(); // Fetch data for the selected category
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('$selectedCategory Details'),
//         backgroundColor: Colors.green,
//       ),
//       body: Column(
//         children: [
//           // Category Switch Buttons
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () => switchCategory('Passengers'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: selectedCategory == 'Passengers' ? Colors.green : Colors.grey,
//                 ),
//                 child: const Text('Passengers'),
//               ),
//               const SizedBox(width: 10),
//               ElevatedButton(
//                 onPressed: () => switchCategory('Riders'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: selectedCategory == 'Riders' ? Colors.green : Colors.grey,
//                 ),
//                 child: const Text('Riders'),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           // Main Content
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: isLoading
//                   ? const Center(
//                       child: CircularProgressIndicator(), // Show loader while fetching data
//                     )
//                   : hasError
//                       ? Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const Text(
//                                 'Failed to load data.',
//                                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                               ),
//                               const SizedBox(height: 10),
//                               ElevatedButton(
//                                 onPressed: fetchData,
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.green,
//                                 ),
//                                 child: const Text('Retry'),
//                               ),
//                             ],
//                           ),
//                         )
//                       : data.isEmpty
//                           ? Center(
//                               child: Text(
//                                 'No $selectedCategory available.',
//                                 style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                               ),
//                             )
//                           : ListView.builder(
//                               itemCount: data.length,
//                               itemBuilder: (context, index) {
//                                 final item = data[index];
//                                 return Card(
//                                   margin: const EdgeInsets.only(bottom: 16.0),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   elevation: 4,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(16.0),
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           'Name: ${item['name']}',
//                                           style: const TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 8),
//                                         Text(
//                                           'Destination: ${item['destination']}',
//                                           style: const TextStyle(fontSize: 14),
//                                         ),
//                                         const SizedBox(height: 8),
//                                         Text(
//                                           'Time: ${item['time']}',
//                                           style: const TextStyle(fontSize: 14),
//                                         ),
//                                         const SizedBox(height: 16),
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             ElevatedButton(
//                                               onPressed: () {
//                                                 ScaffoldMessenger.of(context).showSnackBar(
//                                                   SnackBar(
//                                                     content: Text('Contacted ${item['name']}'),
//                                                   ),
//                                                 );
//                                               },
//                                               style: ElevatedButton.styleFrom(
//                                                 backgroundColor: Colors.green,
//                                                 shape: RoundedRectangleBorder(
//                                                   borderRadius: BorderRadius.circular(10),
//                                                 ),
//                                               ),
//                                               child: const Text('Contact'),
//                                             ),
//                                             OutlinedButton(
//                                               onPressed: () {
//                                                 setState(() {
//                                                   data.removeAt(index);
//                                                 });
//                                                 ScaffoldMessenger.of(context).showSnackBar(
//                                                   SnackBar(
//                                                     content: Text('${item['name']} removed!'),
//                                                   ),
//                                                 );
//                                               },
//                                               style: OutlinedButton.styleFrom(
//                                                 foregroundColor: Colors.red,
//                                                 side: const BorderSide(color: Colors.red),
//                                                 shape: RoundedRectangleBorder(
//                                                   borderRadius: BorderRadius.circular(10),
//                                                 ),
//                                               ),
//                                               child: const Text('Remove'),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class PassengerPage extends StatefulWidget {
//   const PassengerPage({Key? key}) : super(key: key);

//   @override
//   _PassengerPageState createState() => _PassengerPageState();
// }

// class _PassengerPageState extends State<PassengerPage> {
//   final List<Map<String, String>> passengers = [
//     {
//       'name': 'John Doe',
//       'destination': 'Gate 1',
//       'time': '8:30 AM',
//     },
//     {
//       'name': 'Jane Smith',
//       'destination': 'Gate 2',
//       'time': '9:00 AM',
//     },
//     {
//       'name': 'Emily Brown',
//       'destination': 'Gate 3',
//       'time': '10:15 AM',
//     },
//     {
//       'name': 'Michael Lee',
//       'destination': 'Gate 4',
//       'time': '11:45 AM',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Passenger Details'),
//         backgroundColor: Colors.green,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView.builder(
//           itemCount: passengers.length,
//           itemBuilder: (context, index) {
//             final passenger = passengers[index];
//             return Card(
//               margin: const EdgeInsets.only(bottom: 16.0),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               elevation: 4,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Name: ${passenger['name']}',
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Destination: ${passenger['destination']}',
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Time: ${passenger['time']}',
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                     const SizedBox(height: 16),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text('Contacted ${passenger['name']}'),
//                               ),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           child: const Text('Contact'),
//                         ),
//                         OutlinedButton(
//                           onPressed: () {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text('${passenger['name']} removed!'),
//                               ),
//                             );
//                           },
//                           style: OutlinedButton.styleFrom(
//                             foregroundColor: Colors.red,
//                             side: const BorderSide(color: Colors.red),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           child: const Text('Remove'),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http;
import 'package:zoomcampus/data/data.dart';

class PassengerPage extends StatefulWidget {
  const PassengerPage({Key? key}) : super(key: key);

  @override
  _PassengerPageState createState() => _PassengerPageState();
}

class _PassengerPageState extends State<PassengerPage> {
  List<Map<String, dynamic>> data = []; // List to hold passenger or rider data
  bool isLoading = true; // Loading indicator
  bool hasError = false;
  String selectedCategory = 'Passengers'; // Default category

  // Backend URLs for fetching data
  final String passengerApiUrl = 'http://192.168.31.48:8000/requestride/'; // Replace with your API URL
  final String riderApiUrl = 'http://192.168.31.48:8000/rideractivate/'; // Replace with your API URL

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch initial data
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      final apiUrl = selectedCategory == 'Passengers' ? passengerApiUrl : riderApiUrl;
      final response = await http.post(Uri.parse(apiUrl),
      body:jsonEncode({"mail":"nirmithmr@gmail.com"}));

      if (response.statusCode == 200) {
        // Parse the JSON response
        final List<dynamic> jsonData = jsonDecode(response.body);
        setState(() {
          data = jsonData
              .map((item) => {
                    'name': item['name'] ?? 'Unknown',
                    'gender': item['gender'] ?? 'Unknown',
                    'destination': item['destination'] ?? 'Unknown',
                    'rating': item['rating'] ?? '0.0',
                  })
              .toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  void switchCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
    fetchData(); // Fetch data for the selected category
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$selectedCategory Details'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          // Category Switch Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => switchCategory('Passengers'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedCategory == 'Passengers' ? Colors.green : Colors.grey,
                ),
                child: const Text('Passengers'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => switchCategory('Riders'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedCategory == 'Riders' ? Colors.green : Colors.grey,
                ),
                child: const Text('Riders'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Main Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(), // Show loader while fetching data
                    )
                  : hasError
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Failed to load data.',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: fetchData,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        )
                      : data.isEmpty
                          ? Center(
                              child: Text(
                                'No $selectedCategory available.',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            )
                          : ListView.builder(
                              itemCount: selectedCategory == 'Riders' ? 1 : data.length,
                              itemBuilder: (context, index) {
                                final item = data[index];
                                return Card(
                                  margin: const EdgeInsets.only(bottom: 16.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Name: ${item['name']}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Gender: ${item['gender']}',
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Destination: ${item['destination']}',
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Rating: ${item['rating']}',
                                          style: const TextStyle(fontSize: 14, color: Colors.orange),
                                        ),
                                        const SizedBox(height: 16),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text('Request sent to ${item['name']}'),
                                                  ),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: const Text('Request'),
                                            ),
                                            OutlinedButton(
                                              onPressed: () {
                                                setState(() {
                                                  data.removeAt(index);
                                                });
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text('${item['name']} removed!'),
                                                  ),
                                                );
                                              },
                                              style: OutlinedButton.styleFrom(
                                                foregroundColor: Colors.red,
                                                side: const BorderSide(color: Colors.red),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: const Text('Remove'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
            ),
          ),
        ],
      ),
    );
  }
}

