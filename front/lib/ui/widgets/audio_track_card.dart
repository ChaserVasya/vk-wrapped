import 'package:flutter/material.dart';

class AudioTrackCard extends StatelessWidget {
  const AudioTrackCard({
    super.key,
    required this.title,
    required this.artist,
    this.albumCover,
    this.duration,
    this.playCount,
  });

  final String title;
  final String artist;
  final String? albumCover;
  final int? duration;
  final int? playCount;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: albumCover != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  albumCover!,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.music_note),
                    );
                  },
                ),
              )
            : Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.music_note),
              ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(artist, maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: playCount != null
            ? Text(
                '$playCount',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              )
            : null,
      ),
    );
  }
}
