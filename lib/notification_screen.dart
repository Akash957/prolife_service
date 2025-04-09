import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text("Notification", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.more_outlined, color: Colors.black),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const NotificationSectionTitle(title: "Today"),
          NotificationCard(
            icon: Icons.payment,
            title: "Payment Successful!",
            subtitle: "You have made a services payment",
            color: Colors.deepPurpleAccent,
          ),
          NotificationCard(
            icon: Icons.category,
            title: "New Category Services!",
            subtitle: "Now the plumbing service is available",
            color: Colors.pinkAccent,
          ),
          const SizedBox(height: 24),
          const NotificationSectionTitle(title: "Yesterday"),
          NotificationCard(
            icon: Icons.local_offer,
            title: "Today’s Special Offers",
            subtitle: "You get a special promo today!",
            color: Colors.amber,
          ),
          const SizedBox(height: 24),
          const NotificationSectionTitle(title: "December 22, 2025"),
          NotificationCard(
            icon: Icons.credit_card,
            title: "Credit Card Connected!",
            subtitle: "Credit Card has been linked!",
            color: Colors.deepPurple,
          ),
          NotificationCard(
            icon: Icons.check_circle,
            title: "Account Setup Successful!",
            subtitle: "Your account has been created!",
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}

class NotificationSectionTitle extends StatelessWidget {
  final String title;

  const NotificationSectionTitle({Key? key, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext      context) {
    return Text(
      title, style: const
      TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const NotificationCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color, size: 28),
        ),
        title: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            subtitle,
            style: const TextStyle(color: Colors.black54),
          ),
        ),
      ),
    );
  }
}

