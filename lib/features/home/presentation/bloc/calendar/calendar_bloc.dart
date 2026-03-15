import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/calendar/calendar_event.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/calendar/calendar_state.dart';

class SelectedDateBloc extends Bloc<SelectedDateEvent, SelectedDateState> {
  SelectedDateBloc() : super(SelectedDateInitial(DateTime.now())) {
    on<SelectDateEvent>((event, emit) {
      emit(SelectedDateInitial(event.date));
    });
  }
}
