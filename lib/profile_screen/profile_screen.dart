import 'package:flutter/material.dart';
import 'package:prolife_service/provider/auth_provider.dart';
import 'package:prolife_service/profile_screen/edit_profile_page.dart';
import 'package:prolife_service/screens/settings_pages/privacy_policy_page.dart';
import 'package:prolife_service/screens/settings_pages/terms_and_conditions_page.dart';
import 'package:provider/provider.dart';

import '../global_widget/listtile_widget.dart';
import '../provider/profile_provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileProvider>(context, listen: false).getUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        centerTitle: true,
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            provider.userData?['photoUrl'] ??
                                'https://www.gravatar.com/avatar/default?s=200',
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          provider.userData?['name'] ?? 'Loading...',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                    GlobalListTile(
                      icon: Icons.edit,
                      title: 'Edit Profile',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditProfilePage()),
                        );
                      },
                    ),

                    GlobalListTile(icon: Icons.lock, title: 'Change Password'),
                    GlobalListTile(icon: Icons.book, title: 'My Booking'),
                    GlobalListTile(icon: Icons.location_on, title: 'My Address'),
                    GlobalListTile(
                      icon: Icons.privacy_tip,
                      title: 'Privacy Policy',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
                        );
                      },
                    ),
                    GlobalListTile(
                      icon: Icons.description,
                      title: 'Terms & Conditions',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TermsAndConditionsPage()),
                        );
                      },
                    ),
                    GlobalListTile(icon: Icons.support_agent, title: 'Customer Service'),
                    GlobalListTile(icon: Icons.language, title: 'Languages'),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.logout, color: Colors.red),
                      title: Text('Logout', style: TextStyle(color: Colors.red)),
                      onTap: () {
                        Provider.of<AuthProvider>(context, listen: false)
                            .signOut(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}