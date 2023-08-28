 import 'package:flutter/material.dart';

class JobScreen extends StatefulWidget {


   @override
   State<JobScreen> createState() => _JobScreenState();
 }

 class _JobScreenState extends State<JobScreen> {
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(title: const Text('Jobs Screen'),),
     );
   }
 }
