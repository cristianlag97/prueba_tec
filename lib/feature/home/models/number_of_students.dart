import 'package:formz/formz.dart';

enum NumberOfStudentsValidationError { empty }

class NumberOfStudents extends FormzInput<String, NumberOfStudentsValidationError> {
  const NumberOfStudents.pure() : super.pure('');
  const NumberOfStudents.dirty([value = '0']) : super.pure(value);

  @override
  NumberOfStudentsValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : NumberOfStudentsValidationError.empty;
  }
}