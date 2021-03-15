import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_app/bloc/constant/data.dart';

import 'loading_indicator.dart';

enum ImageType { Network, Asset, File }

Widget showImage({
  required String imgUrl,
  required ImageType imgType,
  double? height,
  double? width,
  BoxFit fit = BoxFit.contain,
  Color fallbackBackgroundColor = const Color(0xffdbdbdb),
  String errorAsset = kPlaceholderImg,
  Widget? placeholder,
}) {
  if (imgType == ImageType.Network)
    return CachedNetworkImage(
      height: height,
      width: width,
      placeholder: (context, url) => placeholder ?? loading(),
      errorWidget: (context, url, error) => Material(
        child: Container(
          decoration: BoxDecoration(
            color: fallbackBackgroundColor,
          ),
          child: Image.asset(
            errorAsset,
            fit: fit,
          ),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
        clipBehavior: Clip.hardEdge,
      ),
      imageUrl: imgUrl,
      fit: fit,
      fadeInCurve: Curves.easeIn,
      useOldImageOnUrlChange: false,
    );
  else if (imgType == ImageType.Asset) {
    return Image.asset(
      imgUrl,
      height: height,
      width: width,
      fit: fit,
    );
  } else
    return loading();
}
