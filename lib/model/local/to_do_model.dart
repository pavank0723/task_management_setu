class ToDoModel {
  int? id;
  String? name;
  String? description;
  String? dueDate;
  bool? isCompleted;
  bool? isActive;
  String? addedOn;
  String? updatedOn;

  ToDoModel({
    this.id,
    this.name,
    this.description,
    this.dueDate,
    this.isCompleted = false,
    this.isActive = true,
    this.addedOn,
    this.updatedOn,
  });

  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'Name': name,
      'Description': description,
      'DueDate': dueDate,
      'IsActive': isActive,
      'IsCompleted': isCompleted,
      'AddedOn': addedOn,
      'UpdatedOn': updatedOn,
    };
  }

  factory ToDoModel.fromMap(Map<String, dynamic> map) {
    return ToDoModel(
      id: map['ID'],
      name: map['Name'],
      description: map['Description'],
      dueDate: map['DueDate'],
      isActive: map['IsActive'] == 1,
      isCompleted: map['IsCompleted'] == 1,
      addedOn: map['AddedOn'],
      updatedOn: map['UpdatedOn'],
    );
  }
}
