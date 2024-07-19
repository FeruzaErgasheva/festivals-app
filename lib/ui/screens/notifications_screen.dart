import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotificationScreen(),
    );
  }
}

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back, color: Colors.orange)),
      ),
      body: Container(
        color: Colors.black,
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: [
            NotificationItem(
              name: 'Botir Murodov',
              time: '22:00 19-Iyun, 2024',
              message:
                  'Universitetlar bo\'yicha tadbirda qatnashish niyatim bor edi, qabul qila olasizmi?',
              avatar:
                  'https://t3.ftcdn.net/jpg/06/17/13/26/360_F_617132669_YptvM7fIuczaUbYYpMe3VTLimwZwzlWf.jpg',
            ),
            NotificationItem(
              name: 'Aziza Nodirova',
              time: '22:10 19-Iyun, 2024',
              message:
                  'Universitetlar bo\'yicha tadbirda qatnashish niyatim bor edi, qabul qila olasizmi?',
              avatar:
                  'https://t3.ftcdn.net/jpg/06/17/13/26/360_F_617132669_YptvM7fIuczaUbYYpMe3VTLimwZwzlWf.jpg',
            ),
            NotificationItem(
              name: 'Alisher Zokirov',
              time: '22:00 19-Iyun, 2024',
              message:
                  'Flutter Global Hakaton 2024 tadbiriga qabul qilindingiz. Tarbirda kurishguncha.',
              avatar:
                  'https://t3.ftcdn.net/jpg/06/17/13/26/360_F_617132669_YptvM7fIuczaUbYYpMe3VTLimwZwzlWf.jpg',
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String name;
  final String time;
  final String message;
  final String avatar;

  NotificationItem({
    required this.name,
    required this.time,
    required this.message,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      elevation: 2.0,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(avatar),
        ),
        title: Text(
          name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style: TextStyle(color: Colors.grey, fontSize: 12.0),
            ),
            SizedBox(height: 5),
            Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
          ],
        ),
        trailing: Icon(Icons.circle, color: Colors.red, size: 12),
      ),
    );
  }
}
