import 'package:flutter/material.dart';

class JobData {
  final String jobCategory;
  final String jobTitle;
  final String jobDescription;
  final String deadlineDate;

  JobData({
    required this.jobCategory,
    required this.jobTitle,
    required this.jobDescription,
    required this.deadlineDate,
  });
}

class Persistent {
  static List<String> jobCategoryList = [
    'Software Development',
    'Design',
    'Marketing',
    'Finance',
    // Add more job categories here
  ];
}

List<JobData> sampleJobs = [
  JobData(
    jobCategory: 'Software Development',
    jobTitle: 'Flutter Developer',
    jobDescription: 'Create amazing Flutter applications.',
    deadlineDate: '2023-09-30',
  ),
  JobData(
    jobCategory: 'Design',
    jobTitle: 'UI/UX Designer',
    jobDescription: 'Design intuitive and user-friendly interfaces.',
    deadlineDate: '2023-10-15',
  ),
  // Add more sample job data here
];
