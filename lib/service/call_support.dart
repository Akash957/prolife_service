import 'package:url_launcher/url_launcher.dart';

void callSupport() async {
  final Uri phoneUri = Uri(scheme: 'tel', path: '+919341460522');
  if (await canLaunchUrl(phoneUri)) {
    await launchUrl(phoneUri);
  } else {
    throw 'Could not launch $phoneUri';
  }
}
