import 'package:flutter/material.dart';

import 'helper/app_router.dart';
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

void main() {
  runApp(MyApp(approuter: AppRouter(),));

}

class MyApp extends StatelessWidget {
  final AppRouter approuter;

  const MyApp({ Key? key,required this.approuter}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: approuter.generateRoute ,
    );
  }
}

