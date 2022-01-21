
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:hive/hive.dart';

const box_name = "lessons";

class LessonHiveRepository {
  Box<Lessons> _box;

  Future<void> saveLocalLesson(Lessons lesson) async {
    await _openBox();
    await _box.put(lesson.id, lesson);
    await _closeBox();
  }

  Future<Lessons> getLocallySavedLessonById(String id) async {
    await _openBox();
    final lesson = _box.get(id);
    await _closeBox();
    return lesson;
  }

  Future<List<Lessons>> getAllLocallySavedLessons(String userId) async {
    await _openBox();
    final lessons = _box.values
        .toList()
        .where((element) => element.userId == userId || element.userId == null)
        .toList();
    await _closeBox();
    return lessons;
  }


  Future<void> deleteSavedLessonById(String id) async {
    await _openBox();
    await _box.delete(id);
    await _closeBox();
  }

  Future<void> _openBox() async {
    if (!Hive.isBoxOpen(box_name)) {
      _box = await Hive.openBox(box_name);
    }
  }

  Future<void> _closeBox() async {
    if (Hive.isBoxOpen(box_name)) {
      await _box.close();
    }
  }

  void dispose() async {
    if (_box != null && _box.isOpen) {
      await _box.close();
    }
  }
}