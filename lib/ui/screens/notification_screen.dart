import 'package:flutter/material.dart';

// Screen displaying user notifications
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),

      // List of notifications
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context,index){

          return ListTile(

            // User avatar
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),

            // Notification message
            title: Text("User $index liked your post"),

            // Time of notification
            subtitle: const Text("2 minutes ago"),

            // Icon showing interaction type
            trailing: const Icon(Icons.favorite,color: Colors.red),
          );

        },
      ),
    );
  }
}