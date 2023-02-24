import 'package:flutter/foundation.dart';

class Images with ChangeNotifier {
  List<String> _images = [
    "assets/images/intro_01.png",
    "assets/images/intro_02.png",
    "assets/images/intro_03.png"
  ];

  List<String> get images {
    return [..._images];
  }
}
