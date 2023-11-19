// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:katakara_investor/values/values.dart';

awesome_notification() => AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://drawable/logon',
      [
        NotificationChannel(
            channelKey: 'high_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: AppColor.primary,
            importance: NotificationImportance.Max,
            enableLights: true,
            channelShowBadge: true,
            ledColor: AppColor.primary)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'notification_importance_channel',
          channelGroupName: 'Notification channel',
        ),
        NotificationChannelGroup(
          channelGroupKey: 'message_importance_channel_group',
          channelGroupName: 'Message channel',
        )
      ],
      debug: true,
    );

accept_permission() =>
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications(
          channelKey: 'high_channel',
          permissions: [
            NotificationPermission.Alert,
            NotificationPermission.Badge,
            NotificationPermission.Sound,
            NotificationPermission.Vibration,
            NotificationPermission.OverrideDnD,
            NotificationPermission.Provisional
          ],
        );
      }
    });

class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
    log("notification is created receivedNotification ----- oncreated");
    // createNotification(receivedNotification.title, receivedNotification.body,
    //     receivedNotification.id);
  }

  /// Use this method to detect every time that a new notification is displa yed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
    log("notification is displayed receivedNotification  ----- on displayed");
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
    log("notification is dismissed receivedAction ----- on dismiss");
    AwesomeNotifications().dismissAllNotifications();
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
    // log("notification is onAction received $receivedAction ----- on action");
    AwesomeNotifications()
        .dismissNotificationsByGroupKey(receivedAction.groupKey!);
  }

  static createNotification(RemoteMessage message) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            backgroundColor: AppColor.primary,
            color: AppColor.white,
            id: message.hashCode,
            title: message.data['title'],
            body: message.data['body'],
            channelKey: 'high_channel',
            groupKey: message.data['notificationType'] == "notification"
                ? "notification_importance_channel"
                : "message_importance_channel_group",
            wakeUpScreen: true,
            bigPicture: message.data['image'],
            largeIcon: message.data['image'],
            hideLargeIconOnExpand: true,
            ticker: 'Katakara',
            payload: message.data['payload'],
            notificationLayout: message.data.containsKey('image')
                ? NotificationLayout.BigPicture
                : NotificationLayout.Inbox));
  }
}
