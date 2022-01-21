import 'package:akademi_al_mobile_app/packages/models/enrollment/enrollment_entity.dart';
import 'package:hive/hive.dart';

const box_name = "enrollment";

class EnrollmentHiveRepository {
  Box<EnrollmentEntity> _box;

  Future<void> saveAll(List<EnrollmentEntity> enrollments) async {
    await _openBox();
    await Future.wait(enrollments.map((element) async {
      if(element.isDeleted != null && element.isDeleted) {
       await _box.delete(element.id);
      }
    }));

    final enrollmentsToUpdate = enrollments.where((element) => element.isDeleted == null || element.isDeleted).toList();
    // print("asdf ${enrollmentsToUpdate[0].classroom.userCreatedBy}");
    await _box.putAll(Map.fromIterable(enrollmentsToUpdate,
        key: (entry) => entry.id, value: (entry) => entry));
    await _closeBox();
  }

  Future<List<EnrollmentEntity>> getAll() async {
    await _openBox();
    // print("box values ${_box.values.where((element) => element.isDeleted == null || !element.isDeleted).toList()toList[0].classroom.userCreatedBy}");
    return _box.values
        .toList()
        .where((element) => element.isDeleted == null || !element.isDeleted)
        .toList();
  }

  Future<EnrollmentEntity> findById(String enrollmentId) async {
    await _openBox();
    final enrollment = await _box.get(enrollmentId);
    return enrollment;
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
