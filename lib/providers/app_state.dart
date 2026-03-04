import 'package:flutter/material.dart';
import '../models/project.dart';
import '../models/note.dart';

class AppState extends ChangeNotifier {
  final List<Project> _projects = [];
  final List<Note> _notes = [];

  List<Project> get projects => List.unmodifiable(_projects);
  List<Note> get notes => List.unmodifiable(_notes);

  void addProject(Project project) {
    _projects.add(project);
    notifyListeners();
  }

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  List<Note> getNotesForProject(String projectId) {
    return _notes.where((n) => n.projectId == projectId).toList();
  }

  Project? getProjectById(String projectId) {
    try {
      return _projects.firstWhere((p) => p.id == projectId);
    } catch (_) {
      return null;
    }
  }
}
