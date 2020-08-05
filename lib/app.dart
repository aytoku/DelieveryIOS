import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/device_id_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Food Delivery App",
      theme: ThemeData(
        primaryColor: Color(0xFFFD6F6D),
        cursorColor: Color(0xFFFD6F6D),
      ),
      home: DeviceIdScreen(),
    );
  }
}
