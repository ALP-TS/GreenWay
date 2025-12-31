import 'package:flutter/material.dart';

class imgviewer extends StatelessWidget {
  final String imgurl;

  imgviewer({required this.imgurl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('IMg viewer'),
        ),
        body: Container(
          child: Image.network(imgurl),
          width: double.infinity,
          height: double.infinity,
        ));
  }
}
