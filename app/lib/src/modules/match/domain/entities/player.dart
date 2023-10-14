// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes
import 'package:app/src/modules/match/domain/entities/role.dart';

class Player {
  final String id;
  final String name;
  final Role role;
  final bool isReady;

  Player({
    required this.id,
    required this.name,
    this.role = Role.random,
    this.isReady = false,
  });

  Player copyWith({
    String? id,
    String? name,
    Role? role,
    bool? isReady,
  }) {
    return Player(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      isReady: isReady ?? this.isReady,
    );
  }

  @override
  bool operator ==(covariant Player other) {
    if (identical(this, other)) return true;
    return other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
