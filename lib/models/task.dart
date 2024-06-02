class Task {
  final String id;
  final String title;
  final bool isDone;
  final DateTime dueDate;

  Task({
    required this.id,
    required this.title,
    required this.isDone,
    required this.dueDate,
  });

  Task copyWith({
    String? id,
    String? title,
    bool? isDone,
    DateTime? dueDate,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      dueDate: dueDate ?? this.dueDate,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone,
      'dueDate': dueDate.toIso8601String(),
    };
  }

  factory Task.fromFirestore(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      isDone: json['isDone'],
      dueDate: DateTime.parse(json['dueDate']),
    );
  }
}
