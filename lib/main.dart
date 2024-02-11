// ignore_for_file: must_call_super, avoid_print, use_build_context_synchronously, unnecessary_null_comparison, unused_element, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:uas_crud/tabbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CRUD SQL',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const tabBarMain(),
    );
  }
}