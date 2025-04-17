import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prolife_service/profile_screen/profile_menu_Item.dart';
import 'package:prolife_service/screens/booking_screen/booking_details_page.dart';
import 'package:provider/provider.dart';
import '../getx_service/language_service.dart';
import '../provider/auth_provider.dart';
import '../provider/profile_provider.dart';
import '../screens/settings_pages/privacy_policy_page.dart';
import '../screens/settings_pages/terms_and_conditions_page.dart';
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

  void _showLanguageDialog() {
    final languageService = Get.find<LanguageService>();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('select_language'.tr),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('English'),
                leading: Radio(
                  value: 'en',
                  groupValue: languageService.currentLocale,
                  onChanged: (value) {
                    languageService.changeLanguage(value as String);
                    Navigator.pop(context);
                  },
                ),
              ),
              ListTile(
                title: Text('Español'),
                leading: Radio(
                  value: 'es',
                  groupValue: languageService.currentLocale,
                  onChanged: (value) {
                    languageService.changeLanguage(value as String);
                    Navigator.pop(context);
                  },
                ),
              ),
              ListTile(
                title: Text('हिंदी'),
                leading: Radio(
                  value: 'hi',
                  groupValue: languageService.currentLocale,
                  onChanged: (value) {
                    languageService.changeLanguage(value as String);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 60),
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
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Material(
                      borderRadius: BorderRadius.circular(12),
                      elevation: 2,
                      color: isDarkMode ? theme.cardColor : Colors.white,
                      child: Column(
                        children: [
                          ProfileMenuItem(
                            icon: Icons.edit,
                            iconColor: Color(0xFF6A11CB),
                            title: 'edit_profile'.tr,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => EditProfilePage(),
                                ),
                              );
                            },
                          ),
                          const Divider(height: 1, indent: 16),
                          ProfileMenuItem(
                            icon: Icons.calendar_today,
                            iconColor: const Color(0xFF2575FC),
                            title: 'my_bookings'.tr,
                            onTap: () {
                              Get.to(const BookingDetailsPage());
                            },
                          ),
                          const Divider(height: 1, indent: 16),
                          ProfileMenuItem(
                            icon: Icons.location_pin,
                            iconColor: const Color(0xFF4CAF50),
                            title: 'my_addresses'.tr,
                            onTap: () {

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
                            iconColor: Color(0xFF9C27B0),
                            title: 'privacy_policy'.tr,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PrivacyPolicyPage(),
                                ),
                              );
                            },
                          ),
                          const Divider(height: 1, indent: 16),
                          ProfileMenuItem(
                            icon: Icons.description,
                            iconColor: Color(0xFF673AB7),
                            title: 'terms_conditions'.tr,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => TermsAndConditionsPage(),
                                ),
                              );
                            },
                          ),
                          const Divider(height: 1, indent: 16),
                          ProfileMenuItem(
                            icon: Icons.support_agent,
                            iconColor: Color(0xFFFF9800),
                            title: 'customer_support'.tr,
                            onTap: () {},
                          ),
                          Divider(height: 1, indent: 16),
                          ProfileMenuItem(
                            icon: Icons.language,
                            iconColor: Color(0xFF2196F3),
                            title: 'language'.tr,
                            trailing: Text(
                              Get.find<LanguageService>().currentLocale == 'en'
                                  ? 'English'
                                  : 'Hindi',
                              style: TextStyle(
                                color: theme.textTheme.bodySmall?.color,
                              ),
                            ),
                            onTap: _showLanguageDialog,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.logout, color: Colors.white),
                      label: Text(
                        'logout'.tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        Provider.of<AuthProvider>(context, listen: false)
                            .signOut(context);
                      },
                    ),
                  ),
                  SizedBox(height: 24),
                ]),
              ),
            ],
          );
        },
      ),
    );
  }
}
