import 'package:flutter/material.dart';
import 'package:zoomcampus/controller/controller.dart';
import 'package:zoomcampus/home/home_page.dart'; // Ensure this file and class exist
import 'package:zoomcampus/data/data.dart' as dt;

class RegisterDetailsPage extends StatefulWidget {
  const RegisterDetailsPage({super.key});

  @override
  _RegisterDetailsPageState createState() => _RegisterDetailsPageState();
}

class _RegisterDetailsPageState extends State<RegisterDetailsPage> {
  final TextEditingController sourceController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final List<TextEditingController> checkpointControllers = [];

  void addCheckpoint() {
    setState(() {
      checkpointControllers.add(TextEditingController());
    });
  }

  void removeCheckpoint(int index) {
    setState(() {
      checkpointControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Details'),
        backgroundColor: Colors.green,
      ),
      resizeToAvoidBottomInset: true, // Ensures UI adjusts to avoid keyboard overlap
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter your Route details:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: sourceController,
                decoration: const InputDecoration(
                  labelText: 'Source',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: destinationController,
                decoration: const InputDecoration(
                  labelText: 'Destination',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Checkpoints',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                height: 200, // Set a fixed height for the scrollable area
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (int i = 0; i < checkpointControllers.length; i++)
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: checkpointControllers[i],
                                decoration: InputDecoration(
                                  labelText: 'Checkpoint ${i + 1}',
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.remove_circle,
                                  color: Colors.red),
                              onPressed: () => removeCheckpoint(i),
                            ),
                          ],
                        ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: addCheckpoint,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text('Add Checkpoint'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final source = sourceController.text.trim();
                  final destination = destinationController.text.trim();

                  // Check if all fields are filled
                  if (source.isEmpty || destination.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill in all details to proceed.'),
                      ),
                    );
                    return;
                  }

                  final checkpoints = checkpointControllers
                      .map((controller) => controller.text.trim())
                      .toList();

                  // Log the entered details
                  // print('Source: $source');
                  // print('Destination: $destination');
                  // print('Checkpoints: $checkpoints');

                  List route = [source]+checkpoints+[destination];

                  dt.route = route.toString();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Details submitted successfully!')),
                  );

                  // Clear fields after submission
                  sourceController.clear();
                  destinationController.clear();
                  checkpointControllers.clear();

                  Map<String, dynamic> details = {
                    "mail":dt.mail,
                    "password":dt.password,
                    "name":dt.username,
                    "phNo":dt.phNo,
                    "gender":dt.gender,
                    "program":dt.program,
                    "route":dt.route
                  };

                   registerUser(details);

                  // Navigate to the HomePage after submission
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  HomePage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.all(15),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
