import 'package:flutter/material.dart';

import 'write_a_review.dart';

class BookingDetailsPage extends StatelessWidget {
  const BookingDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    "https://images.pexels.com/photos/4107285/pexels-photo-4107285.jpeg",
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Living Room Cleaning",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        children: List.generate(
                          5,
                              (index) => const Icon(Icons.star, size: 16, color: Colors.amber),
                        ),
                      ),const SizedBox(height: 5,),
                      const Text(
                        "\₹190",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> WriteReviewPage()));
                    },
                    child: const Text("Write a Review"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Book Again"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text("About Service Provider", style: TextStyle(fontWeight: FontWeight.bold)),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://randomuser.me/api/portraits/men/32.jpg"),
                radius: 24,
              ),
              title: const Text("Ronald Richards"),
              subtitle: const Text("Service Provider"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.call, color: Colors.blue)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.message, color: Colors.blue)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            const Text("Booking Status", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const BookingStatusTile(
              title: "Booking Confirmed",
              subtitle: "Service provider has accept your booking",
              date: "Mon, Oct 02, 2023",
              time: "10:00 AM",
              isCompleted: true,
            ),
            const BookingStatusTile(
              title: "Vendor Out for Service",
              subtitle: "Service Provider has out for your service and reaching your location",
              date: "Mon, Oct 02, 2023",
              time: "09:00 AM",
              isCompleted: true,
            ),
            const BookingStatusTile(
              title: "Service Completed",
              subtitle: "Service Provider has complete his service",
              date: "Mon, Oct 02, 2023",
              time: "12:00 AM",
              isCompleted: true,
              isLast: true,
            ),
            const SizedBox(height: 16),
            const Text("Payment Summary", style: TextStyle(fontWeight: FontWeight.bold)),
            const PaymentRow(label: "Item Total", value: "\₹200"),
            const PaymentRow(label: "Discount", value: "-\₹10"),
            const PaymentRow(label: "Delivery Fee", value: "Free"),
            const Divider(),
            const PaymentRow(label: "Grand Total", value: "\₹190", isTotal: true,),
          ],
        ),
      ),
    );
  }
}


class BookingStatusTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final String time;
  final bool isCompleted;
  final bool isLast;

  const BookingStatusTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.time,
    this.isCompleted = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(Icons.radio_button_checked, color: isCompleted ? Colors.blue : Colors.grey),
            if (!isLast)
              Container(height: 40, width: 2, color: Colors.blue.withOpacity(0.5)),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(subtitle),
              Text("$date at $time", style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 12),
            ],
          ),
        )
      ],
    );
  }
}

class PaymentRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const PaymentRow({
    super.key,
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = isTotal
        ? const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
        : const TextStyle(fontSize: 14);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: textStyle),
          Text(value, style: textStyle),
        ],
      ),
    );
  }
}

