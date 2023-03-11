import 'package:equatable/equatable.dart';

class Task extends Equatable {
  String id;
  String creator;
  String name;
  String? description;
  List<String>? assignedUsers;
  DateTime? endDate;
  String? parentTaskId;

  Task({
    required this.id,
    required this.creator,
    required this.name,
    this.description,
    this.assignedUsers,
    this.endDate,
    this.parentTaskId,
  }) {
    assignedUsers = assignedUsers ?? [];
    parentTaskId = parentTaskId ?? '';
  }

  @override
  List<Object?> get props => [
        id,
        creator,
        name,
        description,
        assignedUsers,
        endDate,
        parentTaskId,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'creator': creator,
      'name': name,
      'description': description,
      'assignedUsers': assignedUsers,
      'endDate': endDate,
      'parentTaskId': parentTaskId,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    DateTime? endDate;
    if (map['endDate'] != null) {
      endDate = DateTime.parse(map['endDate']);
    }
    return Task(
      id: map['_id'] as String,
      creator: map['creator'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      assignedUsers: map['assignedUsers'].cast<String>(),
      endDate: endDate,
      parentTaskId:
          map['parentTaskId'] != null ? map['parentTaskId'] as String : '',
    );
  }

  Task copyWith({
    String? id,
    String? creator,
    String? name,
    String? description,
    List<String>? assignedUsers,
    DateTime? endDate,
    String? parentTaskId,
  }) {
    return Task(
      id: id ?? this.id,
      creator: creator ?? this.creator,
      name: name ?? this.name,
      description: description ?? this.description,
      assignedUsers: assignedUsers ?? this.assignedUsers,
      endDate: endDate ?? this.endDate,
      parentTaskId: parentTaskId ?? this.parentTaskId,
    );
  }
}
