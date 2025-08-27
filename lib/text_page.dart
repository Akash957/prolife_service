import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class RatingScreen extends StatefulWidget {
  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  double selectedRating = 0.0;
  int reviewCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rating & Review Count")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RatingBar.builder(
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 50, // ⭐ Star size
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.blue,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  selectedRating = rating;  // ⭐ Rating store karega
                  reviewCount += 1;        // ⭐ Har bar ek review count badhega
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              "Total Reviews: $reviewCount",  // ⭐ Total reviews dikhayega
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
