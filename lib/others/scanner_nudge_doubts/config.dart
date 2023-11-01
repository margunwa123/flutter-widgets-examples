import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Config {
  final String text;
  final String subtitle;
  final String title;
  final int limit;

  Config({
    required this.text,
    required this.subtitle,
    required this.title,
    required this.limit,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'subtitle': subtitle,
      'title': title,
      'limit': limit,
    };
  }

  factory Config.fromMap(Map<String, dynamic> map) {
    return Config(
      text: map['text'] as String,
      subtitle: map['subtitle'] as String,
      title: map['title'] as String,
      limit: map['limit'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Config.fromJson(String source) =>
      Config.fromMap(json.decode(source) as Map<String, dynamic>);
}
