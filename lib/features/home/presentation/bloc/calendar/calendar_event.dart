abstract class SelectedDateEvent {}

class SelectDateEvent extends SelectedDateEvent {
  final DateTime date;

  SelectDateEvent(this.date);
}
