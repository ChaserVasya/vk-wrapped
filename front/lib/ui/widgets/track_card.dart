import 'package:flutter/material.dart';
import 'package:front/data/remote/api/vk_api_client.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class TrackCard extends StatelessWidget {
  final VkAudioTrack track;
  final int index;

  const TrackCard({super.key, required this.track, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildAlbumCover(),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        track.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Gap(4),
                      Text(
                        track.artist,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const Gap(8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _formatDuration(track.duration),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
            const Gap(12),
            TrackTechnicalInfo(track: track),
            const Gap(8),
            TrackUrlSection(url: track.url),
          ],
        ),
      ),
    );
  }

  Widget _buildAlbumCover() {
    // Пытаемся получить обложку из thumb альбома
    final thumbUrl = _getBestThumbUrl();

    if (thumbUrl != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          thumbUrl,
          width: 56,
          height: 56,
          fit: BoxFit.cover,
          errorBuilder: (context, error, st) {
            return _buildFallbackCover();
          },
        ),
      );
    }

    return _buildFallbackCover();
  }

  Widget _buildFallbackCover() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: _getContentIcon(),
    );
  }

  Widget _getContentIcon() {
    // Определяем тип контента на основе наличия альбома
    if (track.album != null) {
      // Если есть альбом - показываем иконку диска
      return Icon(Icons.album, size: 24, color: Colors.blue[700]);
    } else {
      // Если нет альбома - показываем иконку ноты (отдельная песня)
      return Icon(Icons.music_note, size: 24, color: Colors.blue[700]);
    }
  }

  String? _getBestThumbUrl() {
    if (track.album?.thumb == null) return null;

    final thumb = track.album!.thumb!;

    // Приоритет размеров: photo300 > photo135 > photo600 > photo34
    return thumb.photo300 ?? thumb.photo135 ?? thumb.photo600 ?? thumb.photo34;
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}

class TrackTechnicalInfo extends StatelessWidget {
  final VkAudioTrack track;

  const TrackTechnicalInfo({super.key, required this.track});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.music_note, size: 16, color: Colors.grey[600]),
            const Gap(4),
            Text(
              'ID: ${track.id}',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            const Spacer(),
            Icon(Icons.person_outline, size: 16, color: Colors.grey[600]),
            const Gap(4),
            Text(
              'Owner: ${track.ownerId}',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        const Gap(4),
        Row(
          children: [
            Icon(Icons.link, size: 16, color: Colors.grey[600]),
            const Gap(4),
            Expanded(
              child: Text(
                'Full ID: ${track.fullId}',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (track.dateDateTime != null) ...[
              const Gap(8),
              Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
              const Gap(4),
              Text(
                _formatDate(track.dateDateTime!),
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ],
        ),
        if (track.genreId != null || track.lyricsId != null) ...[
          const Gap(4),
          Row(
            children: [
              if (track.genreId != null) ...[
                Icon(Icons.category, size: 16, color: Colors.grey[600]),
                const Gap(4),
                Text(
                  'Genre: ${track.genreId}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
              if (track.lyricsId != null) ...[
                const Spacer(),
                Icon(Icons.text_snippet, size: 16, color: Colors.grey[600]),
                const Gap(4),
                Text(
                  'Lyrics: ${track.lyricsId}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ],
          ),
        ],
      ],
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd.MM.yyyy').format(date);
  }
}

class TrackUrlSection extends StatelessWidget {
  final String url;

  const TrackUrlSection({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Row(
        children: [
          Icon(Icons.play_circle_outline, size: 16, color: Colors.blue[600]),
          const Gap(4),
          Expanded(
            child: Text(
              url,
              style: TextStyle(
                fontSize: 12,
                color: Colors.blue[600],
                decoration: TextDecoration.underline,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
