 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ijob_flutter/user_state.dart';
import 'package:ijob_flutter/Widgets/bottom_nav_bar.dart';

class JobScreen extends StatefulWidget {


   @override
   State<JobScreen> createState() => _JobScreenState();
 }

 class _JobScreenState extends State<JobScreen> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

   @override
   Widget build(BuildContext context) {
     return Container(
       decoration: BoxDecoration(
         gradient: LinearGradient(
           colors: [Colors.deepOrange.shade300, Colors.blueAccent],
           begin: Alignment.centerLeft,
           end: Alignment.centerRight,
           stops: const [0.2, 0.9],
         ),
       ),
       child: Scaffold(
         bottomNavigationBar: BottomNavigationBarForApp(indexNum: 0),
         backgroundColor: Colors.transparent,
         appBar: AppBar(
           title: const Text('Job Screen'),
           centerTitle: true,
           flexibleSpace: Container(
             decoration: BoxDecoration(
               gradient: LinearGradient(
                 colors: [Colors.deepOrange.shade300, Colors.blueAccent],
                 begin: Alignment.centerLeft,
                 end: Alignment.centerRight,
                 stops: const [0.2, 0.9],
               ),
             ),
           ),
         ),
       ),
     );
   }
 }
