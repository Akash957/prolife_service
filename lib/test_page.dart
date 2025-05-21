import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo View Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ThumbnailScreen(),
    );
  }
}

class ThumbnailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Click Zoom'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FullScreenImage()),
            );
          },
          child: Image.network(
            'https://thumbs.dreamstime.com/b/ping-cosmos-flawer-beautiful-gardens-93427313.jpg',
            width: 150,
            height: 150,
          ),
        ),
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: PhotoView(
          imageProvider: NetworkImage('https://thumbs.dreamstime.com/b/ping-cosmos-flawer-beautiful-gardens-93427313.jpg'),
          backgroundDecoration: BoxDecoration(color: Colors.black),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2.0,
        ),
      ),
    );
  }
}
