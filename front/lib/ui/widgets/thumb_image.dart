import 'package:flutter/material.dart';
import 'package:front/data/remote/api/vk_api_client.dart';

class ThumbImage extends StatelessWidget {
  final VkThumb? thumb;
  final double width;
  final double height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? fallback;
  final VkAudioTrack? track;
  final VkArtist? artist;

  const ThumbImage({
    super.key,
    this.thumb,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.fallback,
    this.track,
    this.artist,
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
      child: _buildContentIcon(),
    );
  }

  Widget _buildContentIcon() {
    // Вычисляем безопасный размер иконки
    final iconSize = width.isFinite ? width * 0.4 : 24.0;

    // Если есть артист, показываем иконку артиста
    if (artist != null) {
      return Icon(Icons.person, size: iconSize, color: Colors.grey[600]);
    }

    // Если есть трек, определяем тип контента
    if (track != null) {
      return _getContentIcon(iconSize);
    }

    // По умолчанию показываем иконку музыки
    return Icon(Icons.music_note, size: iconSize, color: Colors.grey[600]);
  }

  Widget _getContentIcon(double iconSize) {
    // Определяем тип контента на основе наличия альбома
    if (track!.album != null) {
      // Если есть альбом - показываем иконку диска
      return Icon(Icons.album, size: iconSize, color: Colors.grey[600]);
    } else {
      // Если нет альбома - показываем иконку ноты (отдельная песня)
      return Icon(Icons.music_note, size: iconSize, color: Colors.grey[600]);
    }
  }

  String? _getBestThumbUrl() {
    // Сначала проверяем thumb (для альбомов)
    if (thumb != null) {
      // Приоритет размеров: photo300 > photo135 > photo600 > photo34
      return thumb!.photo300 ??
          thumb!.photo135 ??
          thumb!.photo600 ??
          thumb!.photo34;
    }

    // Затем проверяем фото артиста
    if (artist?.photo != null) {
      return artist!.photo;
    }

    return null;
  }
}
