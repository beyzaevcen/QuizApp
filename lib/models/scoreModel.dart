import 'dart:convert';

class ScoreModel {
  final String name;
  final DateTime date;
  final int score;
  ScoreModel({
    required this.name,
    required this.date,
    required this.score,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'date': date.millisecondsSinceEpoch});
    result.addAll({'score': score});

    return result;
  }

  factory ScoreModel.fromMap(Map<String, dynamic> map) {
    return ScoreModel(
      name: map['name'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      score: map['score']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ScoreModel.fromJson(String source) => ScoreModel.fromMap(json.decode(source));
}
