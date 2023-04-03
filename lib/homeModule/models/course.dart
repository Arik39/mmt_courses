import 'package:flutter/material.dart';

class Course {
  final String? id;
  final String title;
  final String image;
  final Color? imageBgColor;
  final String subtitle;

  final bool isFree;
  final double originalPrice;
  final double discountedPrice;
  final Color? imgTextColor;
  final List tags;
  final String description;
  final Map? review;

  final String categoryType;
  double courseCompletionPctOfTotal;

  final String moduleLevel;
  final int noOfModules;
  final int timeToCompleteCourse;
  final List courseHighlights;
  final List requirements;
  final Map aboutInstructor;
  Course({
    required this.noOfModules,
    required this.timeToCompleteCourse,
    required this.courseHighlights,
    required this.requirements,
    required this.aboutInstructor,
    this.courseCompletionPctOfTotal = 0.0,
    required this.moduleLevel,
    required this.categoryType,
    this.id,
    required this.title,
    required this.image,
    this.imageBgColor,
    required this.subtitle,
    required this.isFree,
    required this.originalPrice,
    required this.discountedPrice,
    this.imgTextColor,
    required this.tags,
    required this.review,
    required this.description,
  });

  static Course jsonToUser(Map course) {
    return Course(
      id: course['id'],
      title: course['title'],
      image: course['image'],
      aboutInstructor: course['aboutInstructor'],
      categoryType: course['categoryType'],
      courseHighlights: course['courseHighlights'],
      description: course['description'],
      discountedPrice: double.parse(course['discountedPrice'].toString()),
      moduleLevel: course['moduleLevel'],
      noOfModules: course['noOfModules'],
      originalPrice: double.parse(course['originalPrice'].toString()),
      requirements: course['requirements'],
      review: course['review'],
      subtitle: course['subtitle'],
      isFree: course['categoryType'] == 'free',
      tags: course['tags'],
      timeToCompleteCourse: course['timeToCompleteCourse'],
    );
  }
}
