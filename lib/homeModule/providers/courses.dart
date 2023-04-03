import 'package:flutter/material.dart';

import '../../api.dart';
import '../../http_helper.dart';
import '../models/course.dart';

class Courses with ChangeNotifier {
  List<Course> _items = [];

  List<Course> fetchAllFreeCourses() {
    return [..._items.where((course) => course.isFree == true)];
  }

  List<Course> fecthAllPaidCourses() {
    return [..._items.where((course) => course.isFree == false)];
  }

  Course fetchByCourseId(String id) {
    return _items.firstWhere((course) => course.id == id);
  }

  List<Course> fetchWishlistItems(List id) {
    return _items.where((course) => id.contains(course.id)).toList();
  }

  List<Course> fetchAllEnrolledCourses(List id) {
    print(id);
    return _items.where((course) => id.contains(course.id)).toList();
  }

  Future getAllCourses() async {
    final url = '${webApi['domain']}${api['getAllCourses']}';

    final response = await RemoteServices.httpRequest(
      method: 'GET',
      url: url,
    );

    if (response['success'] && response['result'] != null) {
      List<Course> loadedCourse = [];

      response['result'].forEach((course) {
        loadedCourse.add(Course.jsonToUser(course));
      });

      _items = List.from(loadedCourse);
    }
  }

  Future<List<Course>> getAllModulesByCourseId(String id) async {
    final url = '${webApi['domain']}${api['getAllCourses']}/$id/modules';
    List<Course> loadedCourse = [];
    final response = await RemoteServices.httpRequest(
      method: 'GET',
      url: url,
    );

    if (response['success'] && response['result'] != null) {
      response['result'].forEach((course) {
        loadedCourse.add(Course.jsonToUser(course));
      });
    }

    return loadedCourse;
  }
}

/*  Future<bool> login(String phone) async {
    try {
      final url = '${webApi['domain']}${api['login']}';

      final response = await RemoteServices.httpRequest(
        method: 'POST',
        body: {'mobileNumber': phone},
        url: url,
      );

      print(response['success']);
      if (response['success']) {
        User user = User.jsonToUser(response['result']);
        _user = user;

        await storage.ready;
        storage.setItem(
            'accessToken',
            json.encode({
              'token': response['token'],
              'phone': phone,
            }));

        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }*/
