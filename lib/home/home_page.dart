import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedRole = '';
  int _currentIndex = 0;
  final TextEditingController gateController = TextEditingController();
  final TextEditingController vehicleRegController = TextEditingController();
  final TextEditingController seatsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rider or Passenger'),
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
                'Select Your Role:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => setState(() {
                      selectedRole = 'Passenger';
                    }),
                    child: RoleBlock(
                      label: 'Passenger',
                      isSelected: selectedRole == 'Passenger',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() {
                      selectedRole = 'Rider';
                    }),
                    child: RoleBlock(
                      label: 'Rider',
                      isSelected: selectedRole == 'Rider',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Gate Details',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: gateController,
                decoration: const InputDecoration(
                  labelText: 'Gate',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              if (selectedRole == 'Rider') ...[
                const Text(
                  'Rider Details',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: vehicleRegController,
                  decoration: const InputDecoration(
                    labelText: 'Vehicle Registration Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: seatsController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Number of Seats Available',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (selectedRole.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select a role to proceed.'),
                      ),
                    );
                    return;
                  }

                  final gate = gateController.text;

                  if (selectedRole == 'Rider') {
                    final vehicleReg = vehicleRegController.text;
                    final seats = seatsController.text;

                    print('Rider Gate: $gate');
                    print('Vehicle Registration Number: $vehicleReg');
                    print('Seats Available: $seats');
                  } else {
                    print('Passenger Gate: $gate');
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$selectedRole details submitted!')),
                  );

                  // Clear fields
                  gateController.clear();
                  vehicleRegController.clear();
                  seatsController.clear();
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

class RoleBlock extends StatelessWidget {
  final String label;
  final bool isSelected;

  const RoleBlock({Key? key, required this.label, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isSelected ? Colors.green : Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? Colors.green : Colors.grey,
          width: 2,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
