import 'package:flutter/material.dart';
import 'dart:io';
import 'EditProfilePage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? name;
  String? profession;
  String? dob;
  String? about;
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: RichText(
          text: TextSpan(
            text: 'Blog',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xff2B1836),
            ),
            children: [
              TextSpan(
                text: 'Spot',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color(0xffB81736),
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffB81736), Color(0xff2B1836)],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            SizedBox(height: 30),
            CircleAvatar(
              radius: 80,
              backgroundImage: image != null
                  ? FileImage(image!)
                  : AssetImage('assets/profile_placeholder.png')
                      as ImageProvider,
            ),
            SizedBox(height: 20),
            // Follower and Following Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      '580', // Random follower number
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Followers',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '300', // Random following number
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Following',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30), // Spacing before profile info
            ProfileInfoDisplay(label: 'Name', value: name ?? ''),
            ProfileInfoDisplay(label: 'Profession', value: profession ?? ''),
            ProfileInfoDisplay(label: 'Date of Birth', value: dob ?? ''),
            ProfileInfoDisplay(label: 'About', value: about ?? ''),
            SizedBox(height: 100),
            ElevatedButton(
              child: Text(
                'Edit Profile',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(
                      name: name ?? '',
                      profession: profession ?? '',
                      dob: dob ?? '',
                      about: about ?? '',
                      image: image,
                    ),
                  ),
                );

                if (result != null && result is Map<String, dynamic>) {
                  setState(() {
                    name = result['name'];
                    profession = result['profession'];
                    dob = result['dob'];
                    about = result['about'];
                    image = result['image'];
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffB81736),
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileInfoDisplay extends StatelessWidget {
  final String label;
  final String value;

  const ProfileInfoDisplay({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.white70, fontSize: 18),
          ),
          Text(
            value,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
