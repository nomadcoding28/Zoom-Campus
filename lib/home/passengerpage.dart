import 'package:flutter/material.dart';
import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http;
import 'package:zoomcampus/controller/controller.dart';
import 'package:zoomcampus/data/data.dart';
import 'package:zoomcampus/home/riderpage.dart';
import 'package:zoomcampus/map/map.dart';
class PassengerPage extends StatefulWidget {
final String selectedCategory;
final String gate;
  PassengerPage({Key? key, required this.selectedCategory, required this.gate}) : super(key: key);

  @override
  _PassengerPageState createState() => _PassengerPageState();
}

class _PassengerPageState extends State<PassengerPage> {
  List<Map<String, dynamic>> data = []; // List to hold passenger or rider data
  bool isLoading = true; // Loading indicator
  bool hasError = false;
  String ?selectedCategory; // Default category

  // Backend URLs for fetching data
  final String passengerApiUrl = '/requestride/'; // Replace with your API URL
  final String riderApiUrl = '/rideractivate/'; // Replace with your API URL
  bool passenger = true;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.selectedCategory;
    fetchData(); // Fetch initial data
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      final apiUrl = selectedCategory == 'Passenger' ? passengerApiUrl : riderApiUrl;
      passenger = selectedCategory == 'Passenger' ? true : false;
      final response;
      print(selectedCategory);
      if(selectedCategory=='Passenger'){
      response = await http.post(Uri.http(ip,apiUrl),
      body:jsonEncode({"mail":mail}));
      }else{
        response = await http.post(Uri.http(ip,apiUrl),
      body:jsonEncode({"mail":mail, "gate":widget.gate}));
      }

      if (response.statusCode == 200) {
        // Parse the JSON response
        final List<dynamic> jsonData = jsonDecode(response.body);
        setState(() {
          data = jsonData
              .map((item) => {
                    'name': item['name'] ?? 'Unknown',
                    'gender': item['gender'] ?? 'Unknown',
                    'destination': item['destination'] ?? 'Unknown',
                    'phNo': item['phNo'] ?? '0.0',
                    'gate':item['gate']??'10',
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
      // print('Error: $e');
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
    if (widget.selectedCategory == 'Passenger') {
      return __build(context);
    } else {
      return RiderPage(selectedCategory: widget.selectedCategory, gate: widget.gate); // Pass mail and gate to RiderPage
    }
  }
  
  Widget __build(BuildContext context) {
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
                onPressed: () => {if(passenger) switchCategory('Passengers')},
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedCategory == 'Passengers' ? Colors.green : Colors.grey,
                ),
                child: const Text('Passengers'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () =>  { if(!passenger) switchCategory('Riders')},
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
                                          'phNo: ${item['phNo']}',
                                          style: const TextStyle(fontSize: 14, color: Colors.orange),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'gate: ${item['gate']}',
                                          style: const TextStyle(fontSize: 14, color: Colors.orange),
                                        ),
                                        const SizedBox(height: 16),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () async{
                                                coridermail=mail;
                                                ridermail = item['mail'];
                                                // int t = await coriderRequest(item['mail']);

                                                Navigator.push(context, MaterialPageRoute(builder: (context)=> MyWidget()));
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

class _RiderPageState extends State<RiderPage> {
  List<Map<String, dynamic>> data = []; // List to hold passenger or rider data
  bool isLoading = true; // Loading indicator
  bool hasError = false;
  String ?selectedCategory; // Default category

  // Backend URLs for fetching data
  final String passengerApiUrl = '/requestride/'; // Replace with your API URL
  final String riderApiUrl = '/rideractivate/'; // Replace with your API URL
  bool passenger = true;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.selectedCategory;
    fetchData(); // Fetch initial data
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      final apiUrl = selectedCategory == 'Passenger' ? passengerApiUrl : riderApiUrl;
      passenger = selectedCategory == 'Passenger' ? true : false;
      final response;
      print(selectedCategory);
      if(selectedCategory=='Passenger'){
      response = await http.post(Uri.http(ip,apiUrl),
      body:jsonEncode({"mail":mail}));
      }else{
        response = await http.post(Uri.http(ip,apiUrl),
      body:jsonEncode({"mail":mail, "gate":widget.gate}));
      }

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
      // print('Error: $e');
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
                onPressed: () => {if(passenger) switchCategory('Passengers')},
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedCategory == 'Passengers' ? Colors.green : Colors.grey,
                ),
                child: const Text('Passengers'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () =>  { if(!passenger) switchCategory('Riders')},
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

