import 'package:flutter/material.dart';
import 'package:task_tracker_app/core/app_text_styles.dart';
import 'package:task_tracker_app/core/components/button_widget.dart';

class TaskTimeWidget extends StatefulWidget {
  final DateTime? initialDateTime;
  final ValueChanged<DateTime> onDateTimeSelected;

  const TaskTimeWidget({
    super.key,
    this.initialDateTime,
    required this.onDateTimeSelected,
  });

  @override
  _TaskTimeWidgetState createState() => _TaskTimeWidgetState();
}

class _TaskTimeWidgetState extends State<TaskTimeWidget> {
  late DateTime _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.initialDateTime ?? DateTime.now();
  }

  Future<void> _pickDateTime() async {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: theme.copyWith(
            colorScheme: colorScheme.copyWith(
              primary: colorScheme.primary, // topbar button color
              onPrimary: colorScheme.onPrimary, // button text color
              surface: colorScheme.surface, // dialog background
              onSurface: colorScheme.onSurface, // text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: colorScheme.primary),
            ),
            dialogTheme: DialogThemeData(backgroundColor: colorScheme.surface),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate == null) return;

    // Time Picker
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
      builder: (context, child) {
        return Theme(
          data: theme.copyWith(
            colorScheme: colorScheme.copyWith(
              primary: colorScheme.primary,
              onPrimary: colorScheme.onPrimary,
              surface: colorScheme.surface,
              onSurface: colorScheme.onSurface,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: colorScheme.primary),
            ),
            dialogTheme: DialogThemeData(backgroundColor: colorScheme.surface),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime == null) return;

    final pickedDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    setState(() => _selectedDateTime = pickedDateTime);
    widget.onDateTimeSelected(pickedDateTime);
  }

  String get _formattedDateTime {
    final d = _selectedDateTime;
    final day = d.day.toString().padLeft(2, '0');
    final month = d.month.toString().padLeft(2, '0');
    final year = d.year.toString();
    final hour = d.hour.toString().padLeft(2, '0');
    final minute = d.minute.toString().padLeft(2, '0');

    return "$day.$month.$year at $hour:$minute";
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ButtonWidget(
      onPressed: _pickDateTime,
      child: Text(
        _formattedDateTime,
        style: AppTextStyles.labelSmall.copyWith(color: colorScheme.onSurface),
      ),
    );
  }
}
