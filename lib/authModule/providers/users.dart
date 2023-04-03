import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mmt_courses/http_helper.dart';

import '../../api.dart';
import '../models/user.dart';

class Users with ChangeNotifier {
  LocalStorage storage = LocalStorage("TusharGhone");
  late User _user;

  void addUser(User user) {
    _user = user;

    notifyListeners();
  }

  logout() async {
    await storage.ready;
    storage.clear();
  }

  User fetchUser() {
    return _user;
  }

  Future<bool> login(String phone) async {
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
  }

  Future<bool> registerUser(Map body) async {
    try {
      final url = '${webApi['domain']}${api['registerUser']}';

      final response = await RemoteServices.httpRequest(
        method: 'POST',
        body: body,
        url: url,
      );
      if (response['success']) {
        User userData = User.jsonToUser(response['result']);
        _user = userData;

        await storage.ready;
        storage.setItem(
            'accessToken',
            json.encode({
              'token': response['token'],
              'phone': body['mobileNumber'],
            }));
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> setIsEnrolled(String courseId, bool isEnrolled) async {
    try {
      final url = '${webApi['domain']}${api['isEnrolled']}';
      final response = await RemoteServices.httpRequest(
        method: 'POST',
        body: {
          "courseId": courseId,
          "userId": _user.id,
          "add": isEnrolled,
        },
        url: url,
      );

      if (response['success'] && response['result'] != null) {
        if (isEnrolled) {
          _user.enrolledCourseIds.add(courseId);
        }
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      return false;
    }
  }

  Future<void> toggleAllSelectedWishItems(List<String> selectedCourseId) async {
    try {
      final url = '${webApi['domain']}${api['isWishlist']}';

      for (int i = 0; i < selectedCourseId.length; i++) {
        _user.wishlistCourseIds.remove(selectedCourseId[i]);
        final response = await RemoteServices.httpRequest(
          method: 'POST',
          body: {
            "courseId": selectedCourseId[i],
            "userId": _user.id,
            "add": false,
          },
          url: url,
        );
      }

      notifyListeners();
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

  Future<bool> isWishlist(String courseId) async {
    try {
      final url = '${webApi['domain']}${api['isWishlist']}';

      final response = await RemoteServices.httpRequest(
        method: 'POST',
        body: {
          "courseId": courseId,
          "userId": _user.id,
          "add": !_user.wishlistCourseIds.contains(courseId),
        },
        url: url,
      );

      if (response['success'] && response['result'] != null) {
        if (_user.wishlistCourseIds.contains(courseId)) {
          _user.wishlistCourseIds.remove(courseId);
        } else {
          _user.wishlistCourseIds.add(courseId);
        }

        notifyListeners();

        return true;
      } else {
        notifyListeners();
        return false;
      }
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateUser(Map body) async {
    try {
      final url = '${webApi['domain']}${api['updateUser']}';

      final response = await RemoteServices.httpRequest(
        method: 'POST',
        body: body,
        url: url,
      );
      if (response['success']) {
        User userData = User.jsonToUser(response['result']);
        _user = userData;

        notifyListeners();
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future updateQuiz(Map body) async {
    try {} catch (e) {
      print(e);
    }
  }
}
