import 'package:flutter/material.dart';
import '../models/quiz.dart';

import '../../api.dart';
import '../../http_helper.dart';

class Quizzes with ChangeNotifier {
  List<Quiz> _quiz = [];

  List<Quiz> fecthAllQuiz() {
    return _quiz;
  }

  Quiz fetchQuizById(String id) {
    return _quiz.firstWhere((quiz) => quiz.id == id);
  }

  Future getAllQuiz() async {
    final url = '${webApi['domain']}${api['quiz']}';

    final response = await RemoteServices.httpRequest(
      method: 'GET',
      url: url,
    );

    if (response['success'] && response['result'] != null) {
      List<Quiz> loadedCourse = [];

      response['result'].forEach((quiz) {
        loadedCourse.add(Quiz.jsonToUser(quiz));
      });

      _quiz = List.from(loadedCourse);
    }
  }
}
