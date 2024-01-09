import 'package:flutter/material.dart';

class CustomDatePicker extends StatefulWidget {
    const CustomDatePicker({super.key, required this.updateRange,});
    final Function(DateTime) updateRange;

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime _chosenDay;

  @override
  void initState() {
    super.initState();
    // Initialize with the current date
    _chosenDay = DateTime.now().toLocal();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 72,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 8,
              offset: Offset(0, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => _selectDate(context),
              icon: const Icon(Icons.calendar_today_outlined),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _chosenDay,
      firstDate: DateTime.now().toLocal().subtract(const Duration(days: 60)),
      lastDate: DateTime.now().toLocal(),
    );

    if (pickedDate != null && pickedDate != _chosenDay) {
      setState(() {
        _chosenDay = pickedDate;
        // Perform any additional logic here based on the selected date
      });
      widget.updateRange(pickedDate);
    }
  }

}
