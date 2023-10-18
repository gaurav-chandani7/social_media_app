import 'dart:convert';

class UserActionModel {
  final String selfId;
  final String targetUserId;
  UserActionModel({
    required this.selfId,
    required this.targetUserId,
  });

  Map<String, dynamic> toMap() {
    return {
      'selfId': selfId,
      'targetUserId': targetUserId,
    };
  }

  factory UserActionModel.fromMap(Map<String, dynamic> map) {
    return UserActionModel(
      selfId: map['selfId'] ?? '',
      targetUserId: map['targetUserId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserActionModel.fromJson(String source) =>
      UserActionModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserActionModel(selfId: $selfId, targetUserId: $targetUserId)';
}
