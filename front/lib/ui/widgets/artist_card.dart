import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ArtistCard extends StatelessWidget {
  final String artist;
  final int? playCount;

  const ArtistCard({super.key, required this.artist, this.playCount});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          // TODO: Добавить навигацию к трекам артиста
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Артист: $artist')));
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildArtistAvatar(),
              const Gap(8),
              Text(
                artist,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
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
      ),
    );
  }

  Widget _buildArtistAvatar() {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Icon(Icons.person, size: 48, color: Colors.grey),
      ),
    );
  }
}
