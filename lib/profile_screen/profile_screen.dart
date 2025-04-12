import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../global_widget/listtile_widget.dart';
import '../provider/auth_provider.dart';
import '../provider/profile_provider.dart';
import '../screens/settings_pages/privacy_policy_page.dart';
import '../screens/settings_pages/terms_and_conditions_page.dart';
import 'edit_profile_page.dart';

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
      appBar: AppBar(title: const Text('My Profile'), centerTitle: true),
      body: Consumer<ProfileProvider>(
        builder: (context, provider, child) {
          final imageUrl = provider.userData?['imageUrl'];
          return Column(
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundImage: imageUrl != null && imageUrl.isNotEmpty
                    ? NetworkImage(imageUrl)
                    : const NetworkImage(
                        'https://www.gravatar.com/avatar/default?s=200'),
              ),
              const SizedBox(height: 10),
              Text(
                provider.userData?['name'] ?? 'Loading...',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    GlobalListTile(
                      icon: Icons.edit,
                      title: 'Edit Profile',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const EditProfilePage()));
                      },
                    ),
                    GlobalListTile(icon: Icons.book, title: 'My Booking'),
                    GlobalListTile(
                        icon: Icons.location_on, title: 'My Address'),
                    GlobalListTile(
                      icon: Icons.privacy_tip,
                      title: 'Privacy Policy',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => PrivacyPolicyPage()));
                      },
                    ),
                    GlobalListTile(
                      icon: Icons.description,
                      title: 'Terms & Conditions',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => TermsAndConditionsPage()));
                      },
                    ),
                    GlobalListTile(
                        icon: Icons.support_agent, title: 'Customer Service'),
                    GlobalListTile(icon: Icons.language, title: 'Languages'),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: const Text('Logout',
                          style: TextStyle(color: Colors.red)),
                      onTap: () {
                        Provider.of<AuthProvider>(context, listen: false)
                            .signOut(context);
                      },
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
