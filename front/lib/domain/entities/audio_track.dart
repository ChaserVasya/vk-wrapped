class AudioTrack {
  final String id;
  final String title;
  final String artist;
  final String url;
  final int duration;
  final String? albumCover;
  final DateTime? lastPlayed;
  final int playCount;

  const AudioTrack({
    required this.id,
    required this.title,
    required this.artist,
    required this.url,
    required this.duration,
    this.albumCover,
    this.lastPlayed,
    this.playCount = 0,
  });

  factory AudioTrack.fromJson(Map<String, dynamic> json) {
    return AudioTrack(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      artist: json['artist'] ?? '',
      url: json['url'] ?? '',
      duration: json['duration'] ?? 0,
      albumCover: json['album_thumb']?['photo_300'],
      playCount: json['play_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'url': url,
      'duration': duration,
      'albumCover': albumCover,
      'lastPlayed': lastPlayed?.toIso8601String(),
      'playCount': playCount,
    };
  }

  AudioTrack copyWith({
    String? id,
    String? title,
    String? artist,
    String? url,
    int? duration,
    String? albumCover,
    DateTime? lastPlayed,
    int? playCount,
  }) {
    return AudioTrack(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      url: url ?? this.url,
      duration: duration ?? this.duration,
      albumCover: albumCover ?? this.albumCover,
      lastPlayed: lastPlayed ?? this.lastPlayed,
      playCount: playCount ?? this.playCount,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AudioTrack && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'AudioTrack(id: $id, title: $title, artist: $artist)';
  }
}
