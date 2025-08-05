import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:front/data/remote/api/vk_api_client.dart';
import 'package:front/ui/widgets/thumb_image.dart';
import 'package:gap/gap.dart';

class AlbumCard extends StatelessWidget {
  final VkAlbum album;
  final int? trackCount;
  final IList<String>? artists;

  const AlbumCard({
    super.key,
    required this.album,
    this.trackCount,
    this.artists,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAlbumCover(),
            const Gap(8),
            Text(
              album.title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (trackCount != null) ...[
              const Gap(4),
              Text(
                'Треков: $trackCount',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
            if (artists != null && artists!.isNotEmpty) ...[
              const Gap(4),
              Text(
                'Авторы: ${artists!.join(', ')}',
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAlbumCover() {
    return ThumbImage(
      thumb: album.thumb,
      width: double.infinity,
      height: 120,
      fallback: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: const AspectRatio(
          aspectRatio: 1,
          child: Center(child: Icon(Icons.album, size: 48, color: Colors.grey)),
        ),
      ),
    );
  }
}
