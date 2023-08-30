 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ijob_flutter/user_state.dart';
import 'package:ijob_flutter/Widgets/bottom_nav_bar.dart';
import 'package:ijob_flutter/Persistent/persistent.dart';

class JobScreen extends StatefulWidget {

   @override
   State<JobScreen> createState() => _JobScreenState();
 }

 class _JobScreenState extends State<JobScreen> {

  String? jobCategoryFilter;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  _showTaskCategoriesDialog({required Size size}) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Colors.black54,
          title: const Text(
            'Job Category',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          content: Container(
            width: size.width * 0.9,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: Persistent.jobCategoryList.length,
              itemBuilder: (ctx, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      jobCategoryFilter = Persistent.jobCategoryList[index];
                    });
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                    print(
                      'jobCategoryList[index], ${Persistent.jobCategoryList[index]}'
                    );
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_right_alt_outlined,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          Persistent.jobCategoryList[index],
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: ()
              {
                Navigator.canPop(context) ? Navigator.pop(context) : null;
              },
              child: const Text('Close', style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),),
            ),
            TextButton(
              onPressed: ()
              {
                setState(() {
                  jobCategoryFilter = null;
                });
                Navigator.canPop(context) ? Navigator.pop(context) : null;
              },
              child: const Text('Cancel Filter', style: TextStyle(color: Colors.white),),
            ),
          ],
        );
      },
    );
  }


  @override
   Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
           leading: IconButton(
             icon: const Icon(Icons.filter_list_rounded, color: Colors.black,),
             onPressed: (){
               _showTaskCategoriesDialog(size: size);
             },
           ),
         ),
       ),
     );
   }
 }
