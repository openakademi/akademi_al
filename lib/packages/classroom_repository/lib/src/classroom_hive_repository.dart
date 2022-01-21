

import 'package:akademi_al_mobile_app/packages/models/user/classroom_entity.dart';
import 'package:hive/hive.dart';

const box_name = "classroom";

class ClassroomHiveRepository {
  Box<ClassroomEntity> _box;

  Future<void> saveAll(List<ClassroomEntity> enrollments) async {
    await _openBox();
    await Future.wait(enrollments.map((element) async {
      if(element.isDeleted != null && element.isDeleted) {
        await _box.delete(element.id);
      }
    }));

    final enrollmentsToUpdate = enrollments.where((element) => element.isDeleted == null || element.isDeleted).toList();
    await _box.putAll(Map.fromIterable(enrollmentsToUpdate,
        key: (entry) => entry.id, value: (entry) => entry));
    await _closeBox();
  }

  Future<List<ClassroomEntity>> getAll() async {
    await _openBox();
    return _box.values
        .toList()
        .where((element) => element.isDeleted == null || !element.isDeleted)
        .toList();
  }

  Future<void> deleteAll() async {
    await _openBox();
    await _box.clear();
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