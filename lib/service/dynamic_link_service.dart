import 'package:flutter/material.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:share_plus/share_plus.dart';

class DynamicLinkService {
  static Future<Uri> createDynamicLink({
    required String title,
    required String description,
    required String imageUrl,
  }) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      link: Uri.parse('https://prolifeservice.page.link/prolife'),
      uriPrefix: 'https://prolifeservice.page.link',
      androidParameters: const AndroidParameters(
        packageName: 'com.edugaon.prolife.service',
        minimumVersion: 1,
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: title,
        description: description,
        imageUrl: Uri.parse(imageUrl),
      ),
    );

    final ShortDynamicLink shortDynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    return shortDynamicLink.shortUrl;
  }

  static Future<void> shareApp(BuildContext context) async {
    Uri dynamicUrl = await DynamicLinkService.createDynamicLink(
        title: "ProLife Service App",
        description: "Book best services easily with ProLife!",
        imageUrl:
            "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/cleaning-service-logo-blue-and-yellow-color-design-template-747de328443db9ed130dd9d53e038506_screen.jpg?ts=1695607248");

    Share.share(dynamicUrl.toString());
  }
}
