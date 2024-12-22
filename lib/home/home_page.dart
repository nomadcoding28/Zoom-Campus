import 'package:flutter/material.dart';
import 'package:zoomcampus/controller/controller.dart';
import 'package:zoomcampus/home/passengerpage.dart';

class HomePage extends StatefulWidget {
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedRole = 'Passenger';
  int _currentIndex = 0;
  
  final TextEditingController gateController = TextEditingController();
  final TextEditingController otherGateController = TextEditingController();
  final TextEditingController vehicleRegController = TextEditingController();
  final TextEditingController seatsController = TextEditingController();

  String selectedGate = 'Gate 1'; // Default gate selection

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
                    onTap: () => setState((){
                      // print("1");
                      selectedRole = 'Rider' ;

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
              DropdownButtonFormField<String>(
                value: selectedGate,
                items: ['Gate 1', 'Gate 2', 'Others']
                    .map((gate) => DropdownMenuItem<String>(
                          value: gate,
                          child: Text(gate),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedGate = value!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Select Gate',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              if (selectedGate == 'Others') // Show text field if "Others" is selected
                TextField(
                  controller: otherGateController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Gate Name',
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
                    labelText: 'Number of Seats Available (Max 3)',
                    border: OutlineInputBorder(),
                  ),
                  
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      final seats = int.tryParse(value);
                      if (seats == null || seats < 1 || seats > 3) {
                        seatsController.text = '';
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter a valid number of seats (1 to 3).'),
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
              const SizedBox(height: 20),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(31),
                ),
                height: 40,
                color: Colors.green,
                onPressed: () {
                  if (selectedRole.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select a role to proceed.'),
                      ),
                    );
                    return;
                  }

                  final gate = selectedGate == 'Others'
                      ? otherGateController.text.trim()
                      : selectedGate;

                  if (gate.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please provide a valid gate name.'),
                      ),
                    );
                    return;
                  }

                  if (selectedRole == 'Rider') {
                    final vehicleReg = vehicleRegController.text.trim();
                    final seats = seatsController.text.trim();

                    if (vehicleReg.isEmpty || seats.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill all rider details.'),
                        ),
                      );
                      return;
                    }

                    print('Rider Gate: $gate');
                    print('Vehicle Registration Number: $vehicleReg');
                    print('Seats Available: $seats');
                    print('Gate: $gate  '+gate.substring(5));
                  } else {
                    print('Passenger Gate: '+ gate.substring(5));
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$selectedRole details submitted!')),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  PassengerPage(selectedCategory: selectedRole, gate:(gate.substring(5))),
                    ),
                  );
                },
                child: const Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
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
