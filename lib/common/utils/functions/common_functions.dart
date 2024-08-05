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
