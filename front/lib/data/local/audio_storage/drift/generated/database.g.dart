// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../database.dart';

// ignore_for_file: type=lint
class $AudioTracksTable extends AudioTracks
    with TableInfo<$AudioTracksTable, AudioTrack> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AudioTracksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<int> ownerId = GeneratedColumn<int>(
    'owner_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _artistMeta = const VerificationMeta('artist');
  @override
  late final GeneratedColumn<String> artist = GeneratedColumn<String>(
    'artist',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMeta = const VerificationMeta(
    'duration',
  );
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
    'duration',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<int> date = GeneratedColumn<int>(
    'date',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _genreIdMeta = const VerificationMeta(
    'genreId',
  );
  @override
  late final GeneratedColumn<int> genreId = GeneratedColumn<int>(
    'genre_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lyricsIdMeta = const VerificationMeta(
    'lyricsId',
  );
  @override
  late final GeneratedColumn<int> lyricsId = GeneratedColumn<int>(
    'lyrics_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ownerId,
    title,
    artist,
    duration,
    url,
    date,
    genreId,
    lyricsId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audio_tracks';
  @override
  VerificationContext validateIntegrity(
    Insertable<AudioTrack> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('artist')) {
      context.handle(
        _artistMeta,
        artist.isAcceptableOrUnknown(data['artist']!, _artistMeta),
      );
    } else if (isInserting) {
      context.missing(_artistMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(
        _durationMeta,
        duration.isAcceptableOrUnknown(data['duration']!, _durationMeta),
      );
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    }
    if (data.containsKey('genre_id')) {
      context.handle(
        _genreIdMeta,
        genreId.isAcceptableOrUnknown(data['genre_id']!, _genreIdMeta),
      );
    }
    if (data.containsKey('lyrics_id')) {
      context.handle(
        _lyricsIdMeta,
        lyricsId.isAcceptableOrUnknown(data['lyrics_id']!, _lyricsIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, ownerId};
  @override
  AudioTrack map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AudioTrack(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}owner_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      artist: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}artist'],
      )!,
      duration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration'],
      )!,
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}date'],
      ),
      genreId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}genre_id'],
      ),
      lyricsId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lyrics_id'],
      ),
    );
  }

  @override
  $AudioTracksTable createAlias(String alias) {
    return $AudioTracksTable(attachedDatabase, alias);
  }
}

class AudioTrack extends DataClass implements Insertable<AudioTrack> {
  final int id;
  final int ownerId;
  final String title;
  final String artist;
  final int duration;
  final String url;
  final int? date;
  final int? genreId;
  final int? lyricsId;
  const AudioTrack({
    required this.id,
    required this.ownerId,
    required this.title,
    required this.artist,
    required this.duration,
    required this.url,
    this.date,
    this.genreId,
    this.lyricsId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['owner_id'] = Variable<int>(ownerId);
    map['title'] = Variable<String>(title);
    map['artist'] = Variable<String>(artist);
    map['duration'] = Variable<int>(duration);
    map['url'] = Variable<String>(url);
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<int>(date);
    }
    if (!nullToAbsent || genreId != null) {
      map['genre_id'] = Variable<int>(genreId);
    }
    if (!nullToAbsent || lyricsId != null) {
      map['lyrics_id'] = Variable<int>(lyricsId);
    }
    return map;
  }

  AudioTracksCompanion toCompanion(bool nullToAbsent) {
    return AudioTracksCompanion(
      id: Value(id),
      ownerId: Value(ownerId),
      title: Value(title),
      artist: Value(artist),
      duration: Value(duration),
      url: Value(url),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      genreId: genreId == null && nullToAbsent
          ? const Value.absent()
          : Value(genreId),
      lyricsId: lyricsId == null && nullToAbsent
          ? const Value.absent()
          : Value(lyricsId),
    );
  }

  factory AudioTrack.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AudioTrack(
      id: serializer.fromJson<int>(json['id']),
      ownerId: serializer.fromJson<int>(json['ownerId']),
      title: serializer.fromJson<String>(json['title']),
      artist: serializer.fromJson<String>(json['artist']),
      duration: serializer.fromJson<int>(json['duration']),
      url: serializer.fromJson<String>(json['url']),
      date: serializer.fromJson<int?>(json['date']),
      genreId: serializer.fromJson<int?>(json['genreId']),
      lyricsId: serializer.fromJson<int?>(json['lyricsId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ownerId': serializer.toJson<int>(ownerId),
      'title': serializer.toJson<String>(title),
      'artist': serializer.toJson<String>(artist),
      'duration': serializer.toJson<int>(duration),
      'url': serializer.toJson<String>(url),
      'date': serializer.toJson<int?>(date),
      'genreId': serializer.toJson<int?>(genreId),
      'lyricsId': serializer.toJson<int?>(lyricsId),
    };
  }

  AudioTrack copyWith({
    int? id,
    int? ownerId,
    String? title,
    String? artist,
    int? duration,
    String? url,
    Value<int?> date = const Value.absent(),
    Value<int?> genreId = const Value.absent(),
    Value<int?> lyricsId = const Value.absent(),
  }) => AudioTrack(
    id: id ?? this.id,
    ownerId: ownerId ?? this.ownerId,
    title: title ?? this.title,
    artist: artist ?? this.artist,
    duration: duration ?? this.duration,
    url: url ?? this.url,
    date: date.present ? date.value : this.date,
    genreId: genreId.present ? genreId.value : this.genreId,
    lyricsId: lyricsId.present ? lyricsId.value : this.lyricsId,
  );
  AudioTrack copyWithCompanion(AudioTracksCompanion data) {
    return AudioTrack(
      id: data.id.present ? data.id.value : this.id,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      title: data.title.present ? data.title.value : this.title,
      artist: data.artist.present ? data.artist.value : this.artist,
      duration: data.duration.present ? data.duration.value : this.duration,
      url: data.url.present ? data.url.value : this.url,
      date: data.date.present ? data.date.value : this.date,
      genreId: data.genreId.present ? data.genreId.value : this.genreId,
      lyricsId: data.lyricsId.present ? data.lyricsId.value : this.lyricsId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AudioTrack(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('duration: $duration, ')
          ..write('url: $url, ')
          ..write('date: $date, ')
          ..write('genreId: $genreId, ')
          ..write('lyricsId: $lyricsId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ownerId,
    title,
    artist,
    duration,
    url,
    date,
    genreId,
    lyricsId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AudioTrack &&
          other.id == this.id &&
          other.ownerId == this.ownerId &&
          other.title == this.title &&
          other.artist == this.artist &&
          other.duration == this.duration &&
          other.url == this.url &&
          other.date == this.date &&
          other.genreId == this.genreId &&
          other.lyricsId == this.lyricsId);
}

class AudioTracksCompanion extends UpdateCompanion<AudioTrack> {
  final Value<int> id;
  final Value<int> ownerId;
  final Value<String> title;
  final Value<String> artist;
  final Value<int> duration;
  final Value<String> url;
  final Value<int?> date;
  final Value<int?> genreId;
  final Value<int?> lyricsId;
  final Value<int> rowid;
  const AudioTracksCompanion({
    this.id = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.title = const Value.absent(),
    this.artist = const Value.absent(),
    this.duration = const Value.absent(),
    this.url = const Value.absent(),
    this.date = const Value.absent(),
    this.genreId = const Value.absent(),
    this.lyricsId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AudioTracksCompanion.insert({
    required int id,
    required int ownerId,
    required String title,
    required String artist,
    required int duration,
    required String url,
    this.date = const Value.absent(),
    this.genreId = const Value.absent(),
    this.lyricsId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ownerId = Value(ownerId),
       title = Value(title),
       artist = Value(artist),
       duration = Value(duration),
       url = Value(url);
  static Insertable<AudioTrack> custom({
    Expression<int>? id,
    Expression<int>? ownerId,
    Expression<String>? title,
    Expression<String>? artist,
    Expression<int>? duration,
    Expression<String>? url,
    Expression<int>? date,
    Expression<int>? genreId,
    Expression<int>? lyricsId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerId != null) 'owner_id': ownerId,
      if (title != null) 'title': title,
      if (artist != null) 'artist': artist,
      if (duration != null) 'duration': duration,
      if (url != null) 'url': url,
      if (date != null) 'date': date,
      if (genreId != null) 'genre_id': genreId,
      if (lyricsId != null) 'lyrics_id': lyricsId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AudioTracksCompanion copyWith({
    Value<int>? id,
    Value<int>? ownerId,
    Value<String>? title,
    Value<String>? artist,
    Value<int>? duration,
    Value<String>? url,
    Value<int?>? date,
    Value<int?>? genreId,
    Value<int?>? lyricsId,
    Value<int>? rowid,
  }) {
    return AudioTracksCompanion(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      duration: duration ?? this.duration,
      url: url ?? this.url,
      date: date ?? this.date,
      genreId: genreId ?? this.genreId,
      lyricsId: lyricsId ?? this.lyricsId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<int>(ownerId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (artist.present) {
      map['artist'] = Variable<String>(artist.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (date.present) {
      map['date'] = Variable<int>(date.value);
    }
    if (genreId.present) {
      map['genre_id'] = Variable<int>(genreId.value);
    }
    if (lyricsId.present) {
      map['lyrics_id'] = Variable<int>(lyricsId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AudioTracksCompanion(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('duration: $duration, ')
          ..write('url: $url, ')
          ..write('date: $date, ')
          ..write('genreId: $genreId, ')
          ..write('lyricsId: $lyricsId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AlbumsTable extends Albums with TableInfo<$AlbumsTable, Album> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlbumsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<int> ownerId = GeneratedColumn<int>(
    'owner_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mainColorMeta = const VerificationMeta(
    'mainColor',
  );
  @override
  late final GeneratedColumn<String> mainColor = GeneratedColumn<String>(
    'main_color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, title, ownerId, mainColor];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'albums';
  @override
  VerificationContext validateIntegrity(
    Insertable<Album> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('main_color')) {
      context.handle(
        _mainColorMeta,
        mainColor.isAcceptableOrUnknown(data['main_color']!, _mainColorMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, ownerId};
  @override
  Album map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Album(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}owner_id'],
      )!,
      mainColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}main_color'],
      ),
    );
  }

  @override
  $AlbumsTable createAlias(String alias) {
    return $AlbumsTable(attachedDatabase, alias);
  }
}

class Album extends DataClass implements Insertable<Album> {
  final int id;
  final String title;
  final int ownerId;
  final String? mainColor;
  const Album({
    required this.id,
    required this.title,
    required this.ownerId,
    this.mainColor,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['owner_id'] = Variable<int>(ownerId);
    if (!nullToAbsent || mainColor != null) {
      map['main_color'] = Variable<String>(mainColor);
    }
    return map;
  }

  AlbumsCompanion toCompanion(bool nullToAbsent) {
    return AlbumsCompanion(
      id: Value(id),
      title: Value(title),
      ownerId: Value(ownerId),
      mainColor: mainColor == null && nullToAbsent
          ? const Value.absent()
          : Value(mainColor),
    );
  }

  factory Album.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Album(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      ownerId: serializer.fromJson<int>(json['ownerId']),
      mainColor: serializer.fromJson<String?>(json['mainColor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'ownerId': serializer.toJson<int>(ownerId),
      'mainColor': serializer.toJson<String?>(mainColor),
    };
  }

  Album copyWith({
    int? id,
    String? title,
    int? ownerId,
    Value<String?> mainColor = const Value.absent(),
  }) => Album(
    id: id ?? this.id,
    title: title ?? this.title,
    ownerId: ownerId ?? this.ownerId,
    mainColor: mainColor.present ? mainColor.value : this.mainColor,
  );
  Album copyWithCompanion(AlbumsCompanion data) {
    return Album(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      mainColor: data.mainColor.present ? data.mainColor.value : this.mainColor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Album(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('ownerId: $ownerId, ')
          ..write('mainColor: $mainColor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, ownerId, mainColor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Album &&
          other.id == this.id &&
          other.title == this.title &&
          other.ownerId == this.ownerId &&
          other.mainColor == this.mainColor);
}

class AlbumsCompanion extends UpdateCompanion<Album> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> ownerId;
  final Value<String?> mainColor;
  final Value<int> rowid;
  const AlbumsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.mainColor = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AlbumsCompanion.insert({
    required int id,
    required String title,
    required int ownerId,
    this.mainColor = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       ownerId = Value(ownerId);
  static Insertable<Album> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? ownerId,
    Expression<String>? mainColor,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (ownerId != null) 'owner_id': ownerId,
      if (mainColor != null) 'main_color': mainColor,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AlbumsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<int>? ownerId,
    Value<String?>? mainColor,
    Value<int>? rowid,
  }) {
    return AlbumsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      ownerId: ownerId ?? this.ownerId,
      mainColor: mainColor ?? this.mainColor,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<int>(ownerId.value);
    }
    if (mainColor.present) {
      map['main_color'] = Variable<String>(mainColor.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlbumsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('ownerId: $ownerId, ')
          ..write('mainColor: $mainColor, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ThumbsTable extends Thumbs with TableInfo<$ThumbsTable, Thumb> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ThumbsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<int> width = GeneratedColumn<int>(
    'width',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<int> height = GeneratedColumn<int>(
    'height',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _thumbIdMeta = const VerificationMeta(
    'thumbId',
  );
  @override
  late final GeneratedColumn<String> thumbId = GeneratedColumn<String>(
    'thumb_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _photo34Meta = const VerificationMeta(
    'photo34',
  );
  @override
  late final GeneratedColumn<String> photo34 = GeneratedColumn<String>(
    'photo34',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photo135Meta = const VerificationMeta(
    'photo135',
  );
  @override
  late final GeneratedColumn<String> photo135 = GeneratedColumn<String>(
    'photo135',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photo300Meta = const VerificationMeta(
    'photo300',
  );
  @override
  late final GeneratedColumn<String> photo300 = GeneratedColumn<String>(
    'photo300',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photo600Meta = const VerificationMeta(
    'photo600',
  );
  @override
  late final GeneratedColumn<String> photo600 = GeneratedColumn<String>(
    'photo600',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    width,
    height,
    thumbId,
    photo34,
    photo135,
    photo300,
    photo600,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'thumbs';
  @override
  VerificationContext validateIntegrity(
    Insertable<Thumb> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('width')) {
      context.handle(
        _widthMeta,
        width.isAcceptableOrUnknown(data['width']!, _widthMeta),
      );
    } else if (isInserting) {
      context.missing(_widthMeta);
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    } else if (isInserting) {
      context.missing(_heightMeta);
    }
    if (data.containsKey('thumb_id')) {
      context.handle(
        _thumbIdMeta,
        thumbId.isAcceptableOrUnknown(data['thumb_id']!, _thumbIdMeta),
      );
    } else if (isInserting) {
      context.missing(_thumbIdMeta);
    }
    if (data.containsKey('photo34')) {
      context.handle(
        _photo34Meta,
        photo34.isAcceptableOrUnknown(data['photo34']!, _photo34Meta),
      );
    }
    if (data.containsKey('photo135')) {
      context.handle(
        _photo135Meta,
        photo135.isAcceptableOrUnknown(data['photo135']!, _photo135Meta),
      );
    }
    if (data.containsKey('photo300')) {
      context.handle(
        _photo300Meta,
        photo300.isAcceptableOrUnknown(data['photo300']!, _photo300Meta),
      );
    }
    if (data.containsKey('photo600')) {
      context.handle(
        _photo600Meta,
        photo600.isAcceptableOrUnknown(data['photo600']!, _photo600Meta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Thumb map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Thumb(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      width: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}width'],
      )!,
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}height'],
      )!,
      thumbId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thumb_id'],
      )!,
      photo34: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo34'],
      ),
      photo135: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo135'],
      ),
      photo300: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo300'],
      ),
      photo600: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo600'],
      ),
    );
  }

  @override
  $ThumbsTable createAlias(String alias) {
    return $ThumbsTable(attachedDatabase, alias);
  }
}

class Thumb extends DataClass implements Insertable<Thumb> {
  final int id;
  final int width;
  final int height;
  final String thumbId;
  final String? photo34;
  final String? photo135;
  final String? photo300;
  final String? photo600;
  const Thumb({
    required this.id,
    required this.width,
    required this.height,
    required this.thumbId,
    this.photo34,
    this.photo135,
    this.photo300,
    this.photo600,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['width'] = Variable<int>(width);
    map['height'] = Variable<int>(height);
    map['thumb_id'] = Variable<String>(thumbId);
    if (!nullToAbsent || photo34 != null) {
      map['photo34'] = Variable<String>(photo34);
    }
    if (!nullToAbsent || photo135 != null) {
      map['photo135'] = Variable<String>(photo135);
    }
    if (!nullToAbsent || photo300 != null) {
      map['photo300'] = Variable<String>(photo300);
    }
    if (!nullToAbsent || photo600 != null) {
      map['photo600'] = Variable<String>(photo600);
    }
    return map;
  }

  ThumbsCompanion toCompanion(bool nullToAbsent) {
    return ThumbsCompanion(
      id: Value(id),
      width: Value(width),
      height: Value(height),
      thumbId: Value(thumbId),
      photo34: photo34 == null && nullToAbsent
          ? const Value.absent()
          : Value(photo34),
      photo135: photo135 == null && nullToAbsent
          ? const Value.absent()
          : Value(photo135),
      photo300: photo300 == null && nullToAbsent
          ? const Value.absent()
          : Value(photo300),
      photo600: photo600 == null && nullToAbsent
          ? const Value.absent()
          : Value(photo600),
    );
  }

  factory Thumb.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Thumb(
      id: serializer.fromJson<int>(json['id']),
      width: serializer.fromJson<int>(json['width']),
      height: serializer.fromJson<int>(json['height']),
      thumbId: serializer.fromJson<String>(json['thumbId']),
      photo34: serializer.fromJson<String?>(json['photo34']),
      photo135: serializer.fromJson<String?>(json['photo135']),
      photo300: serializer.fromJson<String?>(json['photo300']),
      photo600: serializer.fromJson<String?>(json['photo600']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'width': serializer.toJson<int>(width),
      'height': serializer.toJson<int>(height),
      'thumbId': serializer.toJson<String>(thumbId),
      'photo34': serializer.toJson<String?>(photo34),
      'photo135': serializer.toJson<String?>(photo135),
      'photo300': serializer.toJson<String?>(photo300),
      'photo600': serializer.toJson<String?>(photo600),
    };
  }

  Thumb copyWith({
    int? id,
    int? width,
    int? height,
    String? thumbId,
    Value<String?> photo34 = const Value.absent(),
    Value<String?> photo135 = const Value.absent(),
    Value<String?> photo300 = const Value.absent(),
    Value<String?> photo600 = const Value.absent(),
  }) => Thumb(
    id: id ?? this.id,
    width: width ?? this.width,
    height: height ?? this.height,
    thumbId: thumbId ?? this.thumbId,
    photo34: photo34.present ? photo34.value : this.photo34,
    photo135: photo135.present ? photo135.value : this.photo135,
    photo300: photo300.present ? photo300.value : this.photo300,
    photo600: photo600.present ? photo600.value : this.photo600,
  );
  Thumb copyWithCompanion(ThumbsCompanion data) {
    return Thumb(
      id: data.id.present ? data.id.value : this.id,
      width: data.width.present ? data.width.value : this.width,
      height: data.height.present ? data.height.value : this.height,
      thumbId: data.thumbId.present ? data.thumbId.value : this.thumbId,
      photo34: data.photo34.present ? data.photo34.value : this.photo34,
      photo135: data.photo135.present ? data.photo135.value : this.photo135,
      photo300: data.photo300.present ? data.photo300.value : this.photo300,
      photo600: data.photo600.present ? data.photo600.value : this.photo600,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Thumb(')
          ..write('id: $id, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('thumbId: $thumbId, ')
          ..write('photo34: $photo34, ')
          ..write('photo135: $photo135, ')
          ..write('photo300: $photo300, ')
          ..write('photo600: $photo600')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    width,
    height,
    thumbId,
    photo34,
    photo135,
    photo300,
    photo600,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Thumb &&
          other.id == this.id &&
          other.width == this.width &&
          other.height == this.height &&
          other.thumbId == this.thumbId &&
          other.photo34 == this.photo34 &&
          other.photo135 == this.photo135 &&
          other.photo300 == this.photo300 &&
          other.photo600 == this.photo600);
}

class ThumbsCompanion extends UpdateCompanion<Thumb> {
  final Value<int> id;
  final Value<int> width;
  final Value<int> height;
  final Value<String> thumbId;
  final Value<String?> photo34;
  final Value<String?> photo135;
  final Value<String?> photo300;
  final Value<String?> photo600;
  const ThumbsCompanion({
    this.id = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.thumbId = const Value.absent(),
    this.photo34 = const Value.absent(),
    this.photo135 = const Value.absent(),
    this.photo300 = const Value.absent(),
    this.photo600 = const Value.absent(),
  });
  ThumbsCompanion.insert({
    this.id = const Value.absent(),
    required int width,
    required int height,
    required String thumbId,
    this.photo34 = const Value.absent(),
    this.photo135 = const Value.absent(),
    this.photo300 = const Value.absent(),
    this.photo600 = const Value.absent(),
  }) : width = Value(width),
       height = Value(height),
       thumbId = Value(thumbId);
  static Insertable<Thumb> custom({
    Expression<int>? id,
    Expression<int>? width,
    Expression<int>? height,
    Expression<String>? thumbId,
    Expression<String>? photo34,
    Expression<String>? photo135,
    Expression<String>? photo300,
    Expression<String>? photo600,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (thumbId != null) 'thumb_id': thumbId,
      if (photo34 != null) 'photo34': photo34,
      if (photo135 != null) 'photo135': photo135,
      if (photo300 != null) 'photo300': photo300,
      if (photo600 != null) 'photo600': photo600,
    });
  }

  ThumbsCompanion copyWith({
    Value<int>? id,
    Value<int>? width,
    Value<int>? height,
    Value<String>? thumbId,
    Value<String?>? photo34,
    Value<String?>? photo135,
    Value<String?>? photo300,
    Value<String?>? photo600,
  }) {
    return ThumbsCompanion(
      id: id ?? this.id,
      width: width ?? this.width,
      height: height ?? this.height,
      thumbId: thumbId ?? this.thumbId,
      photo34: photo34 ?? this.photo34,
      photo135: photo135 ?? this.photo135,
      photo300: photo300 ?? this.photo300,
      photo600: photo600 ?? this.photo600,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (width.present) {
      map['width'] = Variable<int>(width.value);
    }
    if (height.present) {
      map['height'] = Variable<int>(height.value);
    }
    if (thumbId.present) {
      map['thumb_id'] = Variable<String>(thumbId.value);
    }
    if (photo34.present) {
      map['photo34'] = Variable<String>(photo34.value);
    }
    if (photo135.present) {
      map['photo135'] = Variable<String>(photo135.value);
    }
    if (photo300.present) {
      map['photo300'] = Variable<String>(photo300.value);
    }
    if (photo600.present) {
      map['photo600'] = Variable<String>(photo600.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ThumbsCompanion(')
          ..write('id: $id, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('thumbId: $thumbId, ')
          ..write('photo34: $photo34, ')
          ..write('photo135: $photo135, ')
          ..write('photo300: $photo300, ')
          ..write('photo600: $photo600')
          ..write(')'))
        .toString();
  }
}

class $MainArtistsTable extends MainArtists
    with TableInfo<$MainArtistsTable, MainArtist> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MainArtistsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _domainMeta = const VerificationMeta('domain');
  @override
  late final GeneratedColumn<String> domain = GeneratedColumn<String>(
    'domain',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _artistIdMeta = const VerificationMeta(
    'artistId',
  );
  @override
  late final GeneratedColumn<String> artistId = GeneratedColumn<String>(
    'artist_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _trackIdMeta = const VerificationMeta(
    'trackId',
  );
  @override
  late final GeneratedColumn<int> trackId = GeneratedColumn<int>(
    'track_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _trackOwnerIdMeta = const VerificationMeta(
    'trackOwnerId',
  );
  @override
  late final GeneratedColumn<int> trackOwnerId = GeneratedColumn<int>(
    'track_owner_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    domain,
    artistId,
    trackId,
    trackOwnerId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'main_artists';
  @override
  VerificationContext validateIntegrity(
    Insertable<MainArtist> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('domain')) {
      context.handle(
        _domainMeta,
        domain.isAcceptableOrUnknown(data['domain']!, _domainMeta),
      );
    }
    if (data.containsKey('artist_id')) {
      context.handle(
        _artistIdMeta,
        artistId.isAcceptableOrUnknown(data['artist_id']!, _artistIdMeta),
      );
    } else if (isInserting) {
      context.missing(_artistIdMeta);
    }
    if (data.containsKey('track_id')) {
      context.handle(
        _trackIdMeta,
        trackId.isAcceptableOrUnknown(data['track_id']!, _trackIdMeta),
      );
    } else if (isInserting) {
      context.missing(_trackIdMeta);
    }
    if (data.containsKey('track_owner_id')) {
      context.handle(
        _trackOwnerIdMeta,
        trackOwnerId.isAcceptableOrUnknown(
          data['track_owner_id']!,
          _trackOwnerIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_trackOwnerIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MainArtist map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MainArtist(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      domain: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}domain'],
      ),
      artistId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}artist_id'],
      )!,
      trackId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}track_id'],
      )!,
      trackOwnerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}track_owner_id'],
      )!,
    );
  }

  @override
  $MainArtistsTable createAlias(String alias) {
    return $MainArtistsTable(attachedDatabase, alias);
  }
}

class MainArtist extends DataClass implements Insertable<MainArtist> {
  final int id;
  final String name;
  final String? domain;
  final String artistId;
  final int trackId;
  final int trackOwnerId;
  const MainArtist({
    required this.id,
    required this.name,
    this.domain,
    required this.artistId,
    required this.trackId,
    required this.trackOwnerId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || domain != null) {
      map['domain'] = Variable<String>(domain);
    }
    map['artist_id'] = Variable<String>(artistId);
    map['track_id'] = Variable<int>(trackId);
    map['track_owner_id'] = Variable<int>(trackOwnerId);
    return map;
  }

  MainArtistsCompanion toCompanion(bool nullToAbsent) {
    return MainArtistsCompanion(
      id: Value(id),
      name: Value(name),
      domain: domain == null && nullToAbsent
          ? const Value.absent()
          : Value(domain),
      artistId: Value(artistId),
      trackId: Value(trackId),
      trackOwnerId: Value(trackOwnerId),
    );
  }

  factory MainArtist.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MainArtist(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      domain: serializer.fromJson<String?>(json['domain']),
      artistId: serializer.fromJson<String>(json['artistId']),
      trackId: serializer.fromJson<int>(json['trackId']),
      trackOwnerId: serializer.fromJson<int>(json['trackOwnerId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'domain': serializer.toJson<String?>(domain),
      'artistId': serializer.toJson<String>(artistId),
      'trackId': serializer.toJson<int>(trackId),
      'trackOwnerId': serializer.toJson<int>(trackOwnerId),
    };
  }

  MainArtist copyWith({
    int? id,
    String? name,
    Value<String?> domain = const Value.absent(),
    String? artistId,
    int? trackId,
    int? trackOwnerId,
  }) => MainArtist(
    id: id ?? this.id,
    name: name ?? this.name,
    domain: domain.present ? domain.value : this.domain,
    artistId: artistId ?? this.artistId,
    trackId: trackId ?? this.trackId,
    trackOwnerId: trackOwnerId ?? this.trackOwnerId,
  );
  MainArtist copyWithCompanion(MainArtistsCompanion data) {
    return MainArtist(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      domain: data.domain.present ? data.domain.value : this.domain,
      artistId: data.artistId.present ? data.artistId.value : this.artistId,
      trackId: data.trackId.present ? data.trackId.value : this.trackId,
      trackOwnerId: data.trackOwnerId.present
          ? data.trackOwnerId.value
          : this.trackOwnerId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MainArtist(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('domain: $domain, ')
          ..write('artistId: $artistId, ')
          ..write('trackId: $trackId, ')
          ..write('trackOwnerId: $trackOwnerId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, domain, artistId, trackId, trackOwnerId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MainArtist &&
          other.id == this.id &&
          other.name == this.name &&
          other.domain == this.domain &&
          other.artistId == this.artistId &&
          other.trackId == this.trackId &&
          other.trackOwnerId == this.trackOwnerId);
}

class MainArtistsCompanion extends UpdateCompanion<MainArtist> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> domain;
  final Value<String> artistId;
  final Value<int> trackId;
  final Value<int> trackOwnerId;
  const MainArtistsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.domain = const Value.absent(),
    this.artistId = const Value.absent(),
    this.trackId = const Value.absent(),
    this.trackOwnerId = const Value.absent(),
  });
  MainArtistsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.domain = const Value.absent(),
    required String artistId,
    required int trackId,
    required int trackOwnerId,
  }) : name = Value(name),
       artistId = Value(artistId),
       trackId = Value(trackId),
       trackOwnerId = Value(trackOwnerId);
  static Insertable<MainArtist> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? domain,
    Expression<String>? artistId,
    Expression<int>? trackId,
    Expression<int>? trackOwnerId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (domain != null) 'domain': domain,
      if (artistId != null) 'artist_id': artistId,
      if (trackId != null) 'track_id': trackId,
      if (trackOwnerId != null) 'track_owner_id': trackOwnerId,
    });
  }

  MainArtistsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? domain,
    Value<String>? artistId,
    Value<int>? trackId,
    Value<int>? trackOwnerId,
  }) {
    return MainArtistsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      domain: domain ?? this.domain,
      artistId: artistId ?? this.artistId,
      trackId: trackId ?? this.trackId,
      trackOwnerId: trackOwnerId ?? this.trackOwnerId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (domain.present) {
      map['domain'] = Variable<String>(domain.value);
    }
    if (artistId.present) {
      map['artist_id'] = Variable<String>(artistId.value);
    }
    if (trackId.present) {
      map['track_id'] = Variable<int>(trackId.value);
    }
    if (trackOwnerId.present) {
      map['track_owner_id'] = Variable<int>(trackOwnerId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MainArtistsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('domain: $domain, ')
          ..write('artistId: $artistId, ')
          ..write('trackId: $trackId, ')
          ..write('trackOwnerId: $trackOwnerId')
          ..write(')'))
        .toString();
  }
}

class $TrackAlbumsTable extends TrackAlbums
    with TableInfo<$TrackAlbumsTable, TrackAlbum> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrackAlbumsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _trackIdMeta = const VerificationMeta(
    'trackId',
  );
  @override
  late final GeneratedColumn<int> trackId = GeneratedColumn<int>(
    'track_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _trackOwnerIdMeta = const VerificationMeta(
    'trackOwnerId',
  );
  @override
  late final GeneratedColumn<int> trackOwnerId = GeneratedColumn<int>(
    'track_owner_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _albumIdMeta = const VerificationMeta(
    'albumId',
  );
  @override
  late final GeneratedColumn<int> albumId = GeneratedColumn<int>(
    'album_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _albumOwnerIdMeta = const VerificationMeta(
    'albumOwnerId',
  );
  @override
  late final GeneratedColumn<int> albumOwnerId = GeneratedColumn<int>(
    'album_owner_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    trackId,
    trackOwnerId,
    albumId,
    albumOwnerId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'track_albums';
  @override
  VerificationContext validateIntegrity(
    Insertable<TrackAlbum> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('track_id')) {
      context.handle(
        _trackIdMeta,
        trackId.isAcceptableOrUnknown(data['track_id']!, _trackIdMeta),
      );
    } else if (isInserting) {
      context.missing(_trackIdMeta);
    }
    if (data.containsKey('track_owner_id')) {
      context.handle(
        _trackOwnerIdMeta,
        trackOwnerId.isAcceptableOrUnknown(
          data['track_owner_id']!,
          _trackOwnerIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_trackOwnerIdMeta);
    }
    if (data.containsKey('album_id')) {
      context.handle(
        _albumIdMeta,
        albumId.isAcceptableOrUnknown(data['album_id']!, _albumIdMeta),
      );
    } else if (isInserting) {
      context.missing(_albumIdMeta);
    }
    if (data.containsKey('album_owner_id')) {
      context.handle(
        _albumOwnerIdMeta,
        albumOwnerId.isAcceptableOrUnknown(
          data['album_owner_id']!,
          _albumOwnerIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_albumOwnerIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {
    trackId,
    trackOwnerId,
    albumId,
    albumOwnerId,
  };
  @override
  TrackAlbum map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrackAlbum(
      trackId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}track_id'],
      )!,
      trackOwnerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}track_owner_id'],
      )!,
      albumId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}album_id'],
      )!,
      albumOwnerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}album_owner_id'],
      )!,
    );
  }

  @override
  $TrackAlbumsTable createAlias(String alias) {
    return $TrackAlbumsTable(attachedDatabase, alias);
  }
}

class TrackAlbum extends DataClass implements Insertable<TrackAlbum> {
  final int trackId;
  final int trackOwnerId;
  final int albumId;
  final int albumOwnerId;
  const TrackAlbum({
    required this.trackId,
    required this.trackOwnerId,
    required this.albumId,
    required this.albumOwnerId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['track_id'] = Variable<int>(trackId);
    map['track_owner_id'] = Variable<int>(trackOwnerId);
    map['album_id'] = Variable<int>(albumId);
    map['album_owner_id'] = Variable<int>(albumOwnerId);
    return map;
  }

  TrackAlbumsCompanion toCompanion(bool nullToAbsent) {
    return TrackAlbumsCompanion(
      trackId: Value(trackId),
      trackOwnerId: Value(trackOwnerId),
      albumId: Value(albumId),
      albumOwnerId: Value(albumOwnerId),
    );
  }

  factory TrackAlbum.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrackAlbum(
      trackId: serializer.fromJson<int>(json['trackId']),
      trackOwnerId: serializer.fromJson<int>(json['trackOwnerId']),
      albumId: serializer.fromJson<int>(json['albumId']),
      albumOwnerId: serializer.fromJson<int>(json['albumOwnerId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'trackId': serializer.toJson<int>(trackId),
      'trackOwnerId': serializer.toJson<int>(trackOwnerId),
      'albumId': serializer.toJson<int>(albumId),
      'albumOwnerId': serializer.toJson<int>(albumOwnerId),
    };
  }

  TrackAlbum copyWith({
    int? trackId,
    int? trackOwnerId,
    int? albumId,
    int? albumOwnerId,
  }) => TrackAlbum(
    trackId: trackId ?? this.trackId,
    trackOwnerId: trackOwnerId ?? this.trackOwnerId,
    albumId: albumId ?? this.albumId,
    albumOwnerId: albumOwnerId ?? this.albumOwnerId,
  );
  TrackAlbum copyWithCompanion(TrackAlbumsCompanion data) {
    return TrackAlbum(
      trackId: data.trackId.present ? data.trackId.value : this.trackId,
      trackOwnerId: data.trackOwnerId.present
          ? data.trackOwnerId.value
          : this.trackOwnerId,
      albumId: data.albumId.present ? data.albumId.value : this.albumId,
      albumOwnerId: data.albumOwnerId.present
          ? data.albumOwnerId.value
          : this.albumOwnerId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrackAlbum(')
          ..write('trackId: $trackId, ')
          ..write('trackOwnerId: $trackOwnerId, ')
          ..write('albumId: $albumId, ')
          ..write('albumOwnerId: $albumOwnerId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(trackId, trackOwnerId, albumId, albumOwnerId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrackAlbum &&
          other.trackId == this.trackId &&
          other.trackOwnerId == this.trackOwnerId &&
          other.albumId == this.albumId &&
          other.albumOwnerId == this.albumOwnerId);
}

class TrackAlbumsCompanion extends UpdateCompanion<TrackAlbum> {
  final Value<int> trackId;
  final Value<int> trackOwnerId;
  final Value<int> albumId;
  final Value<int> albumOwnerId;
  final Value<int> rowid;
  const TrackAlbumsCompanion({
    this.trackId = const Value.absent(),
    this.trackOwnerId = const Value.absent(),
    this.albumId = const Value.absent(),
    this.albumOwnerId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TrackAlbumsCompanion.insert({
    required int trackId,
    required int trackOwnerId,
    required int albumId,
    required int albumOwnerId,
    this.rowid = const Value.absent(),
  }) : trackId = Value(trackId),
       trackOwnerId = Value(trackOwnerId),
       albumId = Value(albumId),
       albumOwnerId = Value(albumOwnerId);
  static Insertable<TrackAlbum> custom({
    Expression<int>? trackId,
    Expression<int>? trackOwnerId,
    Expression<int>? albumId,
    Expression<int>? albumOwnerId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (trackId != null) 'track_id': trackId,
      if (trackOwnerId != null) 'track_owner_id': trackOwnerId,
      if (albumId != null) 'album_id': albumId,
      if (albumOwnerId != null) 'album_owner_id': albumOwnerId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TrackAlbumsCompanion copyWith({
    Value<int>? trackId,
    Value<int>? trackOwnerId,
    Value<int>? albumId,
    Value<int>? albumOwnerId,
    Value<int>? rowid,
  }) {
    return TrackAlbumsCompanion(
      trackId: trackId ?? this.trackId,
      trackOwnerId: trackOwnerId ?? this.trackOwnerId,
      albumId: albumId ?? this.albumId,
      albumOwnerId: albumOwnerId ?? this.albumOwnerId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (trackId.present) {
      map['track_id'] = Variable<int>(trackId.value);
    }
    if (trackOwnerId.present) {
      map['track_owner_id'] = Variable<int>(trackOwnerId.value);
    }
    if (albumId.present) {
      map['album_id'] = Variable<int>(albumId.value);
    }
    if (albumOwnerId.present) {
      map['album_owner_id'] = Variable<int>(albumOwnerId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrackAlbumsCompanion(')
          ..write('trackId: $trackId, ')
          ..write('trackOwnerId: $trackOwnerId, ')
          ..write('albumId: $albumId, ')
          ..write('albumOwnerId: $albumOwnerId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AlbumThumbsTable extends AlbumThumbs
    with TableInfo<$AlbumThumbsTable, AlbumThumb> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlbumThumbsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _albumIdMeta = const VerificationMeta(
    'albumId',
  );
  @override
  late final GeneratedColumn<int> albumId = GeneratedColumn<int>(
    'album_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _albumOwnerIdMeta = const VerificationMeta(
    'albumOwnerId',
  );
  @override
  late final GeneratedColumn<int> albumOwnerId = GeneratedColumn<int>(
    'album_owner_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _thumbIdMeta = const VerificationMeta(
    'thumbId',
  );
  @override
  late final GeneratedColumn<String> thumbId = GeneratedColumn<String>(
    'thumb_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [albumId, albumOwnerId, thumbId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'album_thumbs';
  @override
  VerificationContext validateIntegrity(
    Insertable<AlbumThumb> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('album_id')) {
      context.handle(
        _albumIdMeta,
        albumId.isAcceptableOrUnknown(data['album_id']!, _albumIdMeta),
      );
    } else if (isInserting) {
      context.missing(_albumIdMeta);
    }
    if (data.containsKey('album_owner_id')) {
      context.handle(
        _albumOwnerIdMeta,
        albumOwnerId.isAcceptableOrUnknown(
          data['album_owner_id']!,
          _albumOwnerIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_albumOwnerIdMeta);
    }
    if (data.containsKey('thumb_id')) {
      context.handle(
        _thumbIdMeta,
        thumbId.isAcceptableOrUnknown(data['thumb_id']!, _thumbIdMeta),
      );
    } else if (isInserting) {
      context.missing(_thumbIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {albumId, albumOwnerId, thumbId};
  @override
  AlbumThumb map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AlbumThumb(
      albumId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}album_id'],
      )!,
      albumOwnerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}album_owner_id'],
      )!,
      thumbId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thumb_id'],
      )!,
    );
  }

  @override
  $AlbumThumbsTable createAlias(String alias) {
    return $AlbumThumbsTable(attachedDatabase, alias);
  }
}

class AlbumThumb extends DataClass implements Insertable<AlbumThumb> {
  final int albumId;
  final int albumOwnerId;
  final String thumbId;
  const AlbumThumb({
    required this.albumId,
    required this.albumOwnerId,
    required this.thumbId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['album_id'] = Variable<int>(albumId);
    map['album_owner_id'] = Variable<int>(albumOwnerId);
    map['thumb_id'] = Variable<String>(thumbId);
    return map;
  }

  AlbumThumbsCompanion toCompanion(bool nullToAbsent) {
    return AlbumThumbsCompanion(
      albumId: Value(albumId),
      albumOwnerId: Value(albumOwnerId),
      thumbId: Value(thumbId),
    );
  }

  factory AlbumThumb.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AlbumThumb(
      albumId: serializer.fromJson<int>(json['albumId']),
      albumOwnerId: serializer.fromJson<int>(json['albumOwnerId']),
      thumbId: serializer.fromJson<String>(json['thumbId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'albumId': serializer.toJson<int>(albumId),
      'albumOwnerId': serializer.toJson<int>(albumOwnerId),
      'thumbId': serializer.toJson<String>(thumbId),
    };
  }

  AlbumThumb copyWith({int? albumId, int? albumOwnerId, String? thumbId}) =>
      AlbumThumb(
        albumId: albumId ?? this.albumId,
        albumOwnerId: albumOwnerId ?? this.albumOwnerId,
        thumbId: thumbId ?? this.thumbId,
      );
  AlbumThumb copyWithCompanion(AlbumThumbsCompanion data) {
    return AlbumThumb(
      albumId: data.albumId.present ? data.albumId.value : this.albumId,
      albumOwnerId: data.albumOwnerId.present
          ? data.albumOwnerId.value
          : this.albumOwnerId,
      thumbId: data.thumbId.present ? data.thumbId.value : this.thumbId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AlbumThumb(')
          ..write('albumId: $albumId, ')
          ..write('albumOwnerId: $albumOwnerId, ')
          ..write('thumbId: $thumbId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(albumId, albumOwnerId, thumbId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AlbumThumb &&
          other.albumId == this.albumId &&
          other.albumOwnerId == this.albumOwnerId &&
          other.thumbId == this.thumbId);
}

class AlbumThumbsCompanion extends UpdateCompanion<AlbumThumb> {
  final Value<int> albumId;
  final Value<int> albumOwnerId;
  final Value<String> thumbId;
  final Value<int> rowid;
  const AlbumThumbsCompanion({
    this.albumId = const Value.absent(),
    this.albumOwnerId = const Value.absent(),
    this.thumbId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AlbumThumbsCompanion.insert({
    required int albumId,
    required int albumOwnerId,
    required String thumbId,
    this.rowid = const Value.absent(),
  }) : albumId = Value(albumId),
       albumOwnerId = Value(albumOwnerId),
       thumbId = Value(thumbId);
  static Insertable<AlbumThumb> custom({
    Expression<int>? albumId,
    Expression<int>? albumOwnerId,
    Expression<String>? thumbId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (albumId != null) 'album_id': albumId,
      if (albumOwnerId != null) 'album_owner_id': albumOwnerId,
      if (thumbId != null) 'thumb_id': thumbId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AlbumThumbsCompanion copyWith({
    Value<int>? albumId,
    Value<int>? albumOwnerId,
    Value<String>? thumbId,
    Value<int>? rowid,
  }) {
    return AlbumThumbsCompanion(
      albumId: albumId ?? this.albumId,
      albumOwnerId: albumOwnerId ?? this.albumOwnerId,
      thumbId: thumbId ?? this.thumbId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (albumId.present) {
      map['album_id'] = Variable<int>(albumId.value);
    }
    if (albumOwnerId.present) {
      map['album_owner_id'] = Variable<int>(albumOwnerId.value);
    }
    if (thumbId.present) {
      map['thumb_id'] = Variable<String>(thumbId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlbumThumbsCompanion(')
          ..write('albumId: $albumId, ')
          ..write('albumOwnerId: $albumOwnerId, ')
          ..write('thumbId: $thumbId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UnavailableTracksTable extends UnavailableTracks
    with TableInfo<$UnavailableTracksTable, UnavailableTrack> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UnavailableTracksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<int> ownerId = GeneratedColumn<int>(
    'owner_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fullIdMeta = const VerificationMeta('fullId');
  @override
  late final GeneratedColumn<String> fullId = GeneratedColumn<String>(
    'full_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, ownerId, fullId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'unavailable_tracks';
  @override
  VerificationContext validateIntegrity(
    Insertable<UnavailableTrack> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('full_id')) {
      context.handle(
        _fullIdMeta,
        fullId.isAcceptableOrUnknown(data['full_id']!, _fullIdMeta),
      );
    } else if (isInserting) {
      context.missing(_fullIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, ownerId};
  @override
  UnavailableTrack map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UnavailableTrack(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}owner_id'],
      )!,
      fullId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_id'],
      )!,
    );
  }

  @override
  $UnavailableTracksTable createAlias(String alias) {
    return $UnavailableTracksTable(attachedDatabase, alias);
  }
}

class UnavailableTrack extends DataClass
    implements Insertable<UnavailableTrack> {
  final int id;
  final int ownerId;
  final String fullId;
  const UnavailableTrack({
    required this.id,
    required this.ownerId,
    required this.fullId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['owner_id'] = Variable<int>(ownerId);
    map['full_id'] = Variable<String>(fullId);
    return map;
  }

  UnavailableTracksCompanion toCompanion(bool nullToAbsent) {
    return UnavailableTracksCompanion(
      id: Value(id),
      ownerId: Value(ownerId),
      fullId: Value(fullId),
    );
  }

  factory UnavailableTrack.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UnavailableTrack(
      id: serializer.fromJson<int>(json['id']),
      ownerId: serializer.fromJson<int>(json['ownerId']),
      fullId: serializer.fromJson<String>(json['fullId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ownerId': serializer.toJson<int>(ownerId),
      'fullId': serializer.toJson<String>(fullId),
    };
  }

  UnavailableTrack copyWith({int? id, int? ownerId, String? fullId}) =>
      UnavailableTrack(
        id: id ?? this.id,
        ownerId: ownerId ?? this.ownerId,
        fullId: fullId ?? this.fullId,
      );
  UnavailableTrack copyWithCompanion(UnavailableTracksCompanion data) {
    return UnavailableTrack(
      id: data.id.present ? data.id.value : this.id,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      fullId: data.fullId.present ? data.fullId.value : this.fullId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UnavailableTrack(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('fullId: $fullId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ownerId, fullId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UnavailableTrack &&
          other.id == this.id &&
          other.ownerId == this.ownerId &&
          other.fullId == this.fullId);
}

class UnavailableTracksCompanion extends UpdateCompanion<UnavailableTrack> {
  final Value<int> id;
  final Value<int> ownerId;
  final Value<String> fullId;
  final Value<int> rowid;
  const UnavailableTracksCompanion({
    this.id = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.fullId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UnavailableTracksCompanion.insert({
    required int id,
    required int ownerId,
    required String fullId,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ownerId = Value(ownerId),
       fullId = Value(fullId);
  static Insertable<UnavailableTrack> custom({
    Expression<int>? id,
    Expression<int>? ownerId,
    Expression<String>? fullId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerId != null) 'owner_id': ownerId,
      if (fullId != null) 'full_id': fullId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UnavailableTracksCompanion copyWith({
    Value<int>? id,
    Value<int>? ownerId,
    Value<String>? fullId,
    Value<int>? rowid,
  }) {
    return UnavailableTracksCompanion(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      fullId: fullId ?? this.fullId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<int>(ownerId.value);
    }
    if (fullId.present) {
      map['full_id'] = Variable<String>(fullId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UnavailableTracksCompanion(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('fullId: $fullId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedArtistsTable extends CachedArtists
    with TableInfo<$CachedArtistsTable, CachedArtist> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedArtistsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _artistIdMeta = const VerificationMeta(
    'artistId',
  );
  @override
  late final GeneratedColumn<String> artistId = GeneratedColumn<String>(
    'artist_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _domainMeta = const VerificationMeta('domain');
  @override
  late final GeneratedColumn<String> domain = GeneratedColumn<String>(
    'domain',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoUrlMeta = const VerificationMeta(
    'photoUrl',
  );
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
    'photo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastUpdatedMeta = const VerificationMeta(
    'lastUpdated',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
    'last_updated',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _photoCheckedMeta = const VerificationMeta(
    'photoChecked',
  );
  @override
  late final GeneratedColumn<bool> photoChecked = GeneratedColumn<bool>(
    'photo_checked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("photo_checked" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    artistId,
    name,
    domain,
    photoUrl,
    lastUpdated,
    photoChecked,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_artists';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedArtist> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('artist_id')) {
      context.handle(
        _artistIdMeta,
        artistId.isAcceptableOrUnknown(data['artist_id']!, _artistIdMeta),
      );
    } else if (isInserting) {
      context.missing(_artistIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('domain')) {
      context.handle(
        _domainMeta,
        domain.isAcceptableOrUnknown(data['domain']!, _domainMeta),
      );
    }
    if (data.containsKey('photo_url')) {
      context.handle(
        _photoUrlMeta,
        photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta),
      );
    }
    if (data.containsKey('last_updated')) {
      context.handle(
        _lastUpdatedMeta,
        lastUpdated.isAcceptableOrUnknown(
          data['last_updated']!,
          _lastUpdatedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    if (data.containsKey('photo_checked')) {
      context.handle(
        _photoCheckedMeta,
        photoChecked.isAcceptableOrUnknown(
          data['photo_checked']!,
          _photoCheckedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {artistId};
  @override
  CachedArtist map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedArtist(
      artistId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}artist_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      domain: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}domain'],
      ),
      photoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_url'],
      ),
      lastUpdated: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated'],
      )!,
      photoChecked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}photo_checked'],
      )!,
    );
  }

  @override
  $CachedArtistsTable createAlias(String alias) {
    return $CachedArtistsTable(attachedDatabase, alias);
  }
}

class CachedArtist extends DataClass implements Insertable<CachedArtist> {
  final String artistId;
  final String name;
  final String? domain;
  final String? photoUrl;
  final DateTime lastUpdated;
  final bool photoChecked;
  const CachedArtist({
    required this.artistId,
    required this.name,
    this.domain,
    this.photoUrl,
    required this.lastUpdated,
    required this.photoChecked,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['artist_id'] = Variable<String>(artistId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || domain != null) {
      map['domain'] = Variable<String>(domain);
    }
    if (!nullToAbsent || photoUrl != null) {
      map['photo_url'] = Variable<String>(photoUrl);
    }
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    map['photo_checked'] = Variable<bool>(photoChecked);
    return map;
  }

  CachedArtistsCompanion toCompanion(bool nullToAbsent) {
    return CachedArtistsCompanion(
      artistId: Value(artistId),
      name: Value(name),
      domain: domain == null && nullToAbsent
          ? const Value.absent()
          : Value(domain),
      photoUrl: photoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(photoUrl),
      lastUpdated: Value(lastUpdated),
      photoChecked: Value(photoChecked),
    );
  }

  factory CachedArtist.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedArtist(
      artistId: serializer.fromJson<String>(json['artistId']),
      name: serializer.fromJson<String>(json['name']),
      domain: serializer.fromJson<String?>(json['domain']),
      photoUrl: serializer.fromJson<String?>(json['photoUrl']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
      photoChecked: serializer.fromJson<bool>(json['photoChecked']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'artistId': serializer.toJson<String>(artistId),
      'name': serializer.toJson<String>(name),
      'domain': serializer.toJson<String?>(domain),
      'photoUrl': serializer.toJson<String?>(photoUrl),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
      'photoChecked': serializer.toJson<bool>(photoChecked),
    };
  }

  CachedArtist copyWith({
    String? artistId,
    String? name,
    Value<String?> domain = const Value.absent(),
    Value<String?> photoUrl = const Value.absent(),
    DateTime? lastUpdated,
    bool? photoChecked,
  }) => CachedArtist(
    artistId: artistId ?? this.artistId,
    name: name ?? this.name,
    domain: domain.present ? domain.value : this.domain,
    photoUrl: photoUrl.present ? photoUrl.value : this.photoUrl,
    lastUpdated: lastUpdated ?? this.lastUpdated,
    photoChecked: photoChecked ?? this.photoChecked,
  );
  CachedArtist copyWithCompanion(CachedArtistsCompanion data) {
    return CachedArtist(
      artistId: data.artistId.present ? data.artistId.value : this.artistId,
      name: data.name.present ? data.name.value : this.name,
      domain: data.domain.present ? data.domain.value : this.domain,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      lastUpdated: data.lastUpdated.present
          ? data.lastUpdated.value
          : this.lastUpdated,
      photoChecked: data.photoChecked.present
          ? data.photoChecked.value
          : this.photoChecked,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedArtist(')
          ..write('artistId: $artistId, ')
          ..write('name: $name, ')
          ..write('domain: $domain, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('photoChecked: $photoChecked')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(artistId, name, domain, photoUrl, lastUpdated, photoChecked);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedArtist &&
          other.artistId == this.artistId &&
          other.name == this.name &&
          other.domain == this.domain &&
          other.photoUrl == this.photoUrl &&
          other.lastUpdated == this.lastUpdated &&
          other.photoChecked == this.photoChecked);
}

class CachedArtistsCompanion extends UpdateCompanion<CachedArtist> {
  final Value<String> artistId;
  final Value<String> name;
  final Value<String?> domain;
  final Value<String?> photoUrl;
  final Value<DateTime> lastUpdated;
  final Value<bool> photoChecked;
  final Value<int> rowid;
  const CachedArtistsCompanion({
    this.artistId = const Value.absent(),
    this.name = const Value.absent(),
    this.domain = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.photoChecked = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedArtistsCompanion.insert({
    required String artistId,
    required String name,
    this.domain = const Value.absent(),
    this.photoUrl = const Value.absent(),
    required DateTime lastUpdated,
    this.photoChecked = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : artistId = Value(artistId),
       name = Value(name),
       lastUpdated = Value(lastUpdated);
  static Insertable<CachedArtist> custom({
    Expression<String>? artistId,
    Expression<String>? name,
    Expression<String>? domain,
    Expression<String>? photoUrl,
    Expression<DateTime>? lastUpdated,
    Expression<bool>? photoChecked,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (artistId != null) 'artist_id': artistId,
      if (name != null) 'name': name,
      if (domain != null) 'domain': domain,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (photoChecked != null) 'photo_checked': photoChecked,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedArtistsCompanion copyWith({
    Value<String>? artistId,
    Value<String>? name,
    Value<String?>? domain,
    Value<String?>? photoUrl,
    Value<DateTime>? lastUpdated,
    Value<bool>? photoChecked,
    Value<int>? rowid,
  }) {
    return CachedArtistsCompanion(
      artistId: artistId ?? this.artistId,
      name: name ?? this.name,
      domain: domain ?? this.domain,
      photoUrl: photoUrl ?? this.photoUrl,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      photoChecked: photoChecked ?? this.photoChecked,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (artistId.present) {
      map['artist_id'] = Variable<String>(artistId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (domain.present) {
      map['domain'] = Variable<String>(domain.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    if (photoChecked.present) {
      map['photo_checked'] = Variable<bool>(photoChecked.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedArtistsCompanion(')
          ..write('artistId: $artistId, ')
          ..write('name: $name, ')
          ..write('domain: $domain, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('photoChecked: $photoChecked, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AudioTracksTable audioTracks = $AudioTracksTable(this);
  late final $AlbumsTable albums = $AlbumsTable(this);
  late final $ThumbsTable thumbs = $ThumbsTable(this);
  late final $MainArtistsTable mainArtists = $MainArtistsTable(this);
  late final $TrackAlbumsTable trackAlbums = $TrackAlbumsTable(this);
  late final $AlbumThumbsTable albumThumbs = $AlbumThumbsTable(this);
  late final $UnavailableTracksTable unavailableTracks =
      $UnavailableTracksTable(this);
  late final $CachedArtistsTable cachedArtists = $CachedArtistsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    audioTracks,
    albums,
    thumbs,
    mainArtists,
    trackAlbums,
    albumThumbs,
    unavailableTracks,
    cachedArtists,
  ];
}

typedef $$AudioTracksTableCreateCompanionBuilder =
    AudioTracksCompanion Function({
      required int id,
      required int ownerId,
      required String title,
      required String artist,
      required int duration,
      required String url,
      Value<int?> date,
      Value<int?> genreId,
      Value<int?> lyricsId,
      Value<int> rowid,
    });
typedef $$AudioTracksTableUpdateCompanionBuilder =
    AudioTracksCompanion Function({
      Value<int> id,
      Value<int> ownerId,
      Value<String> title,
      Value<String> artist,
      Value<int> duration,
      Value<String> url,
      Value<int?> date,
      Value<int?> genreId,
      Value<int?> lyricsId,
      Value<int> rowid,
    });

class $$AudioTracksTableFilterComposer
    extends Composer<_$AppDatabase, $AudioTracksTable> {
  $$AudioTracksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get artist => $composableBuilder(
    column: $table.artist,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get genreId => $composableBuilder(
    column: $table.genreId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lyricsId => $composableBuilder(
    column: $table.lyricsId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AudioTracksTableOrderingComposer
    extends Composer<_$AppDatabase, $AudioTracksTable> {
  $$AudioTracksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get artist => $composableBuilder(
    column: $table.artist,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get genreId => $composableBuilder(
    column: $table.genreId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lyricsId => $composableBuilder(
    column: $table.lyricsId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AudioTracksTableAnnotationComposer
    extends Composer<_$AppDatabase, $AudioTracksTable> {
  $$AudioTracksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get artist =>
      $composableBuilder(column: $table.artist, builder: (column) => column);

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<int> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get genreId =>
      $composableBuilder(column: $table.genreId, builder: (column) => column);

  GeneratedColumn<int> get lyricsId =>
      $composableBuilder(column: $table.lyricsId, builder: (column) => column);
}

class $$AudioTracksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AudioTracksTable,
          AudioTrack,
          $$AudioTracksTableFilterComposer,
          $$AudioTracksTableOrderingComposer,
          $$AudioTracksTableAnnotationComposer,
          $$AudioTracksTableCreateCompanionBuilder,
          $$AudioTracksTableUpdateCompanionBuilder,
          (
            AudioTrack,
            BaseReferences<_$AppDatabase, $AudioTracksTable, AudioTrack>,
          ),
          AudioTrack,
          PrefetchHooks Function()
        > {
  $$AudioTracksTableTableManager(_$AppDatabase db, $AudioTracksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AudioTracksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AudioTracksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AudioTracksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> ownerId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> artist = const Value.absent(),
                Value<int> duration = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<int?> date = const Value.absent(),
                Value<int?> genreId = const Value.absent(),
                Value<int?> lyricsId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AudioTracksCompanion(
                id: id,
                ownerId: ownerId,
                title: title,
                artist: artist,
                duration: duration,
                url: url,
                date: date,
                genreId: genreId,
                lyricsId: lyricsId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int id,
                required int ownerId,
                required String title,
                required String artist,
                required int duration,
                required String url,
                Value<int?> date = const Value.absent(),
                Value<int?> genreId = const Value.absent(),
                Value<int?> lyricsId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AudioTracksCompanion.insert(
                id: id,
                ownerId: ownerId,
                title: title,
                artist: artist,
                duration: duration,
                url: url,
                date: date,
                genreId: genreId,
                lyricsId: lyricsId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AudioTracksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AudioTracksTable,
      AudioTrack,
      $$AudioTracksTableFilterComposer,
      $$AudioTracksTableOrderingComposer,
      $$AudioTracksTableAnnotationComposer,
      $$AudioTracksTableCreateCompanionBuilder,
      $$AudioTracksTableUpdateCompanionBuilder,
      (
        AudioTrack,
        BaseReferences<_$AppDatabase, $AudioTracksTable, AudioTrack>,
      ),
      AudioTrack,
      PrefetchHooks Function()
    >;
typedef $$AlbumsTableCreateCompanionBuilder =
    AlbumsCompanion Function({
      required int id,
      required String title,
      required int ownerId,
      Value<String?> mainColor,
      Value<int> rowid,
    });
typedef $$AlbumsTableUpdateCompanionBuilder =
    AlbumsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<int> ownerId,
      Value<String?> mainColor,
      Value<int> rowid,
    });

class $$AlbumsTableFilterComposer
    extends Composer<_$AppDatabase, $AlbumsTable> {
  $$AlbumsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mainColor => $composableBuilder(
    column: $table.mainColor,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AlbumsTableOrderingComposer
    extends Composer<_$AppDatabase, $AlbumsTable> {
  $$AlbumsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mainColor => $composableBuilder(
    column: $table.mainColor,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AlbumsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AlbumsTable> {
  $$AlbumsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<String> get mainColor =>
      $composableBuilder(column: $table.mainColor, builder: (column) => column);
}

class $$AlbumsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AlbumsTable,
          Album,
          $$AlbumsTableFilterComposer,
          $$AlbumsTableOrderingComposer,
          $$AlbumsTableAnnotationComposer,
          $$AlbumsTableCreateCompanionBuilder,
          $$AlbumsTableUpdateCompanionBuilder,
          (Album, BaseReferences<_$AppDatabase, $AlbumsTable, Album>),
          Album,
          PrefetchHooks Function()
        > {
  $$AlbumsTableTableManager(_$AppDatabase db, $AlbumsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AlbumsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AlbumsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AlbumsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> ownerId = const Value.absent(),
                Value<String?> mainColor = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AlbumsCompanion(
                id: id,
                title: title,
                ownerId: ownerId,
                mainColor: mainColor,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int id,
                required String title,
                required int ownerId,
                Value<String?> mainColor = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AlbumsCompanion.insert(
                id: id,
                title: title,
                ownerId: ownerId,
                mainColor: mainColor,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AlbumsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AlbumsTable,
      Album,
      $$AlbumsTableFilterComposer,
      $$AlbumsTableOrderingComposer,
      $$AlbumsTableAnnotationComposer,
      $$AlbumsTableCreateCompanionBuilder,
      $$AlbumsTableUpdateCompanionBuilder,
      (Album, BaseReferences<_$AppDatabase, $AlbumsTable, Album>),
      Album,
      PrefetchHooks Function()
    >;
typedef $$ThumbsTableCreateCompanionBuilder =
    ThumbsCompanion Function({
      Value<int> id,
      required int width,
      required int height,
      required String thumbId,
      Value<String?> photo34,
      Value<String?> photo135,
      Value<String?> photo300,
      Value<String?> photo600,
    });
typedef $$ThumbsTableUpdateCompanionBuilder =
    ThumbsCompanion Function({
      Value<int> id,
      Value<int> width,
      Value<int> height,
      Value<String> thumbId,
      Value<String?> photo34,
      Value<String?> photo135,
      Value<String?> photo300,
      Value<String?> photo600,
    });

class $$ThumbsTableFilterComposer
    extends Composer<_$AppDatabase, $ThumbsTable> {
  $$ThumbsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thumbId => $composableBuilder(
    column: $table.thumbId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photo34 => $composableBuilder(
    column: $table.photo34,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photo135 => $composableBuilder(
    column: $table.photo135,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photo300 => $composableBuilder(
    column: $table.photo300,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photo600 => $composableBuilder(
    column: $table.photo600,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ThumbsTableOrderingComposer
    extends Composer<_$AppDatabase, $ThumbsTable> {
  $$ThumbsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thumbId => $composableBuilder(
    column: $table.thumbId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photo34 => $composableBuilder(
    column: $table.photo34,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photo135 => $composableBuilder(
    column: $table.photo135,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photo300 => $composableBuilder(
    column: $table.photo300,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photo600 => $composableBuilder(
    column: $table.photo600,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ThumbsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ThumbsTable> {
  $$ThumbsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get width =>
      $composableBuilder(column: $table.width, builder: (column) => column);

  GeneratedColumn<int> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<String> get thumbId =>
      $composableBuilder(column: $table.thumbId, builder: (column) => column);

  GeneratedColumn<String> get photo34 =>
      $composableBuilder(column: $table.photo34, builder: (column) => column);

  GeneratedColumn<String> get photo135 =>
      $composableBuilder(column: $table.photo135, builder: (column) => column);

  GeneratedColumn<String> get photo300 =>
      $composableBuilder(column: $table.photo300, builder: (column) => column);

  GeneratedColumn<String> get photo600 =>
      $composableBuilder(column: $table.photo600, builder: (column) => column);
}

class $$ThumbsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ThumbsTable,
          Thumb,
          $$ThumbsTableFilterComposer,
          $$ThumbsTableOrderingComposer,
          $$ThumbsTableAnnotationComposer,
          $$ThumbsTableCreateCompanionBuilder,
          $$ThumbsTableUpdateCompanionBuilder,
          (Thumb, BaseReferences<_$AppDatabase, $ThumbsTable, Thumb>),
          Thumb,
          PrefetchHooks Function()
        > {
  $$ThumbsTableTableManager(_$AppDatabase db, $ThumbsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ThumbsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ThumbsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ThumbsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> width = const Value.absent(),
                Value<int> height = const Value.absent(),
                Value<String> thumbId = const Value.absent(),
                Value<String?> photo34 = const Value.absent(),
                Value<String?> photo135 = const Value.absent(),
                Value<String?> photo300 = const Value.absent(),
                Value<String?> photo600 = const Value.absent(),
              }) => ThumbsCompanion(
                id: id,
                width: width,
                height: height,
                thumbId: thumbId,
                photo34: photo34,
                photo135: photo135,
                photo300: photo300,
                photo600: photo600,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int width,
                required int height,
                required String thumbId,
                Value<String?> photo34 = const Value.absent(),
                Value<String?> photo135 = const Value.absent(),
                Value<String?> photo300 = const Value.absent(),
                Value<String?> photo600 = const Value.absent(),
              }) => ThumbsCompanion.insert(
                id: id,
                width: width,
                height: height,
                thumbId: thumbId,
                photo34: photo34,
                photo135: photo135,
                photo300: photo300,
                photo600: photo600,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ThumbsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ThumbsTable,
      Thumb,
      $$ThumbsTableFilterComposer,
      $$ThumbsTableOrderingComposer,
      $$ThumbsTableAnnotationComposer,
      $$ThumbsTableCreateCompanionBuilder,
      $$ThumbsTableUpdateCompanionBuilder,
      (Thumb, BaseReferences<_$AppDatabase, $ThumbsTable, Thumb>),
      Thumb,
      PrefetchHooks Function()
    >;
typedef $$MainArtistsTableCreateCompanionBuilder =
    MainArtistsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> domain,
      required String artistId,
      required int trackId,
      required int trackOwnerId,
    });
typedef $$MainArtistsTableUpdateCompanionBuilder =
    MainArtistsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> domain,
      Value<String> artistId,
      Value<int> trackId,
      Value<int> trackOwnerId,
    });

class $$MainArtistsTableFilterComposer
    extends Composer<_$AppDatabase, $MainArtistsTable> {
  $$MainArtistsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get domain => $composableBuilder(
    column: $table.domain,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get artistId => $composableBuilder(
    column: $table.artistId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get trackId => $composableBuilder(
    column: $table.trackId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get trackOwnerId => $composableBuilder(
    column: $table.trackOwnerId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MainArtistsTableOrderingComposer
    extends Composer<_$AppDatabase, $MainArtistsTable> {
  $$MainArtistsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get domain => $composableBuilder(
    column: $table.domain,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get artistId => $composableBuilder(
    column: $table.artistId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get trackId => $composableBuilder(
    column: $table.trackId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get trackOwnerId => $composableBuilder(
    column: $table.trackOwnerId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MainArtistsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MainArtistsTable> {
  $$MainArtistsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get domain =>
      $composableBuilder(column: $table.domain, builder: (column) => column);

  GeneratedColumn<String> get artistId =>
      $composableBuilder(column: $table.artistId, builder: (column) => column);

  GeneratedColumn<int> get trackId =>
      $composableBuilder(column: $table.trackId, builder: (column) => column);

  GeneratedColumn<int> get trackOwnerId => $composableBuilder(
    column: $table.trackOwnerId,
    builder: (column) => column,
  );
}

class $$MainArtistsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MainArtistsTable,
          MainArtist,
          $$MainArtistsTableFilterComposer,
          $$MainArtistsTableOrderingComposer,
          $$MainArtistsTableAnnotationComposer,
          $$MainArtistsTableCreateCompanionBuilder,
          $$MainArtistsTableUpdateCompanionBuilder,
          (
            MainArtist,
            BaseReferences<_$AppDatabase, $MainArtistsTable, MainArtist>,
          ),
          MainArtist,
          PrefetchHooks Function()
        > {
  $$MainArtistsTableTableManager(_$AppDatabase db, $MainArtistsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MainArtistsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MainArtistsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MainArtistsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> domain = const Value.absent(),
                Value<String> artistId = const Value.absent(),
                Value<int> trackId = const Value.absent(),
                Value<int> trackOwnerId = const Value.absent(),
              }) => MainArtistsCompanion(
                id: id,
                name: name,
                domain: domain,
                artistId: artistId,
                trackId: trackId,
                trackOwnerId: trackOwnerId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> domain = const Value.absent(),
                required String artistId,
                required int trackId,
                required int trackOwnerId,
              }) => MainArtistsCompanion.insert(
                id: id,
                name: name,
                domain: domain,
                artistId: artistId,
                trackId: trackId,
                trackOwnerId: trackOwnerId,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MainArtistsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MainArtistsTable,
      MainArtist,
      $$MainArtistsTableFilterComposer,
      $$MainArtistsTableOrderingComposer,
      $$MainArtistsTableAnnotationComposer,
      $$MainArtistsTableCreateCompanionBuilder,
      $$MainArtistsTableUpdateCompanionBuilder,
      (
        MainArtist,
        BaseReferences<_$AppDatabase, $MainArtistsTable, MainArtist>,
      ),
      MainArtist,
      PrefetchHooks Function()
    >;
typedef $$TrackAlbumsTableCreateCompanionBuilder =
    TrackAlbumsCompanion Function({
      required int trackId,
      required int trackOwnerId,
      required int albumId,
      required int albumOwnerId,
      Value<int> rowid,
    });
typedef $$TrackAlbumsTableUpdateCompanionBuilder =
    TrackAlbumsCompanion Function({
      Value<int> trackId,
      Value<int> trackOwnerId,
      Value<int> albumId,
      Value<int> albumOwnerId,
      Value<int> rowid,
    });

class $$TrackAlbumsTableFilterComposer
    extends Composer<_$AppDatabase, $TrackAlbumsTable> {
  $$TrackAlbumsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get trackId => $composableBuilder(
    column: $table.trackId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get trackOwnerId => $composableBuilder(
    column: $table.trackOwnerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get albumId => $composableBuilder(
    column: $table.albumId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get albumOwnerId => $composableBuilder(
    column: $table.albumOwnerId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TrackAlbumsTableOrderingComposer
    extends Composer<_$AppDatabase, $TrackAlbumsTable> {
  $$TrackAlbumsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get trackId => $composableBuilder(
    column: $table.trackId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get trackOwnerId => $composableBuilder(
    column: $table.trackOwnerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get albumId => $composableBuilder(
    column: $table.albumId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get albumOwnerId => $composableBuilder(
    column: $table.albumOwnerId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TrackAlbumsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrackAlbumsTable> {
  $$TrackAlbumsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get trackId =>
      $composableBuilder(column: $table.trackId, builder: (column) => column);

  GeneratedColumn<int> get trackOwnerId => $composableBuilder(
    column: $table.trackOwnerId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get albumId =>
      $composableBuilder(column: $table.albumId, builder: (column) => column);

  GeneratedColumn<int> get albumOwnerId => $composableBuilder(
    column: $table.albumOwnerId,
    builder: (column) => column,
  );
}

class $$TrackAlbumsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TrackAlbumsTable,
          TrackAlbum,
          $$TrackAlbumsTableFilterComposer,
          $$TrackAlbumsTableOrderingComposer,
          $$TrackAlbumsTableAnnotationComposer,
          $$TrackAlbumsTableCreateCompanionBuilder,
          $$TrackAlbumsTableUpdateCompanionBuilder,
          (
            TrackAlbum,
            BaseReferences<_$AppDatabase, $TrackAlbumsTable, TrackAlbum>,
          ),
          TrackAlbum,
          PrefetchHooks Function()
        > {
  $$TrackAlbumsTableTableManager(_$AppDatabase db, $TrackAlbumsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrackAlbumsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrackAlbumsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrackAlbumsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> trackId = const Value.absent(),
                Value<int> trackOwnerId = const Value.absent(),
                Value<int> albumId = const Value.absent(),
                Value<int> albumOwnerId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TrackAlbumsCompanion(
                trackId: trackId,
                trackOwnerId: trackOwnerId,
                albumId: albumId,
                albumOwnerId: albumOwnerId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int trackId,
                required int trackOwnerId,
                required int albumId,
                required int albumOwnerId,
                Value<int> rowid = const Value.absent(),
              }) => TrackAlbumsCompanion.insert(
                trackId: trackId,
                trackOwnerId: trackOwnerId,
                albumId: albumId,
                albumOwnerId: albumOwnerId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TrackAlbumsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TrackAlbumsTable,
      TrackAlbum,
      $$TrackAlbumsTableFilterComposer,
      $$TrackAlbumsTableOrderingComposer,
      $$TrackAlbumsTableAnnotationComposer,
      $$TrackAlbumsTableCreateCompanionBuilder,
      $$TrackAlbumsTableUpdateCompanionBuilder,
      (
        TrackAlbum,
        BaseReferences<_$AppDatabase, $TrackAlbumsTable, TrackAlbum>,
      ),
      TrackAlbum,
      PrefetchHooks Function()
    >;
typedef $$AlbumThumbsTableCreateCompanionBuilder =
    AlbumThumbsCompanion Function({
      required int albumId,
      required int albumOwnerId,
      required String thumbId,
      Value<int> rowid,
    });
typedef $$AlbumThumbsTableUpdateCompanionBuilder =
    AlbumThumbsCompanion Function({
      Value<int> albumId,
      Value<int> albumOwnerId,
      Value<String> thumbId,
      Value<int> rowid,
    });

class $$AlbumThumbsTableFilterComposer
    extends Composer<_$AppDatabase, $AlbumThumbsTable> {
  $$AlbumThumbsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get albumId => $composableBuilder(
    column: $table.albumId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get albumOwnerId => $composableBuilder(
    column: $table.albumOwnerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thumbId => $composableBuilder(
    column: $table.thumbId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AlbumThumbsTableOrderingComposer
    extends Composer<_$AppDatabase, $AlbumThumbsTable> {
  $$AlbumThumbsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get albumId => $composableBuilder(
    column: $table.albumId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get albumOwnerId => $composableBuilder(
    column: $table.albumOwnerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thumbId => $composableBuilder(
    column: $table.thumbId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AlbumThumbsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AlbumThumbsTable> {
  $$AlbumThumbsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get albumId =>
      $composableBuilder(column: $table.albumId, builder: (column) => column);

  GeneratedColumn<int> get albumOwnerId => $composableBuilder(
    column: $table.albumOwnerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get thumbId =>
      $composableBuilder(column: $table.thumbId, builder: (column) => column);
}

class $$AlbumThumbsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AlbumThumbsTable,
          AlbumThumb,
          $$AlbumThumbsTableFilterComposer,
          $$AlbumThumbsTableOrderingComposer,
          $$AlbumThumbsTableAnnotationComposer,
          $$AlbumThumbsTableCreateCompanionBuilder,
          $$AlbumThumbsTableUpdateCompanionBuilder,
          (
            AlbumThumb,
            BaseReferences<_$AppDatabase, $AlbumThumbsTable, AlbumThumb>,
          ),
          AlbumThumb,
          PrefetchHooks Function()
        > {
  $$AlbumThumbsTableTableManager(_$AppDatabase db, $AlbumThumbsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AlbumThumbsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AlbumThumbsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AlbumThumbsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> albumId = const Value.absent(),
                Value<int> albumOwnerId = const Value.absent(),
                Value<String> thumbId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AlbumThumbsCompanion(
                albumId: albumId,
                albumOwnerId: albumOwnerId,
                thumbId: thumbId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int albumId,
                required int albumOwnerId,
                required String thumbId,
                Value<int> rowid = const Value.absent(),
              }) => AlbumThumbsCompanion.insert(
                albumId: albumId,
                albumOwnerId: albumOwnerId,
                thumbId: thumbId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AlbumThumbsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AlbumThumbsTable,
      AlbumThumb,
      $$AlbumThumbsTableFilterComposer,
      $$AlbumThumbsTableOrderingComposer,
      $$AlbumThumbsTableAnnotationComposer,
      $$AlbumThumbsTableCreateCompanionBuilder,
      $$AlbumThumbsTableUpdateCompanionBuilder,
      (
        AlbumThumb,
        BaseReferences<_$AppDatabase, $AlbumThumbsTable, AlbumThumb>,
      ),
      AlbumThumb,
      PrefetchHooks Function()
    >;
typedef $$UnavailableTracksTableCreateCompanionBuilder =
    UnavailableTracksCompanion Function({
      required int id,
      required int ownerId,
      required String fullId,
      Value<int> rowid,
    });
typedef $$UnavailableTracksTableUpdateCompanionBuilder =
    UnavailableTracksCompanion Function({
      Value<int> id,
      Value<int> ownerId,
      Value<String> fullId,
      Value<int> rowid,
    });

class $$UnavailableTracksTableFilterComposer
    extends Composer<_$AppDatabase, $UnavailableTracksTable> {
  $$UnavailableTracksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullId => $composableBuilder(
    column: $table.fullId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UnavailableTracksTableOrderingComposer
    extends Composer<_$AppDatabase, $UnavailableTracksTable> {
  $$UnavailableTracksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullId => $composableBuilder(
    column: $table.fullId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UnavailableTracksTableAnnotationComposer
    extends Composer<_$AppDatabase, $UnavailableTracksTable> {
  $$UnavailableTracksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<String> get fullId =>
      $composableBuilder(column: $table.fullId, builder: (column) => column);
}

class $$UnavailableTracksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UnavailableTracksTable,
          UnavailableTrack,
          $$UnavailableTracksTableFilterComposer,
          $$UnavailableTracksTableOrderingComposer,
          $$UnavailableTracksTableAnnotationComposer,
          $$UnavailableTracksTableCreateCompanionBuilder,
          $$UnavailableTracksTableUpdateCompanionBuilder,
          (
            UnavailableTrack,
            BaseReferences<
              _$AppDatabase,
              $UnavailableTracksTable,
              UnavailableTrack
            >,
          ),
          UnavailableTrack,
          PrefetchHooks Function()
        > {
  $$UnavailableTracksTableTableManager(
    _$AppDatabase db,
    $UnavailableTracksTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UnavailableTracksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UnavailableTracksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UnavailableTracksTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> ownerId = const Value.absent(),
                Value<String> fullId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UnavailableTracksCompanion(
                id: id,
                ownerId: ownerId,
                fullId: fullId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int id,
                required int ownerId,
                required String fullId,
                Value<int> rowid = const Value.absent(),
              }) => UnavailableTracksCompanion.insert(
                id: id,
                ownerId: ownerId,
                fullId: fullId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UnavailableTracksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UnavailableTracksTable,
      UnavailableTrack,
      $$UnavailableTracksTableFilterComposer,
      $$UnavailableTracksTableOrderingComposer,
      $$UnavailableTracksTableAnnotationComposer,
      $$UnavailableTracksTableCreateCompanionBuilder,
      $$UnavailableTracksTableUpdateCompanionBuilder,
      (
        UnavailableTrack,
        BaseReferences<
          _$AppDatabase,
          $UnavailableTracksTable,
          UnavailableTrack
        >,
      ),
      UnavailableTrack,
      PrefetchHooks Function()
    >;
typedef $$CachedArtistsTableCreateCompanionBuilder =
    CachedArtistsCompanion Function({
      required String artistId,
      required String name,
      Value<String?> domain,
      Value<String?> photoUrl,
      required DateTime lastUpdated,
      Value<bool> photoChecked,
      Value<int> rowid,
    });
typedef $$CachedArtistsTableUpdateCompanionBuilder =
    CachedArtistsCompanion Function({
      Value<String> artistId,
      Value<String> name,
      Value<String?> domain,
      Value<String?> photoUrl,
      Value<DateTime> lastUpdated,
      Value<bool> photoChecked,
      Value<int> rowid,
    });

class $$CachedArtistsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedArtistsTable> {
  $$CachedArtistsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get artistId => $composableBuilder(
    column: $table.artistId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get domain => $composableBuilder(
    column: $table.domain,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get photoChecked => $composableBuilder(
    column: $table.photoChecked,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedArtistsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedArtistsTable> {
  $$CachedArtistsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get artistId => $composableBuilder(
    column: $table.artistId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get domain => $composableBuilder(
    column: $table.domain,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get photoChecked => $composableBuilder(
    column: $table.photoChecked,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedArtistsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedArtistsTable> {
  $$CachedArtistsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get artistId =>
      $composableBuilder(column: $table.artistId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get domain =>
      $composableBuilder(column: $table.domain, builder: (column) => column);

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get photoChecked => $composableBuilder(
    column: $table.photoChecked,
    builder: (column) => column,
  );
}

class $$CachedArtistsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedArtistsTable,
          CachedArtist,
          $$CachedArtistsTableFilterComposer,
          $$CachedArtistsTableOrderingComposer,
          $$CachedArtistsTableAnnotationComposer,
          $$CachedArtistsTableCreateCompanionBuilder,
          $$CachedArtistsTableUpdateCompanionBuilder,
          (
            CachedArtist,
            BaseReferences<_$AppDatabase, $CachedArtistsTable, CachedArtist>,
          ),
          CachedArtist,
          PrefetchHooks Function()
        > {
  $$CachedArtistsTableTableManager(_$AppDatabase db, $CachedArtistsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedArtistsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedArtistsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedArtistsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> artistId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> domain = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                Value<DateTime> lastUpdated = const Value.absent(),
                Value<bool> photoChecked = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedArtistsCompanion(
                artistId: artistId,
                name: name,
                domain: domain,
                photoUrl: photoUrl,
                lastUpdated: lastUpdated,
                photoChecked: photoChecked,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String artistId,
                required String name,
                Value<String?> domain = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                required DateTime lastUpdated,
                Value<bool> photoChecked = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedArtistsCompanion.insert(
                artistId: artistId,
                name: name,
                domain: domain,
                photoUrl: photoUrl,
                lastUpdated: lastUpdated,
                photoChecked: photoChecked,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedArtistsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedArtistsTable,
      CachedArtist,
      $$CachedArtistsTableFilterComposer,
      $$CachedArtistsTableOrderingComposer,
      $$CachedArtistsTableAnnotationComposer,
      $$CachedArtistsTableCreateCompanionBuilder,
      $$CachedArtistsTableUpdateCompanionBuilder,
      (
        CachedArtist,
        BaseReferences<_$AppDatabase, $CachedArtistsTable, CachedArtist>,
      ),
      CachedArtist,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AudioTracksTableTableManager get audioTracks =>
      $$AudioTracksTableTableManager(_db, _db.audioTracks);
  $$AlbumsTableTableManager get albums =>
      $$AlbumsTableTableManager(_db, _db.albums);
  $$ThumbsTableTableManager get thumbs =>
      $$ThumbsTableTableManager(_db, _db.thumbs);
  $$MainArtistsTableTableManager get mainArtists =>
      $$MainArtistsTableTableManager(_db, _db.mainArtists);
  $$TrackAlbumsTableTableManager get trackAlbums =>
      $$TrackAlbumsTableTableManager(_db, _db.trackAlbums);
  $$AlbumThumbsTableTableManager get albumThumbs =>
      $$AlbumThumbsTableTableManager(_db, _db.albumThumbs);
  $$UnavailableTracksTableTableManager get unavailableTracks =>
      $$UnavailableTracksTableTableManager(_db, _db.unavailableTracks);
  $$CachedArtistsTableTableManager get cachedArtists =>
      $$CachedArtistsTableTableManager(_db, _db.cachedArtists);
}
