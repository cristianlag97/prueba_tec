part of 'list_university_bloc.dart';

abstract class ListUniversityEvent extends Equatable {
  const ListUniversityEvent();

  @override
  List<Object> get props => [];
}

class UniversityFetch extends ListUniversityEvent {}

class AddNumberOfStudents extends ListUniversityEvent {
  final String numberOfStudents;
  const AddNumberOfStudents(this.numberOfStudents);

  @override
  List<Object> get props => [numberOfStudents];
}

class AddImage extends ListUniversityEvent {
  final String image;
  const AddImage(this.image);

  @override
  List<Object> get props => [image];
}

class Submitted extends ListUniversityEvent {
  const Submitted();
}