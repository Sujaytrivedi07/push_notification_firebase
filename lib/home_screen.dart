import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:push_notification_firebase/notification_service.dart';
import 'package:push_notification_firebase/page_transition_effect.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method
    //when app is terminate
    FirebaseMessaging.instance.getInitialMessage().then(
          (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          LocalNotificationService.createanddisplaynotification(message);
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );
    // 2. This method only call when App in forground it mean app must be opened
    //app is in background
    FirebaseMessaging.onMessage.listen(
          (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
           LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );
    // 3. This method only call when App in background and not terminated(not closed)
    //when app is in background /not terminated
    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
     );
    LocalNotificationService().getDeviceToken().then((value) {
      print("this is device token");
      print(value);
    });
    // NotificationService().requestNotificationPermission();
    // NotificationService().firebaseInit();
    // NotificationService().isTokenRefresh();

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Homepage"),
      ),

      body: Container(
        color: Colors.greenAccent,
        child:Center(
          child: ElevatedButton(
            onPressed: (){
              Navigator.push(context,
              PageRouteBuilder(
                transitionDuration: Duration(seconds: 1),
                transitionsBuilder:
                (context,animation,animationTime,child){
                  animation=CurvedAnimation(parent: animation, curve:Curves.easeInCubic);
                  return ScaleTransition(scale: animation,alignment: Alignment.center,
                  child: child,);
                },
                pageBuilder: (context,animation,animationTime){
                  return PageTransition();
                  }
              ));
            },child: Text("Transition Effect"),
          ),
        ),
      ),
    );
  }
}
