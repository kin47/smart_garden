import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

bool checkPathMatch({
  required String pathPattern,
  required String urlPath,
}) {
  final pathSplit = pathPattern.split('/');
  final urlPathSplit = urlPath.split('/');

  if (pathSplit.length != urlPathSplit.length) {
    return false;
  }

  for (int i = 0; i < pathSplit.length; i++) {
    final pathItem = pathSplit[i];
    final urlPathItem = urlPathSplit[i];

    if (pathItem != urlPathItem) {
      if (!pathItem.startsWith('{') || !pathItem.endsWith('}')) {
        return false;
      }
    }
  }
  return true;
}

String _addScheme(String url) {
  if (url.contains("http") || url.contains("https")) {
    return url;
  } else {
    return "https://$url";
  }
}

Future<void> launchLink(String url) async {
  final canLaunch = await canLaunchUrl(Uri.parse(_addScheme(url)));
  canLaunch
      ? await launchUrl(
          Uri.parse(_addScheme(url)),
          mode: LaunchMode.externalApplication,
        )
      : debugPrint("Can't launch url");
}
