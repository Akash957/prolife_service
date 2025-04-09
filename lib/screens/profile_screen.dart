import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prolife_service/screens/booking_screen/booking_success.dart';
import 'package:prolife_service/screens/edit_profile_page.dart';
import 'package:prolife_service/screens/settings_pages/privacy_policy_page.dart';
import 'package:prolife_service/screens/settings_pages/termsandconditions_page.dart';

import '../global_widget/listtile_widget.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage('https://lh3.googleusercontent.com/p/AF1QipOZVAVKpNQUqXJ5_nmk--VjM4AY95-ooPvbUPXc=s1360-w1360-h1020'),
                ),
                SizedBox(height: 10),
                Text(
                  'Neeraj Kumar',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                // IconButton(
                //   icon: Icon(Icons.camera_alt),
                //   onPressed: () {
                //     // Code to change profile picture
                //   },
                // ),
                SizedBox(height: 20),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  GlobalListTile(icon: Icons.edit, title: 'Edit Profile',onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  EditProfilePage(),));
                  },),
                  GlobalListTile(icon: Icons.lock, title: 'Change Password'),
                  GlobalListTile(icon: Icons.book, title: 'My Booking'),
                  GlobalListTile(icon: Icons.location_on, title: 'My Address'),
                  GlobalListTile(icon: Icons.privacy_tip, title: 'Privacy Policy',onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  PrivacyPolicyPage(),));

                  },),
                  GlobalListTile(icon: Icons.description, title: 'Terms & Conditions',onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  const TermsAndConditionsPage(),));

                  },),
                  GlobalListTile(icon: Icons.support_agent, title: 'Customer Service'),
                  GlobalListTile(icon: Icons.language, title: 'Languages'),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.red),
                    title: Text('Logout', style: TextStyle(color: Colors.red)),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BookingSuccessScreen(),));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}
