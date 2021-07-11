class Task {
  // ---------------------------- CONSTRUCTORS ----------------------------
  const Task({
    this.id,
    required this.title,
    required this.description,
  });

  Task.fromMap(Map<String, dynamic> map)
      : this(
          id: map['id'],
          title: map['title'],
          description: map['description'],
        );

  // ------------------------------- FIELDS -------------------------------
  final int? id;
  final String title;
  final String description;

  // ------------------------------- METHODS ------------------------------
  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
      };
}
