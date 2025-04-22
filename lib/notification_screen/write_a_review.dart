import 'package:flutter/material.dart';
import 'package:prolife_service/notification_screen/review_provider.dart';
import 'package:provider/provider.dart';
import '../screens/booking_screen/feedback_screen.dart';

class WriteReviewPage extends StatelessWidget {
  const WriteReviewPage({super.key});

  Widget buildStarRow(int rating, Function(int) onTap) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () => onTap(index + 1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Icon(
              index < rating ? Icons.star : Icons.star_border,
              color: Colors.blue,
              size: 33,
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReviewProvider>(context);
    final commentController = TextEditingController(text: provider.comment);

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text('Write a Review'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // Service Rating
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('My Service was Excellent', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                    const SizedBox(height: 10),
                    buildStarRow(provider.serviceRating, provider.updateServiceRating),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: Checkbox(
                            value: provider.recommended,
                            onChanged: (val) => provider.updateRecommended(val ?? true),
                          ),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Text(
                              'I recommended this service provider to my friends',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Tags
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('What impressed you?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 9,
                      children: provider.tags.entries.map((entry) {
                        final tag = entry.key;
                        final color = entry.value;
                        final selected = provider.selectedTag == tag;
                        return ChoiceChip(
                          label: Text(
                            tag,
                            style: TextStyle(
                              fontSize: 17,
                              color: selected ? Colors.white : Colors.black,
                            ),
                          ),
                          selected: selected,
                          selectedColor: color,
                          backgroundColor: Colors.grey[200],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          onSelected: (_) => provider.updateSelectedTag(tag),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Technician Rating
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Rate Technician', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                    const SizedBox(height: 10),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: const Icon(Icons.person),
                        maxRadius: 25,
                        minRadius: 25,
                      ),
                      title: const Text('John Williams', style: TextStyle(fontSize: 25)),
                      subtitle: buildStarRow(provider.technicianRating, provider.updateTechnicianRating),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: commentController,
                      maxLines: 4,
                      onChanged: provider.updateComment,
                      decoration: const InputDecoration(
                        hintText: 'Add a Comment',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Submit Button
            ElevatedButton(
              onPressed: () async {
                await provider.submitReview();
                Navigator.push(context, MaterialPageRoute(builder: (_) => FeedbackScreen()));
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Submit Review', style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
