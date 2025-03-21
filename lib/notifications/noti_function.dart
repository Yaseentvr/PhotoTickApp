// import 'dart:developer';

// import 'package:hive/hive.dart';
// import 'package:phototickapp/notifications/noti_model.dart';

// class ReminderFunction {
//   static const String _boxName = 'reminders';
//   static Box<Reminder> get _box => Hive.box<Reminder>(_boxName);

//   static Future<void> addReminder(Reminder reminder) async {
//     try {
//       await _box.add(reminder);
//     } catch (e) {
//       log('Error saving reminder: $e');
//     }
//   }

//   static List<Reminder> getReminders() {
//     return _box.values.toList();
//   }

//   static Future<void> deleteReminder(int index) async {
//     try {
//       await _box.deleteAt(index);
//     } catch (e) {
//       log('Error deleting reminder: $e');
//     }
//   }
// }