import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Persistent/persistent.dart';
import '../Widgets/bottom_nav_bar.dart';

class UploadJobNow extends StatefulWidget {
  const UploadJobNow({super.key});

  @override
  State<UploadJobNow> createState() => _UploadJobNowState();
}

class _UploadJobNowState extends State<UploadJobNow> {

  final TextEditingController _jobCategoryController = TextEditingController(text: 'Select Job Category');
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _jobDescriptionController = TextEditingController();
  final TextEditingController _deadlineDateController = TextEditingController();
  final TextEditingController _jobCategoryList = TextEditingController();

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  final _formKey = GlobalKey<FormState>();
  final bool _isLoading = false;

  Widget _textTitles({required String label})
  {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _textFormField({
    required String valueKey,
    required TextEditingController controller,
    required bool enabled,
    required Function fct,
    required int maxLength,
  })
  {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          fct();
        },
        child: TextFormField(
          validator: (value)
          {
            if(value!.isEmpty)
              {
                return 'Value is missing';
              }
            return null;
          },
          controller: controller,
          enabled: enabled,
          key: ValueKey(valueKey),
          style: const TextStyle(
            color: Colors.white,
          ),
          maxLines: valueKey == 'JobDescription' ? 3 : 1,
          maxLength: maxLength,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.black54,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }

  // _showTaskCategoriesDialog({required Size size}) {
  //   showDialog(
  //     context: context,
  //     builder: (ctx) {
  //       return AlertDialog(
  //         backgroundColor: Colors.black54,
  //         title: const Text(
  //           'Job Category',
  //           textAlign: TextAlign.center,
  //           style: TextStyle(fontSize: 20, color: Colors.white),
  //         ),
  //         content: Container(
  //           width: size.width * 0.9,
  //           child: ListView.builder(
  //             shrinkWrap: true,
  //             itemCount: Persistent.jobCategoryList.length,
  //             itemBuilder: (ctx, index) {
  //               return InkWell(
  //                 onTap: () {
  //                   setState(() {
  //                     // jobCategoryFilter = Persistent.jobCategoryList[index];
  //                   });
  //                   Navigator.canPop(context) ? Navigator.pop(context) : null;
  //                   print(
  //                       'jobCategoryList[index], ${Persistent.jobCategoryList[index]}'
  //                   );
  //                 },
  //                 child: Row(
  //                   children: [
  //                     const Icon(
  //                       Icons.arrow_right_alt_outlined,
  //                       color: Colors.grey,
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: Text(
  //                         Persistent.jobCategoryList[index],
  //                         style: const TextStyle(
  //                           color: Colors.grey,
  //                           fontSize: 16,
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               );
  //             },
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  void _saveFormData() async {
    if (_formKey.currentState!.validate()) {
      await _initialization; // Wait for Firebase initialization to complete

      String jobCategory = _jobCategoryController.text;
      String jobTitle = _jobTitleController.text;
      String jobDescription = _jobDescriptionController.text;
      String deadlineDate = _deadlineDateController.text;

      try {
        // Reference to the Firestore collection where you want to save the data
        CollectionReference jobsCollection = FirebaseFirestore.instance.collection('jobs');

        // Add a new document to the collection
        await jobsCollection.add({
          'jobCategory': jobCategory,
          'jobTitle': jobTitle,
          'jobDescription': jobDescription,
          'deadlineDate': deadlineDate,
        });

        // Clear the form fields
        _jobCategoryController.clear();
        _jobTitleController.clear();
        _jobDescriptionController.clear();
        _deadlineDateController.clear();

        // Show a success message or navigate to another screen
        // For example: ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Job posted successfully')));
      } catch (e) {
        // Handle any errors that might occur during the data saving process
        print('Error saving data: $e');
        // Show an error message to the user
        // For example: ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred')));
      }
    }
  }


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
        bottomNavigationBar: BottomNavigationBarForApp(indexNum: 2,),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Upload Job Now'),
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
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Card(
              color: Colors.white10,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),
                    const Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Please fill all fields',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Signatra',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Divider(
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _textTitles(label: 'Job Category :'),
                            _textFormField(
                              valueKey: 'JobCategory',
                              controller: _jobCategoryController,
                              enabled: false,
                              fct: (){},
                              maxLength: 100,
                            ),
                            _textTitles(label: 'Job Title :'),
                            _textFormField(
                              valueKey: 'JobTitle',
                              controller: _jobTitleController,
                              enabled: true,
                              fct: (){},
                              maxLength: 100,
                            ),
                            _textTitles(label: 'Job Description :'),
                            _textFormField(
                              valueKey: 'JobDescription',
                              controller: _jobDescriptionController,
                              enabled: true,
                              fct: (){},
                              maxLength: 100,
                            ),
                            _textTitles(label: 'Job Deadline Date:'),
                            _textFormField(
                              valueKey: 'Deadline',
                              controller: _deadlineDateController,
                              enabled: true,
                              fct: (){},
                              maxLength: 100,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: _isLoading
                          ? const CircularProgressIndicator()
                          : MaterialButton(
                          onPressed: (){
                            _saveFormData();
                          },
                          color: Colors.black,
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Post Now',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    // fontFamily: 'Signatra',
                                  ),
                                ),
                                SizedBox(width: 9,),
                                Icon(
                                  Icons.upload_file,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
