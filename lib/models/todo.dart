class ToDo {
  // ---------------------------- CONSTRUCTORS ----------------------------
  const ToDo({
    this.id,
    required this.taskId,
    required this.title,
    required this.isDone,
  });

  ToDo.fromMap(Map<String, dynamic> map)
      : this(
          id: map['id'],
          taskId: map['taskId'],
          title: map['title'],
          isDone: map['isDone'],
        );

  // ------------------------------- FIELDS -------------------------------
  final int? id;
  final int taskId;
  final String title;
  final bool isDone;

  // ------------------------------- METHODS ------------------------------
  Map<String, dynamic> toMap() => {
        'id': id,
        'taskId': taskId,
        'title': title,
        'isDone': isDone ? 1 : 0,
      };
}
