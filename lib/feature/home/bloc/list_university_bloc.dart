import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_tyba/core/core.dart';
import 'package:formz/formz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tyba/feature/home/models/university_model.dart';
import 'package:stream_transform/stream_transform.dart';

import '../models/number_of_students.dart';

part 'list_university_event.dart';
part 'list_university_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ListUniversityBloc extends Bloc<ListUniversityEvent, ListUniversityState> {

  ListUniversityBloc() : super(const ListUniversityState()) {
    on<UniversityFetch>(
      _onUniversityFetch,
      transformer: throttleDroppable(throttleDuration)
    );
    on<AddNumberOfStudents>(_onAddNumberOfStudents);
    on<AddImage>(_onAddImage);
    on<Submitted>(_onSubmitted);
  }


  Future<void> _onUniversityFetch(UniversityFetch event, Emitter<ListUniversityState>emit) async {
    if(state.requestStatus)return;
    try{
      if(state.status == UniversityStatus.initial) {
        final universities = await ApiServiceUniversity.fetchUniversity();
        universities.isEmpty
        ? emit(state.copyWith(requestStatus: true))
        : emit(
          state.copyWith(
            status: UniversityStatus.success,
            universities: List.of(state.universities)..addAll(universities),
            requestStatus: false
          )
        );
      }
    } catch (e) {
      print('Error => $e');
      emit(state.copyWith(status: UniversityStatus.failure));
    }
  }

  void _onAddNumberOfStudents(AddNumberOfStudents event, Emitter<ListUniversityState> emit) {
    final numberOfStudents = NumberOfStudents.dirty(event.numberOfStudents);
    // print(event.numberOfStudents);
    // print(state.numberOfStudents);
    // print(numberOfStudents);
    emit(
      state.copyWith(
        numberOfStudents: numberOfStudents,
        statusForm: Formz.validate([numberOfStudents])
      )
    );
    print(state.statusForm);
  }

  void _onAddImage(AddImage event, Emitter<ListUniversityState>emit) {
    print(event.image);
  }

  Future<void>_onSubmitted(Submitted event, Emitter<ListUniversityState>emit) async {
    print(state.statusForm.isInvalid);
    if(state.statusForm.isInvalid) {
      emit(state.copyWith(statusForm: FormzStatus.submissionInProgress));
      try {
        emit(state.copyWith(statusForm: FormzStatus.submissionSuccess));
      } catch (e) {
        emit(state.copyWith(statusForm: FormzStatus.submissionFailure));
      }
    }
  }

}
