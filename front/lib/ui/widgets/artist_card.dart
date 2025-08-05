import 'package:flutter/material.dart';
import 'package:front/data/remote/api/vk_api_client.dart';
import 'package:front/ui/widgets/thumb_image.dart';
import 'package:gap/gap.dart';

class ArtistCard extends StatelessWidget {
  final VkArtist artist;
  final int? playCount;

  const ArtistCard({super.key, required this.artist, this.playCount});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildArtistAvatar(),
            const Gap(8),
            Text(
              artist.name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (playCount != null) ...[
              const Gap(4),
              Text(
                'Песен: $playCount',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildArtistAvatar() {
    return ThumbImage(
      artist: artist,
      width: double.infinity,
      height: 120,
      borderRadius: BorderRadius.circular(8),
    );
  }
}
