import 'dart:developer';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await _notificationsPlugin.initialize(initializationSettings);
    await requestNotificationPermission();
    await requestExactAlarmPermission();

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'event_reminder_channel',
      'Event Reminder',
      description: 'Notifications for upcoming events',
      importance: Importance.high,
      playSound: true,
    );

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    tz.initializeTimeZones();
    String eventTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(eventTimeZone));
    log("Current Time Zone: $eventTimeZone");
  }

  static Future<void> requestNotificationPermission() async {
    final PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      log('Notification permissions granted.');
    } else {
      log('Notification permissions denied.');
    }
  }

  static Future<void> requestExactAlarmPermission() async {
    final status = await Permission.scheduleExactAlarm.request();
    log('Exact alarm permission request status: $status');
    if (status.isDenied) {
      log('Exact alarm permission denied by user.');
    } else if (status.isPermanentlyDenied) {
      log('Exact alarm permission permanently denied by user.');
      openAppSettings();
    } else if (status.isGranted) {
      log('Exact alarm permission granted.');
    }
  }

  static Future<void> scheduleEventNotifications(DateTime eventDateTime) async {
    final tz.TZDateTime eventTime = tz.TZDateTime.from(eventDateTime, tz.local);

    if (eventTime.isBefore(tz.TZDateTime.now(tz.local))) {
      log('Event time is in the past. Notification not scheduled.');
      return;
    }

    final notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    try {
      await _notificationsPlugin.zonedSchedule(
        notificationId,
        'Event Reminder',
        'Your event starts now!',
        eventTime,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'event_reminder_channel',
            'Event Reminder',
            channelDescription: 'Notifications for upcoming events',
            importance: Importance.high,
            priority: Priority.high,
            playSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
      log('Event Scheduled! Notification ID: $notificationId, Scheduled Time: $eventTime');
    } catch (e) {
      log('Error scheduling notification: $e');
    }
  }
}