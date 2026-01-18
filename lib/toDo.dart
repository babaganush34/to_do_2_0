class ToDo {
  final int id;
  final String title;
  final bool isFinished;
  final String date;

  const ToDo({
    required this.id,
    required this.title,
    required this.date,
    required this.isFinished,
  });

  ToDo copyWith({
    int? id,
    String? title,
    bool? isFinished,
    String? date,
  }) {
    return ToDo(
      id: id ?? this.id,
      title: title ?? this.title,
      isFinished: isFinished ?? this.isFinished,
      date: date ?? this.date,
    );
  }
}
