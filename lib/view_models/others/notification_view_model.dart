import 'package:get/get.dart';

class NotificationViewModel extends GetxController {
  RxList<Map<String, dynamic>> notifications = <Map<String, dynamic>>[
    {
      'title': 'Your booking is confirmed!',
      'subtitle': 'Your relaxing spa session is ready.',
      'date': 'Today',
      'isRead': false
    },
    {
      'title': 'Preferred stylist available',
      'subtitle': 'Your favorite stylist is free this Wednesday.',
      'date': 'Today',
      'isRead': false
    },
    {
      'title': 'Waiting time update',
      'subtitle': 'Your estimated wait time is approx. 25 minutes.',
      'date': 'Today',
      'isRead': false
    },
    {
      'title': '50% OFF on Haircut',
      'subtitle': 'Limited time offer!',
      'date': 'Yesterday',
      'isRead': true
    },
    {
      'title': '20% OFF Massage',
      'subtitle': 'Great discount on massage services.',
      'date': '17 August 2023',
      'isRead': true
    },
  ].obs;

  final Function onRead;

  NotificationViewModel({required this.onRead});

  void toggleRead(int index) {
    notifications[index]['isRead'] = true;
    notifications.refresh();
    _checkAllRead();
  }

  void deleteNotification(int index) {
    notifications.removeAt(index);
    _checkAllRead();
  }

  void markAllAsRead() {
    for (var n in notifications) {
      n['isRead'] = true;
    }
    notifications.refresh();
    onRead();
  }

  void _checkAllRead() {
    if (notifications.every((n) => n['isRead'])) onRead();
  }

  /// Group notifications by date
  Map<String, List<Map<String, dynamic>>> get groupedNotifications {
    Map<String, List<Map<String, dynamic>>> grouped = {};
    for (var n in notifications) {
      grouped.putIfAbsent(n['date'], () => []);
      grouped[n['date']]!.add(n);
    }
    return grouped;
  }
}
