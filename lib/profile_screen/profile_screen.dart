import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prolife_service/profile_screen/profile_menu_Item.dart';
import 'package:prolife_service/screens/booking_screen/booking_details_page.dart';
import 'package:provider/provider.dart';
import '../address_screen/shaved_address_screen.dart';
import '../provider/auth_provider.dart';
import '../provider/profile_provider.dart';
import '../screens/settings_pages/privacy_policy_page.dart';
import '../screens/settings_pages/terms_and_conditions_page.dart';
import '../service/call_support.dart';
import '../service/dynamic_link_service.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

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
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<ProfileProvider>(
        builder: (context, provider, child) {
          final imageUrl = provider.userData?['imageUrl'];
          final email = provider.userData?['email'] ?? 'user@example.com';
          final name = provider.userData?['name'] ?? 'Loading...';

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 220.0,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF6A11CB),
                          Color(0xFF2575FC),
                        ],
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: -50,
                          top: -50,
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                        ),
                        Positioned(
                          left: -30,
                          bottom: -30,
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Hero(
                                  tag: 'profile-avatar',
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundColor:
                                        Colors.white.withOpacity(0.2),
                                    child: ClipOval(
                                      child: imageUrl != null &&
                                              imageUrl.isNotEmpty
                                          ? Image.network(
                                              imageUrl,
                                              width: 96,
                                              height: 96,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return const Icon(Icons.person,
                                                    size: 50,
                                                    color: Colors.white);
                                              },
                                            )
                                          : const Icon(Icons.person,
                                              size: 50, color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  email,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Material(
                      borderRadius: BorderRadius.circular(12),
                      elevation: 2,
                      color: isDarkMode ? theme.cardColor : Colors.white,
                      child: Column(
                        children: [
                          ProfileMenuItem(
                            icon: Icons.edit,
                            iconColor: const Color(0xFF6A11CB),
                            title: 'Edit Profile',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const EditProfilePage()),
                              );
                            },
                          ),
                          const Divider(height: 1, indent: 16),
                          ProfileMenuItem(
                            icon: Icons.calendar_today,
                            iconColor: const Color(0xFF2575FC),
                            title: 'My Bookings',
                            onTap: () {
                              Get.to(BookingStates());
                            },
                          ),
                          const Divider(height: 1, indent: 16),
                          ProfileMenuItem(
                            icon: Icons.location_pin,
                            iconColor: const Color(0xFF4CAF50),
                            title: 'My Addresses',
                            onTap: () {
                              Get.to(const ShavedAddressScreen());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Material(
                      borderRadius: BorderRadius.circular(12),
                      elevation: 2,
                      color: isDarkMode ? theme.cardColor : Colors.white,
                      child: Column(
                        children: [
                          ProfileMenuItem(
                            icon: Icons.privacy_tip,
                            iconColor: const Color(0xFF9C27B0),
                            title: 'Privacy Policy',
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (_) => const PrivacyPolicyPage()),
                              // );
                            },
                          ),
                          const Divider(height: 1, indent: 16),
                          ProfileMenuItem(
                            icon: Icons.description,
                            iconColor: const Color(0xFF673AB7),
                            title: 'Terms Conditions'.tr,
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (_) =>
                              //           const TermsAndConditionsPage()),
                              // );
                            },
                          ),
                          const Divider(height: 1, indent: 16),
                          ProfileMenuItem(
                            icon: Icons.support_agent,
                            iconColor: const Color(0xFFFF9800),
                            title: 'Customer Support',
                            onTap: callSupport,
                          ),
                          const Divider(height: 1, indent: 16),
                          ProfileMenuItem(
                            icon: Icons.share,
                            iconColor: const Color(0xFF2196F3),
                            title: 'Share App',
                            trailing: const Text(""),
                            onTap: () {
                              DynamicLinkService.shareApp(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: Text(
                        'Logout',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              title: const Row(
                                children: [
                                  Icon(Icons.logout, color: Colors.redAccent),
                                  SizedBox(width: 8),
                                  Text('Confirm Logout'),
                                ],
                              ),
                              content: const Text(
                                'Are you sure you want to logout?',
                                style: TextStyle(fontSize: 16),
                              ),
                              actionsAlignment: MainAxisAlignment.spaceBetween,
                              actions: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.grey[700],
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  child: Text('Cancel'.tr),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.redAccent,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  icon: const Icon(Icons.exit_to_app),
                                  label: Text('Logout'.tr),
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                    Future.delayed(
                                        const Duration(milliseconds: 100), () {
                                      Provider.of<AuthProvider>(context,
                                              listen: false)
                                          .signOut(context);
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                ]),
              ),
            ],
          );
        },
      ),
    );
  }
}
