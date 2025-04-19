import 'package:flutter/material.dart';

class WriteReviewPage extends StatefulWidget {
  const WriteReviewPage({super.key});

  @override
  _WriteReviewPageState createState() => _WriteReviewPageState();
}

class _WriteReviewPageState extends State<WriteReviewPage> {
  int serviceRating = 5;
  int technicianRating = 5;
  bool recommended = true;
  List<String> selectedTags = ['Service Quality'];
  final commentController = TextEditingController();

  Map<String, Color> tags = {
    'Service Quality': Colors.blue,
    'Technician Behaviour': Colors.blue,
    'On Time Service': Colors.blue,
    'Customer Support': Colors.blue,
  };

  Widget buildStarRow(int rating, Function(int) onTap) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () => onTap(index + 1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
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
            const Text(
              'My Service was Excellent',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            buildStarRow(
                serviceRating, (val) => setState(() => serviceRating = val)),
            Row(
              children: [
                Checkbox(
                  value: recommended,
                  onChanged: (val) => setState(() => recommended = val!),
                ),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                      'I recommended this service provider to my friends',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            const Text(
              'What impressed you?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox(height: 10,),
            Wrap(
              spacing: 10,
              children: tags.entries.map((entry) {
                final tag = entry.key;
                final color = entry.value;
                final selected = selectedTags.contains(tag);
                return ChoiceChip(
                  label: Text(
                    tag,
                    style: TextStyle(
                      fontSize: 18,
                      color: selected ? Colors.white : Colors.black,
                    ),
                  ),
                  selected: selected,
                  selectedColor: color,
                  backgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onSelected: (_) {
                    setState(() {
                      selected
                          ? selectedTags.remove(tag)
                          : selectedTags.add(tag);
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 25),
            const Text(
              'Rate Technician',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.person),
                maxRadius: 25,
                minRadius: 25,
              ),
              title: const Text(
                'John Williams',
                style: TextStyle(fontSize: 25),
              ),
              subtitle: buildStarRow(technicianRating,
                      (val) => setState(() => technicianRating = val)),
            ),
            TextField(
              controller: commentController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Add a Comment',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {

              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
              child: const Text(
                'Submit Review',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
