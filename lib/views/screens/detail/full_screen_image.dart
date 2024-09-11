import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ShowFullScreenImage extends StatelessWidget {
  const ShowFullScreenImage({super.key, required this.imgUrl});
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: InteractiveViewer(
          panEnabled: true, // Allow panning
          minScale: 1.0, // Minimum zoom scale
          maxScale: 4.0, // Maximum zoom scale
          child: CachedNetworkImage(
            imageUrl: imgUrl,
            fit: BoxFit.contain, // Maintain aspect ratio
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
