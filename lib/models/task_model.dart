import 'dart:convert';

import '../api/api_task.dart';
import '../helpers/utils.dart' as utils;

List<Task> TaskListFromJson(String str) => List<Task>.from(json.decode(str).map((x) => Task.fromJson(x)));

String TaskListToJson(List<Task> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Task {
  int? id;
  String title;
  int isCompleted = 0;
  DateTime? dueDate;
  String? comments;
  String? description;
  String? tags;
  DateTime? createdAt;
  DateTime? updatedAt;

  Task({
    this.id,
    this.title = '',
    this.isCompleted = 0,
    this.dueDate,
    this.comments,
    this.description,
    this.tags,
    this.createdAt,
    this.updatedAt,
  });

  String get formatDate => utils.formatDate(this.dueDate);

  bool get isNew => id == null;

  bool get isEditable => isCompleted == 0;

  bool get completada => isCompleted == 1;

  void setCompleted() {
    isCompleted = 1;
  }

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        title: json["title"],
        isCompleted: json["is_completed"],
        dueDate: json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
        comments: json["comments"],
        description: json["description"],
        tags: json["tags"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "is_completed": isCompleted,
        "due_date":
            "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}",
        "comments": comments,
        "description": description,
        "tags": tags,
        "token": token,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
