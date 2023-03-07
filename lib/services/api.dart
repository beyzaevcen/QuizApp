import 'package:dio/dio.dart';
import 'package:quiz_app/models/category.dart';
import 'package:quiz_app/models/questions.dart';

class Api {
  static Future<List<Category>?> getCategories() async {
    try {
      var response = await Dio(BaseOptions(responseType: ResponseType.json))
          .get('https://opentdb.com/api_category.php');
      final categories = (response.data["trivia_categories"] as List<dynamic>)
          .map((e) => Category.fromMap(e))
          .toList();
      return categories;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<List<Questions>?> getQuestions(int category, int count) async {
    try {
      var response = await Dio(BaseOptions(responseType: ResponseType.json))
          .get('https://opentdb.com/api.php?amount=$count&category=$category&type=multiple');
      final questions =
          (response.data["results"] as List<dynamic>).map((e) => Questions.fromMap(e)).toList();

      return questions;
    } catch (e) {
      return null;
    }
  }
}
