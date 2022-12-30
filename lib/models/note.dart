import 'dart:convert';

import 'package:flutter/cupertino.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Note extends ChangeNotifier {
  String title;
  String content;
  final int id;
  String color;

  Note({
    required this.title,
    required this.content,
    required this.id,
    required this.color,
  });

  Note copyWith({
    String? title,
    String? content,
    int? id,
    String? color,
  }) {
    return Note(
      title: title ?? this.title,
      content: content ?? this.content,
      id: id ?? this.id,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'content': content,
      'id': id,
      'color': color,
    };
  }

  Note updateWith({
    String? title,
    String? content,
    String? color,
  }) {
    if (title != null) this.title = title;
    if (content != null) this.content = content;
    if (color != null) this.color = color;
    // if (state != null) this.state = state;
    // if (updateTimestamp) modifiedAt = DateTime.now();
    notifyListeners();
    return this;
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      title: map['title'] as String,
      content: map['content'] as String,
      id: map['id'] as int,
      color: map['color'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) =>
      Note.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Note(title: $title, content: $content, id: $id, color: $color)';
  }

  @override
  bool operator ==(covariant Note other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.content == content &&
        other.id == id &&
        other.color == color;
  }

  @override
  int get hashCode {
    return title.hashCode ^ content.hashCode ^ id.hashCode ^ color.hashCode;
  }
}
