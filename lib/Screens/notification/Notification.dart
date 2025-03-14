// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

// final FlutterLocalNotificationsPlugin localNotification =
//     FlutterLocalNotificationsPlugin();

// Future<void> notificationInitialize() async {
//   const AndroidInitializationSettings androidSettings =
//       AndroidInitializationSettings("@mipmap/ic_launcher");

//   final InitializationSettings defaultSettings = InitializationSettings(
//     android: androidSettings,
//   );

//   await localNotification.initialize(defaultSettings);
//   await requestNotificationPermission();

//   // Initialize timezone settings
//   tz.initializeTimeZones();
// }

// Future<void> requestNotificationPermission() async {
//   final AndroidFlutterLocalNotificationsPlugin? androidPermission =
//       localNotification.resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>();
//   if (androidPermission != null) {
//     await androidPermission.requestNotificationsPermission();
//   }
// }

// Future<void> showNotification({
//   required String title,
//   required String body,
//   required DateTime notificationTime, // New parameter for notification time
// }) async {
//   final DateTime now = DateTime.now();

//   // Schedule notification 1 hour before the event time
//   final DateTime notificationScheduleTime = notificationTime.subtract(Duration(hours: 1));

//   if (notificationScheduleTime.isAfter(now)) {
//     // Convert DateTime to TZDateTime for correct timezone support
//     final tz.TZDateTime tzScheduleTime = tz.TZDateTime.from(notificationScheduleTime, tz.local);

//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//       "event_alert_1",
//       "event_alert_channel",
//       importance: Importance.high,
//       priority: Priority.high,
//       sound: RawResourceAndroidNotificationSound("notification_sound"),
//     );

//     final NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);

//     await localNotification.zonedSchedule(
//       0, // Notification ID
//       title, // Notification Title
//       body, // Notification Body
//       tzScheduleTime, // Time when the notification will trigger
//       notificationDetails,
//       androidScheduleMode: AndroidScheduleMode.alarmClock,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       matchDateTimeComponents: DateTimeComponents.time, // Make sure it's precise to the hour and time
//     );
//   } else {
//     print('Notification time has already passed');
//   }
// }
