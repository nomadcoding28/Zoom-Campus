import 'dart:io';

import 'package:cronet_http/cronet_http.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'dart:convert';
import 'package:zoomcampus/models/model.dart'; // Assume this contains the User model.
import '../data/data.dart';

// Future fetchUserData() async {
//   String url = "$ip/riderregister/";
//   final response = await http.get(Uri.dataFromString(url));

//   if (response.statusCode == 200) {
//     print("Success\n\n\n\n");
//   } else if (response.statusCode == 205) {
//     print("Fail\n\n\n\n");
//   } else {
//     print("Exception\n\n\n\n");
//     throw Exception('Failed to load user data');
//   }
// }

Future<void> registerUser(Map<String, dynamic> registrationData) async {
  // String url = "http://"+ip+"/riderregister/";
  var client = Client();
  final response = await client.post(
    Uri.http("192.168.31.48:8000","/signup/"),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(registrationData),
  );

  if (response.statusCode != 200) {
    print(registrationData);
    print("FAil\n\n\n\n");
    throw Exception('Failed to register user');
  }else if(response.statusCode == 200){
    print("\n\n\n\nRegistered\n\n\n\n");
  }
}

// Future registerUser(Map<String, dynamic> registrationData) async {
//   final Client httpClient;
//   if (Platform.isAndroid) {
//     final engine = CronetEngine.build(
//         cacheMode: CacheMode.memory,
//         cacheMaxSize: 2 * 1024 * 1024,
//         userAgent: 'Book Agent');
//     httpClient = CronetClient.fromCronetEngine(engine, closeEngine: true);
//   } else {
//     httpClient = IOClient(HttpClient()..userAgent = 'Book Agent');
//   }

//   final response = await client.get(
//     Uri.https(
//       'www.googleapis.com',
//       '/books/v1/volumes',
//       {'q': 'HTTP', 'maxResults': '40', 'printType': 'books'},
//     ),
//   );
//   httpClient.close();
// }



// Future<void> temp(Map<String, String> registrationData) async {
//     // List<int> i = [192,168,31,48]; 
//     String url = "localhost:8000"+"/rider/";
//     var client = http.Client();
//   final response = await client.post(
//     Uri.http("192.168.31.48:8000","/rider/") ,
//     headers: <String, String>{
//       'Content-Type': 'application/json',
//     },
//     // body: jsonEncode(registrationData),
//   );

//   if (response.statusCode != 200) {
//     throw Exception('\n\n\n\nFailed to register user\n\n\n\n');
//   }else if(response.statusCode == 200){
//     print("\n\n\n\nRegistered\n\n\n\n");
//   }
// }
