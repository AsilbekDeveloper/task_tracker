abstract class SelectedDateState {}

class SelectedDateInitial extends SelectedDateState {
  final DateTime selectedDate;

  SelectedDateInitial(this.selectedDate);
}
