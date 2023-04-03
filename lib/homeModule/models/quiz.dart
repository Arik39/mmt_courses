class Quiz {
  final String? id;
  final String title;
  final String timer;
  final int noOfQuestions;
  final List questions;
  List<List<bool>> isSelected = [
    [false, false, false, false],
    [false, false, false, false],
    [false, false, false, false],
    [false, false, false, false],
    [false, false, false, false],
    [false, false, false, false],
    [false, false, false, false],
    [false, false, false, false],
    [false, false, false, false],
    [false, false, false, false],
  ];

  Quiz(
      {this.id,
      required this.title,
      required this.timer,
      required this.noOfQuestions,
      required this.questions,
      required this.isSelected});

  static Quiz jsonToUser(Map quiz) {
    return Quiz(
      id: quiz['_id'],
      timer: quiz['timer'],
      noOfQuestions: quiz['noOfQuestions'],
      questions: quiz['questions'],
      title: quiz['title'],
      isSelected: [],
    );
  }
}
