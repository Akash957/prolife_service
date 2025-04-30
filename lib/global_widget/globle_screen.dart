import 'package:flutter/material.dart';

class GlobalWidget {
  static BookingImage(
    BuildContext context,
    image,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              image: NetworkImage(image),
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  static AllCategoryImage(BuildContext context, String text1, String text2,
      image, VoidCallback onPressed) {
    var widthScreen = MediaQuery.of(context).size.width * 2;
    var heightScreen = MediaQuery.of(context).size.height * 1;
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: Colors.grey.shade400,
              )),
          child: Row(
            children: [
              SizedBox(
                width: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  image: NetworkImage(image),
                  height: heightScreen * 0.1,
                  width: widthScreen * 0.1,
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text1,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    text2,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.grey.shade500),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static BestServicesImage1(
    BuildContext context,
    String image,
  ) {
    var widthScreen = MediaQuery.of(context).size.width * 0.7;
    // var heightScreen = MediaQuery.of(context).size;
    return InkWell(
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          height: 150,
          width: widthScreen,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  static ReferImage(
    BuildContext context,
    String image,
  ) {
    var widthScreen = MediaQuery.of(context).size.width * 1.0;
    var heightScreen = MediaQuery.of(context).size.height * 0.2;
    return InkWell(
      child: Container(
        height: heightScreen,
        width: widthScreen,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.fill,
              alignment: Alignment.center),
        ),
      ),
    );
  }

  static ServiceDateilImage(
    BuildContext context,
    String image,
  ) {
    var widthScreen = MediaQuery.of(context).size.width * 1.0;
    var heightScreen = MediaQuery.of(context).size.height * 0.3;
    return InkWell(
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          height: heightScreen,
          width: widthScreen,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  static BestServicesCircleAvatar(
    BuildContext context,
    String image,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.fill,
                alignment: Alignment.center),
          ),
        ),
      ),
    );
  }

  static BestServicesCircleAvatar2(
    BuildContext context,
    String image,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.fill,
                alignment: Alignment.center),
          ),
        ),
      ),
    );
  }

  static BestServicesProfile(
    BuildContext context,
    String image,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.fill,
                alignment: Alignment.center),
          ),
        ),
      ),
    );
  }

  static WorkNameText(
    BuildContext context,
    String text,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: SizedBox(
        width: 180,
        child: Text(
          maxLines: 2,
          text,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700]),
        ),
      ),
    );
  }

  static SeeAllCategories(
    VoidCallback onPressed,
    BuildContext context,
    String text,
  ) {
    return InkWell(
      onTap: onPressed,
      child: Text(
        text,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade500),
      ),
    );
  }

  static TextSpanTextOriginal(
    BuildContext context,
    String text1,
    String text2,
  ) {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Text.rich(TextSpan(children: [
        TextSpan(
          // text: "₹150 \u00A0",
          text: "₹${text1} \u00A0",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        TextSpan(
            // text: "₹50",
            text: "${text2}",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              decorationColor: Colors.red,
              decorationThickness: 2,
              decoration: TextDecoration.lineThrough,
            )),
      ])),
    );
  }

  static ServicesProvideAddButton(
    VoidCallback onPressed,
    BuildContext context,
    String text,
  ) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5), // Border radius 5
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 20),
          )),
    );
  }

  static IncreaseDecreaseButton(
      VoidCallback onPressed, BuildContext context, IconData icon) {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Icon(
        icon,
        size: 32,
        color: Colors.white,
      ),
    );
  }

  static Widget workername(BuildContext context, String text) {
    return SizedBox(
      width: 80,
      child: Text(text,
          style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 15,
              fontStyle: FontStyle.italic)),
    );
  }

  static Widget serviceType(BuildContext context, String text) {
    return Text(text,
        style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic));
  }

  static BestServiceImage(
    BuildContext context,
    String image,
  ) {
    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    return InkWell(
      child: Container(
        height: 120,
        width: widthScreen * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.fill,
              alignment: Alignment.center),
        ),
      ),
    );
  }
}
