// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GlobalVar {
  final int? id;
  final String? key;
  final String? value;
  final String? note;
  GlobalVar({
    this.id,
    this.key,
    this.value,
    this.note,
  });

  GlobalVar copyWith({
    int? id,
    String? key,
    String? value,
    String? note,
  }) {
    return GlobalVar(
      id: id ?? this.id,
      key: key ?? this.key,
      value: value ?? this.value,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'key': key,
      'value': value,
      'note': note,
    };
  }

  factory GlobalVar.fromMap(Map<String, dynamic> map) {
    return GlobalVar(
      id: map['id'] != null ? map['id'] as int : null,
      key: map['key'] != null ? map['key'] as String : null,
      value: map['value'] != null ? map['value'] as String : null,
      note: map['note'] != null ? map['note'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GlobalVar.fromJson(String source) =>
      GlobalVar.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GlobalVar(id: $id, key: $key, value: $value, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GlobalVar &&
        other.id == id &&
        other.key == key &&
        other.value == value &&
        other.note == note;
  }

  @override
  int get hashCode {
    return id.hashCode ^ key.hashCode ^ value.hashCode ^ note.hashCode;
  }
}
