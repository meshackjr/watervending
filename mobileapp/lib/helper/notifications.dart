import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {

  NotificationServices(){
    _initializeNotifications();
  }

  FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  String groupKey = 'com.dibezz.elimu';
  String _channelId = 'channelid';
  String _channelName = 'channelname';
  String _channelDescription = 'channeldescription';

  Future _onSelectNotification(String payload) async {
    if (payload != null) {
      print('notification payload: ' + payload);
    }
  }

  Future _initializeNotifications() async {
    final initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final initializationSettingsIOS = IOSInitializationSettings();
    final initializationSettings = InitializationSettings(
      initializationSettingsAndroid,
      initializationSettingsIOS,
    );
    _plugin.initialize(
      initializationSettings,
      onSelectNotification: _onSelectNotification,
    );
  }

  Future<void> cancelAll() async {
    _plugin.cancelAll();
  }

  Future<void> cancel({id =1}) async {
    _plugin.cancel(id);
  }

  Future<void> notify(
    {int id,String title,String photo,String body}
  ) async {
    
    AndroidNotificationDetails android = AndroidNotificationDetails(
      _channelId, _channelName, _channelDescription,
      playSound: false,
      priority: Priority.Max,
      styleInformation: id == 200 ? MessagingStyleInformation(
        Person(
          name: title,
          uri: photo
        ),
        messages: [
          Message(
            body, DateTime.now(),Person(name: title, uri: photo)
          )
        ],
        groupConversation: true
      ) : null,
    );
    IOSNotificationDetails iOS;
    _plugin
    .show(
      id=1,
      title, 
      body, 
      NotificationDetails(android, iOS)
    );
  }

  Future<void>  notificationDetails({
    List<Message> messages,
    String conversationTitle,
    bool groupConversation = true,
    Person person,
    int id,
    String title,
    String description
  }) async{
   MessagingStyleInformation messagingStyleInformation = new MessagingStyleInformation(
     person,
      messages: messages,
      conversationTitle: conversationTitle,
    );

    AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _channelId, _channelName, _channelDescription,
      styleInformation: messagingStyleInformation,
      importance: Importance.Low,
      priority: Priority.Low,
      groupKey: groupKey,
      playSound: true,
      ongoing: true,
      setAsGroupSummary: true
    );
    
    NotificationDetails platformChannelSpecifics =
    new NotificationDetails(androidPlatformChannelSpecifics, null);
    
    await _plugin.show(200, 'Messages' , '', platformChannelSpecifics);
 }

}
