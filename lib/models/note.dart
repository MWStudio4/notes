import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @override
  @HiveField(0)
  final int id;

  @override
  @HiveField(1)
  final String text;

  Note(this.id, this.text);

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Note && other.id == id;

  @override
  String toString() {
    return 'Note id:$id - $text';
  }
}
