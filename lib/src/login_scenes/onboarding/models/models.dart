
import 'package:akademi_al_mobile_app/components/models/non_empty_field.dart';

class Nationality extends NonEmptyField {
  const Nationality.dirty(String nationality) : super.dirty(nationality);

  const Nationality.pure() : super.pure();
}

class ProfilePicture extends NonEmptyField {
  const ProfilePicture.dirty(String profilePicture) : super.dirty(profilePicture);

  const ProfilePicture.pure() : super.pure();
}

class EducationLevel extends NonEmptyField {
  const EducationLevel.dirty(String educationLevel) : super.dirty(educationLevel);

  const EducationLevel.pure() : super.pure();
}

class GradeLevel extends NonEmptyField {
  const GradeLevel.dirty(String gradeLevel) : super.dirty(gradeLevel);

  const GradeLevel.pure() : super.pure();
}

class GradeClassId extends NonEmptyField {
  const GradeClassId.dirty(String gradeClass) : super.dirty(gradeClass);

  const GradeClassId.pure() : super.pure();
}
