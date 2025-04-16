import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../global_widget/globle_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 5,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 40,
                ),
                Text(
                  "Service Address",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_none_outlined,
                      size: 40,
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.blue.shade100),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search",
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    GlobalWidget .WorkNameText(context, "All Category"),
                    Spacer(),
                    GlobalWidget .SeeAllCategories(() {}, context, "See All"),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        GlobalWidget .AllCategory(
                          context,
                          "Carpenter",
                          "assets/image/carpernter_bc.png",
                          () {},
                        ),
                        GlobalWidget .AllCategory(
                          context,
                          "Cleaner",
                          "assets/image/cliner.png",
                          () {},
                        ),
                        GlobalWidget .AllCategory(
                          context,
                          "Painter",
                          "assets/image/painter_bc.png",
                          () {},
                        ),
                        GlobalWidget .AllCategory(
                          context,
                          "Electrician",
                          "assets/image/electric_bc.png",
                          () {},
                        ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        GlobalWidget .AllCategory(
                          context,
                          "Ac Repair",
                          "assets/image/ac_repairing_bc.png",
                          () {},
                        ),
                        GlobalWidget .AllCategory(
                          context,
                          "Plumber",
                          "assets/image/plumber.png",
                          () {},
                        ),
                        GlobalWidget .AllCategory(
                          context,
                          "Men's Salon",
                          "assets/image/salon.jpeg",
                          () {},
                        ),
                        GlobalWidget .AllCategory(
                          context,
                          "Beauty",
                          "assets/image/beauty_bc.png",
                          () {},
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 20),
                  child: Row(
                    children: [
                      GlobalWidget .WorkNameText(context, "Best Service"),
                      Spacer(),
                      GlobalWidget .SeeAllCategories(() {}, context, "See All")
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        height: heightScreen * 0.4,
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GlobalWidget .BestServicesImage1(
                                context,
                                "assets/image/kitchen.jpeg",
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: RatingBar.builder(
                                  // minRating: 0,
                                  // direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 30,
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.blue,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print('User selected rating: $rating');
                                  },
                                ),
                              ),
                              GlobalWidget .WorkNameText(
                                  context, "Complete Kitchen Clinaning"),
                              Row(
                                children: [
                                  GlobalWidget .TextSpanTextOriginal(
                                      context, "150", "50"),
                                  SizedBox(
                                    width: 80,
                                  ),
                                  GlobalWidget .ServicesProvideAddButton(
                                      () {}, context, "Add")
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: heightScreen * 0.4,
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GlobalWidget .BestServicesImage1(
                                context,
                                "assets/image/kitchen.jpeg",
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: RatingBar.builder(
                                  // minRating: 0,
                                  // direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 30,
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.blue,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print('User selected rating: $rating');
                                  },
                                ),
                              ),
                              GlobalWidget .WorkNameText(
                                  context, "Complete Kitchen Clinaning"),
                              Row(
                                children: [
                                  GlobalWidget .TextSpanTextOriginal(
                                      context, "150", "50"),
                                  SizedBox(
                                    width: 80,
                                  ),
                                  GlobalWidget .ServicesProvideAddButton(
                                      () {}, context, "Add")
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GlobalWidget .BestServicesImage1(
                  context,
                  "assets/image/kitchen.jpeg",
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
