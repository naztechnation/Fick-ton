
import 'package:fikkton/ui/auth/auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationManager {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final GlobalKey<NavigatorState> navigatorKey;

  NotificationManager({required this.navigatorKey}) {
    initialize();
  }

  void initialize() {
    // Request permissions and handle foreground notifications
    _firebaseMessaging.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Received foreground notification: $message");
      _handleNotification(message);
    });

    // Handle background and terminated notifications
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("User tapped notification: $message");
      _handleNotification(message);
    });
  }

  Future<void> _backgroundHandler(RemoteMessage message) async {
    print("Received background notification: $message");
    _handleNotification(message);
  }

  void _handleNotification(RemoteMessage message) {
    final data = message.data; // Access data from the notification payload

    // Extract the route name (e.g., '/details') from the notification data
    final routeName = data['route'];

    if (routeName != null) {
      navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (context) {
          
          return LoginScreen(); 
        }),
      );
    } else {
      navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (context) {
          
          return LoginScreen(); 
        }),
      );
    }
  }
}
































// {
//   "notification": {
//     "title": "Your Notification Title",
//     "body": "Your Notification Body"
//   },
//   "data": {
//     "route": "/details" // Add the route you want to navigate to
//   },
//   "to": "your_device_token"
// }
