class ToDoElement {
  ToDoElement({required this.done, required this.content, required this.due});
  bool done; //Is the task done??
  String content; //Content or title for the task
  DateTime due; //Is this task due to a certain date & time?

  factory ToDoElement.fromJson(Map<String, dynamic> json) =>
      _$ToDoElementFromJson(json);

  Map<String, dynamic> toJson() => _$ToDoElementToJson(this);
}

// Parsing Json in the background
ToDoElement _$ToDoElementFromJson(Map<String, dynamic> json) {
  return ToDoElement(
      done: json['done'], content: json['content'], due: json['due'].toDate());
}

Map<String, dynamic> _$ToDoElementToJson(ToDoElement toDoElement) =>
    <String, dynamic>{
      'done': toDoElement.done,
      'content': toDoElement.content,
      'due': toDoElement.due
    };
