import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../res/app_images.dart';
import '../../res/enum.dart';

class ImageView extends StatelessWidget {
  final String? url;
  final String? placeholder;
  final Color? color;
  final String? semanticsLabel;
  final double? height;
  final double? width;
  final ImageType type;
  final double? scale;
  final BoxFit? fit;
  final File? imageFile;
  final ImageErrorWidgetBuilder? imageErrorBuilder;

  const ImageView.svg(this.url,
      {this.color,
      this.semanticsLabel,
      this.height,
      this.scale,
      this.fit,
      this.width,
      Key? key})
      : type = ImageType.svg,
        placeholder = null,
        imageErrorBuilder = null,
        imageFile = null,
        super(key: key);

  const ImageView.network(this.url,
      {this.color,
      this.semanticsLabel,
      this.height,
      this.scale,
      this.fit,
      this.width,
      this.imageErrorBuilder,
      this.placeholder,
      Key? key})
      : type = ImageType.network,
        imageFile = null,
        super(key: key);

  const ImageView.asset(this.url,
      {this.color,
      this.semanticsLabel,
      this.height,
      this.scale,
      this.fit,
      this.width,
      Key? key})
      : type = ImageType.asset,
        placeholder = null,
        imageErrorBuilder = null,
        imageFile = null,
        super(key: key);

  const ImageView.file(this.imageFile,
      {this.color,
      this.semanticsLabel,
      this.height,
      this.scale = 1,
      this.fit,
      this.width,
      Key? key})
      : type = ImageType.file,
        placeholder = null,
        imageErrorBuilder = null,
        url = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (type == ImageType.svg) {
      return SvgPicture.asset(
        url!,
        color: color,
        semanticsLabel: semanticsLabel,
        height: height,
        width: width,
        fit: fit ?? BoxFit.contain,
      );
    } else if (type == ImageType.network) {
      return FadeInImage.assetNetwork(
        placeholderScale: scale,
        fit: fit,
        height: height,
        width: width,
        fadeInDuration: const Duration(seconds: 1),
        fadeInCurve: Curves.easeInCirc,
        placeholder: placeholder ?? AppImages.icon,
        image: url!,
        imageErrorBuilder: imageErrorBuilder ??
            (context, error, stackTrace) => Container(
                  height: height,
                  width: width,
                  color: Theme.of(context).shadowColor,
                ),
      );
    } else if (type == ImageType.asset) {
      return Image.asset(
        url!,
        height: height,
        width: width,
        color: color,
        fit: fit,
        scale: scale,
        semanticLabel: semanticsLabel,
      );
    } else if (type == ImageType.file) {
      return Image.file(
        imageFile!,
        height: height,
        width: width,
        color: color,
        fit: fit,
        scale: scale!,
        semanticLabel: semanticsLabel,
      );
    }

    return const SizedBox.shrink();
  }
}
