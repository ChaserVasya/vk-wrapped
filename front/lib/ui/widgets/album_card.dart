import 'package:flutter/material.dart';
import 'package:front/data/remote/api/vk_api_client.dart';
import 'package:front/ui/widgets/thumb_image.dart';
import 'package:gap/gap.dart';

class AlbumCard extends StatelessWidget {
  final VkAlbum album;
  final VoidCallback? onTap;

  const AlbumCard({super.key, required this.album, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAlbumCover(),
              const Gap(8),
              Text(
                album.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Gap(4),
              Text(
                'ID: ${album.id}',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
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
