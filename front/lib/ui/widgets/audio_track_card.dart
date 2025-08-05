import 'package:flutter/material.dart';
import 'package:front/data/remote/api/vk_api_client.dart';
import 'package:front/ui/widgets/thumb_image.dart';

class AudioTrackCard extends StatelessWidget {
  const AudioTrackCard({super.key, required this.track, this.playCount});

  final VkAudioTrack track;
  final int? playCount;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: _buildAlbumCover(),
        title: Text(
          track.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          track.artistsNames,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: playCount != null
            ? Text(
                '$playCount прослушиваний',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              )
            : Text(
                _formatDuration(track.duration),
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
      ),
    );
  }

  Widget _buildAlbumCover() {
    return ThumbImage(
      thumb: track.album?.thumb,
      track: track,
      width: 56,
      height: 56,
    );
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
