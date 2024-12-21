import 'package:flutter/material.dart';
import 'package:zoomcampus/bottomNavigation/bottomNavigation.dart';
import 'package:zoomcampus/controller/controller.dart';
import 'package:zoomcampus/data/data.dart' as dt;
import 'package:zoomcampus/user_info/userinfo.dart';
import 'package:zoomcampus/widgets/input.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final TextEditingController username = TextEditingController();
  final TextEditingController mail = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool rememberme = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        child: Stack(
          children: [
            Container(
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
                      child: Image.asset('assets/images/logo.png')),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Millions of songs, free on Spotify',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 20),
                      margin: const EdgeInsets.all(20),
                      height: MediaQuery.of(context).size.height / 1.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'SignUp Account',
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 40,
                            child: Input(
                              controller: username,
                              hintText: 'Username',
                              icon: Icons.person,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            height: 40,
                            child: Input(
                              controller: mail,
                              key: GlobalObjectKey("mail"),
                              hintText: 'Email',
                              icon: Icons.email_outlined,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            height: 40,
                            child: Input(
                              controller: password,
                              hintText: 'password',
                              icon: Icons.lock,
                              isObscure: true,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SwitchListTile.adaptive(
                            contentPadding: const EdgeInsets.all(0),
                            value: rememberme,
                            onChanged: (bool value) {
                              setState(() {
                                rememberme = value;
                              });
                            },
                            title: const Text('Remember Me',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey)),
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(31)),
                            height: 40,
                            color: Colors.green,
                            onPressed: () {
                              dt.mail = mail.text;
                              dt.password = password.text;
                              dt.username = username.text;

                              // Map<String,String> t = {"mail":"nirmithmr@gmail.com"};
                              // registerUser(t);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          const Userinfo())));
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          const Divider(),
                          const Spacer(),
                          Row(
                            children: [
                              const Text(
                                'Already have an account? ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'LogIn',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w700),
                                ),
                              )
                            ],
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
