import 'package:flutter/material.dart';

class CashedImageWidget extends StatelessWidget {
  final String image;
  final BoxFit? fit;

  const CashedImageWidget({
    super.key,
    required this.image,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      fadeInDuration: const Duration(milliseconds: 500),
      fadeOutDuration: const Duration(milliseconds: 500),
      fit: (fit != null) ? fit : BoxFit.cover,
      placeholder: const AssetImage(
        'assets/logo.png',
      ),
      imageErrorBuilder: (context, error, stackTrace) => Image.asset(
        fit: (fit != null) ? fit : BoxFit.cover,
        'assets/logo.png',
      ),
      image: NetworkImage(
        image,
      ),
    );
  }
}
