part of 'list_university_bloc.dart';

enum UniversityStatus { initial, success, failure }

class ListUniversityState extends Equatable {

  final UniversityStatus status;
  final FormzStatus statusForm;
  final List<University> universities;
  final bool requestStatus;
  final String image;
  final NumberOfStudents numberOfStudents;

  const ListUniversityState({
    this.status = UniversityStatus.initial,
    this.statusForm = FormzStatus.pure,
    this.universities = const <University>[],
    this.requestStatus = false,
    this.image = '',
    this.numberOfStudents = const NumberOfStudents.pure(),
  });

  ListUniversityState copyWith({
    UniversityStatus? status,
    FormzStatus? statusForm,
    List<University>? universities,
    bool? requestStatus,
    String? image,
    NumberOfStudents? numberOfStudents,
  }) => ListUniversityState(
    status: status ?? this.status,
    statusForm: statusForm ?? this.statusForm,
    universities: universities ?? this.universities,
    requestStatus: requestStatus ?? this.requestStatus,
    image : image ?? this.image,
    numberOfStudents : numberOfStudents ?? this.numberOfStudents,
  );

  @override
  List<Object> get props => [
    status,
    statusForm,
    universities,
    requestStatus,
    image,
    numberOfStudents,
  ];
}