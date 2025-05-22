import 'package:flutter/material.dart';
import 'package:task_tracker_app/components/button_widget.dart';
import 'package:task_tracker_app/core/app_text_styles.dart';

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
    // Avval sanani tanlash
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) return; // agar bekor qilinsa, qaytadi

    // Sanani tanlagandan so'ng, vaqtni tanlash
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
    );

    if (pickedTime == null) return; // agar vaqt tanlanmasa, qaytadi

    // Yangi tanlangan sana va vaqtni birlashtiramiz
    final pickedDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    setState(() {
      _selectedDateTime = pickedDateTime;
    });

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
    return ButtonWidget(
      onPressed: _pickDateTime,
      child: Text(
        _formattedDateTime,
        style: AppTextStyles.normal12,
      ),
    );
  }
}
