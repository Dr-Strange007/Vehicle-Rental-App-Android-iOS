import '../../utils/basic_screen_imports.dart';

class DatePickerController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var selectedTime = DateTime.now().obs;

  Future selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
    }
  }

  Future selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedTime.value),
    );

    if (pickedTime != null) {
      DateTime newDateTime = DateTime(
        selectedTime.value.year,
        selectedTime.value.month,
        selectedTime.value.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      selectedTime.value = newDateTime;
    }
  }
}
