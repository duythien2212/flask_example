import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String dataFromPython = 'No data yet';
  var headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };
  final url = 'http://127.0.0.1:5000';
  Future<void> fetchData() async {
    try {
      final response = await http.get(
          Uri.parse(url + '/api/data')); // Replace with your Python server URL
      if (response.statusCode == 200) {
        final parsedData = jsonDecode(response.body);
        setState(() {
          dataFromPython = parsedData['message'];
        });
      } else {
        print('Error fetching data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _pushData() async {
    final response = await http.post(Uri.parse(url + '/endpoint'),
        body: json.encode({'message': 'flutter to python'}));
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Python to Flutter'),
        ),
        body: Column(
          children: [
            Center(
              child: Text(dataFromPython),
            ),
            TextButton(onPressed: _pushData, child: const Text('Push')),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: fetchData,
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }
}
