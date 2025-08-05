import 'package:flutter/material.dart';
import 'package:front/data/remote/api/vk_api_client.dart';

class ThumbImage extends StatelessWidget {
  final VkThumb? thumb;
  final double width;
  final double height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? fallback;

  const ThumbImage({
    super.key,
    required this.thumb,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    final thumbUrl = _getBestThumbUrl();

    if (thumbUrl != null) {
      return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        child: Image.network(
          thumbUrl,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, st) {
            return _buildFallback();
          },
        ),
      );
    }

    return _buildFallback();
  }

  Widget _buildFallback() {
    if (fallback != null) {
      return fallback!;
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
      child: const Icon(Icons.image),
    );
  }

  String? _getBestThumbUrl() {
    if (thumb == null) return null;

    // Приоритет размеров: photo300 > photo135 > photo600 > photo34
    return thumb!.photo300 ??
        thumb!.photo135 ??
        thumb!.photo600 ??
        thumb!.photo34;
  }
}
