import 'package:flutter/material.dart';
import 'package:zoomcampus/bottomNavigation/bottomNavigation.dart';
import 'package:zoomcampus/user_info/registerDetails.dart';

class Userinfo extends StatefulWidget {
  const Userinfo({super.key});

  @override
  State<Userinfo> createState() => _UserinfoState();
}

class _UserinfoState extends State<Userinfo> {
  bool rememberMe = true;
  String selectedGender = 'Male'; // Default gender
  String selectedProgram = 'Computer Science'; // Default program
  String otherProgram = ''; // To hold the custom program name
  bool isOtherProgramSelected = false; // Flag to show/hide the text field

  final List<String> programs = [
    'Computer Science',
    'Mechanical',
    'Electrical',
    'Civil',
    'Electronics',
    'Information Technology',
    'Others',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          // Dismiss the keyboard when tapping outside of text fields
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            _buildHeader(),
            _buildForm(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60),
          bottomRight: Radius.circular(60),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 350,
            child: Image.asset('assets/images/logo.png'),
          ),
          const SizedBox(height: 20),
          const Text(
            'Millions of songs, free on Spotify',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              margin: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height / 1.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Add Personal Details',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  _buildPhoneInput(),
                  const SizedBox(height: 20),
                  _buildGenderSelection(),
                  const SizedBox(height: 20),
                  _buildProgramDropdown(),
                  if (isOtherProgramSelected) _buildOtherProgramInput(),
                  const SizedBox(height: 20),
                  // _buildRememberMeCheckbox(),
                  _buildSubmitButton(context),
                  const SizedBox(height: 15),
                  const Divider(),
                  const SizedBox(height: 10),
                  _buildLoginLink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneInput() {
    return TextField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: 'Phone',
        prefixIcon: const Icon(Icons.phone_android_sharp),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }

  Widget _buildGenderSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gender:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Row(
          children: [
            Radio<String>(
              value: 'Male',
              groupValue: selectedGender,
              onChanged: (value) {
                setState(() {
                  selectedGender = value!;
                });
              },
            ),
            const Text('Male'),
            Radio<String>(
              value: 'Female',
              groupValue: selectedGender,
              onChanged: (value) {
                setState(() {
                  selectedGender = value!;
                });
              },
            ),
            const Text('Female'),
          ],
        ),
      ],
    );
  }

  Widget _buildProgramDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Program:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        DropdownButton<String>(
          value: selectedProgram,
          isExpanded: true,
          items: programs.map((String program) {
            return DropdownMenuItem<String>(
              value: program,
              child: Text(program),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedProgram = value!;
              isOtherProgramSelected = (value == 'Others');
            });
          },
        ),
      ],
    );
  }

  Widget _buildOtherProgramInput() {
    return TextField(
      onChanged: (value) {
        setState(() {
          otherProgram = value;
        });
      },
      decoration: InputDecoration(
        hintText: 'Enter Program',
        prefixIcon: const Icon(Icons.text_fields),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }

  // Widget _buildRememberMeCheckbox() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       Checkbox(
  //         value: rememberMe,
  //         onChanged: (bool? value) {
  //           setState(() {
  //             rememberMe = value ?? false;
  //           });
  //         },
  //       ),
  //       const Text(
  //         'Remember Me',
  //         style: TextStyle(fontSize: 14, color: Colors.grey),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildSubmitButton(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(31),
      ),
      height: 40,
      color: Colors.green,
      onPressed: () {
        String program = isOtherProgramSelected ? otherProgram : selectedProgram;
        print('Selected Gender: $selectedGender');
        print('Selected Program: $program');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  RegisterDetailsPage(),
          ),
        );
      },
      child: const Text(
        'Submit',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account? ',
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Log In',
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
