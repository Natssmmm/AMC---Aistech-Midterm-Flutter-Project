import 'package:flutter/material.dart';

// User profile page
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(height: 20),

            // Profile picture
            const CircleAvatar(
              radius: 45,
              backgroundColor: Colors.grey,
            ),

            const SizedBox(height: 10),

            // Username
            const Text(
              "@username",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),

            const SizedBox(height: 5),

            // User bio
            const Text(
              "Flutter Developer",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            // Profile statistics
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [

                Column(
                  children: [
                    Text("120",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),
                    ),
                    Text("Posts")
                  ],
                ),

                Column(
                  children: [
                    Text("2.5K",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),
                    ),
                    Text("Followers")
                  ],
                ),

                Column(
                  children: [
                    Text("300",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),
                    ),
                    Text("Following")
                  ],
                ),

              ],
            ),

            const SizedBox(height: 20),

            // Grid displaying user's posts
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemCount: 12,
              itemBuilder: (context,index){

                return Container(
                  color: Colors.grey[900],
                );

              },
            )

          ],
        ),
      ),
    );
  }
}