import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CachedImageFrameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cached Network Image Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ImageScreen(),
    );
  }
}

class ImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Screen'),
      ),
      body: Center(
        child: CachedNetworkImage(
          imageUrl: 'https://via.placeholder.com/600x400.png?text=Large+Image',
          placeholder: (context, url) =>
              Container(
                width: double.infinity,
                height: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: 'https://via.placeholder.com/150.png?text=Thumbnail',
                  fit: BoxFit.cover,
                ),
              ),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}