import 'package:flutter/material.dart';

class GlobalWidget {
  static const String placeholderImage = 'https://via.placeholder.com/150';

  static Widget BookingImage(BuildContext context, String? image) {
    return Row(
      children: [
        const SizedBox(width: 20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              (image != null && image.isNotEmpty) ? image : placeholderImage,
              height: 120,
              width: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.broken_image, size: 120),
            ),
          ),
        ),
      ],
    );
  }

  static Widget AllCategoryImage(BuildContext context, String text1, String text2,
      String? image, VoidCallback onPressed) {
    var widthScreen = MediaQuery.of(context).size.width * 2;
    var heightScreen = MediaQuery.of(context).size.height * 1;
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.grey.shade400),
          ),
          child: Row(
            children: [
              const SizedBox(width: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  (image != null && image.isNotEmpty) ? image : placeholderImage,
                  height: heightScreen * 0.1,
                  width: widthScreen * 0.1,
                  fit: BoxFit.fitWidth,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(text1, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Text(text2,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.grey.shade500)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget BestServicesImage1(BuildContext context, String? image) {
    var widthScreen = MediaQuery.of(context).size.width * 0.7;
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
              image: NetworkImage((image != null && image.isNotEmpty) ? image : placeholderImage),
              fit: BoxFit.cover,
              onError: (_, __) {},
            ),
          ),
        ),
      ),
    );
  }

  static Widget ReferImage(BuildContext context, String? image) {
    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height * 0.2;
    return InkWell(
      child: Container(
        height: heightScreen,
        width: widthScreen,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage((image != null && image.isNotEmpty) ? image : placeholderImage),
            fit: BoxFit.fill,
            alignment: Alignment.center,
            onError: (_, __) {},
          ),
        ),
      ),
    );
  }

  static Widget ServiceDateilImage(BuildContext context, String? image) {
    var widthScreen = MediaQuery.of(context).size.width;
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
              image: NetworkImage((image != null && image.isNotEmpty) ? image : placeholderImage),
              fit: BoxFit.cover,
              onError: (_, __) {},
            ),
          ),
        ),
      ),
    );
  }

  static Widget BestServicesCircleAvatar(BuildContext context, String? image) {
    return _circleImage(60, image);
  }

  static Widget BestServicesCircleAvatar2(BuildContext context, String? image) {
    return _circleImage(40, image);
  }

  static Widget BestServicesProfile(BuildContext context, String? image) {
    return _circleImage(45, image);
  }

  static Widget _circleImage(double size, String? image) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            image: DecorationImage(
              image: NetworkImage((image != null && image.isNotEmpty) ? image : placeholderImage),
              fit: BoxFit.fill,
              alignment: Alignment.center,
              onError: (_, __) {},
            ),
          ),
        ),
      ),
    );
  }

  static Widget WorkNameText(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        text,
        maxLines: 3,
        softWrap: true,
        overflow: TextOverflow.visible,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  static Widget SeeAllCategories(
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

  static Widget TextSpanTextOriginal(
      BuildContext context, String text1, String text2) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text.rich(TextSpan(children: [
        TextSpan(
          text: "₹${text1} \u00A0",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        TextSpan(
            text: text2,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
              decorationColor: Colors.red,
              decorationThickness: 2,
            )),
      ])),
    );
  }

  static Widget ServicesProvideAddButton(
      VoidCallback onPressed, BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  static Widget IncreaseDecreaseButton(
      VoidCallback onPressed, BuildContext context, IconData icon) {
    return InkWell(
      onTap: onPressed,
      child: Container(
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
      ),
    );
  }

  static Widget workername(BuildContext context, String text) {
    return SizedBox(
      width: 80,
      child: Text(
        text,
        style: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: 15,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  static Widget serviceType(BuildContext context, String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
    );
  }

  static Widget BestServiceImage(BuildContext context, String? image) {
    var widthScreen = MediaQuery.of(context).size.width;
    return InkWell(
      child: Container(
        height: 120,
        width: widthScreen * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage((image != null && image.isNotEmpty) ? image : placeholderImage),
            fit: BoxFit.fill,
            alignment: Alignment.center,
            onError: (_, __) {},
          ),
        ),
      ),
    );
  }
}
