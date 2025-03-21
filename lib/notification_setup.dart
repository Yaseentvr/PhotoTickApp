// notification_setup.dart
import 'package:phototickapp/notifications/notification_service.dart';

Future<void> initializeNotifications() async {
  // Initialize notifications and request permissions
  await NotificationService.initialize();
  await NotificationService.requestNotificationPermission();
  await NotificationService.requestExactAlarmPermission(); // Add this line if needed
}