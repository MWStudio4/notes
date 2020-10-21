import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'note.dart';

class Notebook with ChangeNotifier {
  final Box _noteBox = Hive.box('noteBox');

  List<Note> notes = [];

  Notebook() {
    rehydrateNotes();
  }

  Future<void> addNote(String text) async {
    final _id = (DateTime.now().millisecondsSinceEpoch / 1000).ceil();
    final _note = Note(_id, text);
    await _noteBox.put(_id, _note);
    notes.add(_note);
    notifyListeners();
  }

  Future<void> deleteNote(int id) async {
    await _noteBox.delete(id);
    notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }

  Future<Note> getNoteById(int id) async {
    return await _noteBox.get(id) as Note;
  }

  Future<void> rehydrateNotes() async {
    notes = _noteBox.values?.toList()?.cast<Note>() ?? [];
  }
}
