import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../index.dart';

///Use for Network Image
class CachedImageWidget extends StatelessWidget {
  final String url;
  const CachedImageWidget({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      fit: BoxFit.cover,
      memCacheHeight: Config.memCacheHeight,
      memCacheWidth: Config.memCacheWidth,
      placeholder: (context, url) => const CupertinoActivityIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}

CachedNetworkImageProvider cachedNetworkImageProvider(url) =>
    CachedNetworkImageProvider(
      url,
    );
