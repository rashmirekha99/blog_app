import 'package:cached_network_image/cached_network_image.dart';

Future<void> clearCache(String imageUrl) async {
  await CachedNetworkImage.evictFromCache(imageUrl, cacheKey: imageUrl);
}
