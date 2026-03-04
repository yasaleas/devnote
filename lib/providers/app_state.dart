import 'package:flutter/material.dart';
import '../models/project.dart';
import '../models/note.dart';
import '../services/database_service.dart';

class AppState extends ChangeNotifier {
  final DatabaseService _db = DatabaseService();

  List<Project> _projects = [];
  List<Note> _notes = [];
  bool _isLoaded = false;

  List<Project> get projects => List.unmodifiable(_projects);
  List<Note> get notes => List.unmodifiable(_notes);
  bool get isLoaded => _isLoaded;

  AppState() {
    _loadData();
  }

  Future<void> _loadData() async {
    _projects = await _db.getProjects();
    _notes = await _db.getNotes();
    _isLoaded = true;
    notifyListeners();
  }

  void addProject(Project project) {
    _projects.insert(0, project);
    notifyListeners();
    _db.insertProject(project);
  }

  void addNote(Note note) {
    _notes.insert(0, note);
    notifyListeners();
    _db.insertNote(note);
  }

  void deleteNote(String id) {
    _notes.removeWhere((n) => n.id == id);
    notifyListeners();
    _db.deleteNote(id);
  }

  void deleteProject(String id) {
    _projects.removeWhere((p) => p.id == id);
    _notes.removeWhere((n) => n.projectId == id);
    notifyListeners();
    _db.deleteProject(id);
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
