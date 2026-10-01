import 'package:flutter/material.dart';
import 'package:simple_planner_app/models/plan.dart';
import 'package:simple_planner_app/widgets/primary_button.dart';

class CreatePlanScreen extends StatefulWidget {
  const CreatePlanScreen({super.key});

  @override
  State<CreatePlanScreen> createState() => _CreatePlanScreenState();
}

class _CreatePlanScreenState extends State<CreatePlanScreen> {

  final _titleController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();

    final picker = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 2), 
      helpText: "Select Plan Date",
    );

    if (picker == null){
      return;
    }

    setState(() {
      _selectedDate = DateTime(picker.year, picker.month, picker.day);
    });
  }

  Future<void> _pickTime() async {
    final picker = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      helpText: "Select Plan Time",
    );

    if(picker == null){
      return;
    }

    setState(() {
      _selectedTime = picker;
    });
  }

  String _dateLabel() {
    if (_selectedDate == null) {
      return "Choose Date";
    }

    final d = _selectedDate!;
    final year = d.year.toString();
    final month = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');

    return "$year-$month-$day";
  }

  String _timeLabel() {
    if(_selectedTime == null){
      return "Choose Time";
    }

    final hour = _selectedTime!.hour.toString().padLeft(2, '0');
    final minute = _selectedTime!.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  void _save() {
    final title = _titleController.text.trim();
    if(title.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a title"))
      );
      return;
    }

    if(_selectedDate == null){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a date"))
      );
      return;
    }

    if(_selectedTime == null){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a time"))
      );
      return;
    }

    final plan = Plan(
      title: title,
      date: _selectedDate!,
      time: _selectedTime!,
    );

    Navigator.pop(context, plan);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Plan"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Plan Title",
                hintText: "E.g. Study Flutter",
              ),
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _pickDate,
                    child: Text(_dateLabel()),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _pickTime,
                    child: Text(_timeLabel()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            PrimaryButton(
              onPressed: _save,
              text: "Save",
            ),
          ],
        ),
      ),
    );
  }

}