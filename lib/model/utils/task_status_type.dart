enum TaskStatusType {
  incomplete(1, "Incomplete"),
  completed(2, "Completed"),
  deleted(3, "Deleted");

  const TaskStatusType(this.id, this.title);

  final int id;
  final String title;

  static Map<String, int> _taskStatusTypeMap = {
    incomplete.title: incomplete.id,
    completed.title: completed.id,
    deleted.title: deleted.id,
  };

  static int getTaskStatusTypeId(String typeName) =>
      _taskStatusTypeMap[typeName] ?? 0;

  static List<String> getTaskStatusTypes() {
    List<String> statuses = [];
    for (var value in TaskStatusType.values) {
      statuses.add(value.title);
    }
    return statuses;
  }

  static String getTaskStatusTypeById(int typeID) {
    var status = "";
    for (var value in TaskStatusType.values) {
      if (typeID == value.id) {
        status = value.title;
        break;
      }
    }
    return status;
  }
}
