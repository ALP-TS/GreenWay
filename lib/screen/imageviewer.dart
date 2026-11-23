import 'package:flutter/material.dart';
import 'package:greenway/widgets/app_widgets.dart';

class imgviewer extends StatelessWidget {
  final String imgurl;

  const imgviewer({super.key, required this.imgurl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Image'),
      ),
      body: InteractiveViewer(
        minScale: 1,
        maxScale: 5,
        child: Center(
          child: Image.network(
            imgurl,
            fit: BoxFit.contain,
            loadingBuilder: (context, child, progress) => progress == null
                ? child
                : const CircularProgressIndicator(color: Colors.white),
            errorBuilder: (_, _, _) => const Padding(
              padding: EdgeInsets.all(24),
              child: EmptyView(
                compact: true,
                icon: Icons.broken_image_outlined,
                color: Colors.white70,
                title: 'Image unavailable',
                message: 'This image couldn\'t be loaded.',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
