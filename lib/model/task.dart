class Task {
  final int id;
  final int userId;
  final String title;
  final bool completed;

  Task({this.id, this.userId, this.title, this.completed});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json['id'],
        userId: json['userId'],
        title: json['title'],
        completed: json['completed']);
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'id': id,
    'title': title,
    'completed': completed,
  };

}
