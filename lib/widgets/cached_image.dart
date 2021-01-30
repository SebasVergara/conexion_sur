import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String url;
  final double height;
  final double width;
  BoxFit fit;
  Alignment align;

  CachedImage(this.url, {this.height, this.width, this.fit, this.align});

  @override
  Widget build(BuildContext context) {
    if (fit == null) {
      fit = BoxFit.cover;
    }
    if (align == null) {
      align = Alignment.center;
    }
    return CachedNetworkImage(
      imageUrl: url.isNotEmpty ? url : '',
      width: width,
      height: height,
      fit: fit,
      alignment: align,
      placeholder: (_, __) => Image.asset(
        'assets/images/placeholder.jpg',
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
      errorWidget: (context, url, error) => Image.asset(
        'assets/images/placeholder.jpg',
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}