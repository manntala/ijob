import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ijob_flutter/Jobs/jobs_screen.dart';
import 'package:ijob_flutter/Jobs/upload_job.dart';
import 'package:ijob_flutter/Search/profile_company.dart';
import 'package:ijob_flutter/Search/search_companies.dart';

class BottomNavigationBarForApp extends StatelessWidget {
  
  int indexNum = 0;

  BottomNavigationBarForApp({required this.indexNum});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      color: Colors.deepOrange.shade400,
      backgroundColor: Colors.blueAccent,
      buttonBackgroundColor: Colors.deepOrange.shade300,
      height: 50.0,
      index: indexNum,
      items: const [
        Icon(Icons.list, size: 19.0, color: Colors.black, ),
        Icon(Icons.search, size: 19.0, color: Colors.black,),
        Icon(Icons.add, size: 19.0, color: Colors.black,),
        Icon(Icons.person_pin, size: 19.0, color: Colors.black,),
      ],
      animationDuration: const Duration(
        microseconds: 300,
      ),
      animationCurve: Curves.easeIn,
      onTap: (index) 
      {
        if(index == 0)
          {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => JobScreen()));
          }
         else if(index == 1)
          {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AllWorkersScreen()));
          }
        else if(index == 2)
          {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => UploadJobNow()));
          }
        else if(index == 3)
        {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ProfileScreen()));
        }
      },
    );
  }
}
