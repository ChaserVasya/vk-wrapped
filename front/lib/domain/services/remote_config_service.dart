import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';

@singleton
class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  final _emojiController = StreamController<String>.broadcast();
  StreamSubscription<String>? _sub;

  RemoteConfigService() {
    // Слушаем обновления конфигурации
    _remoteConfig.onConfigUpdated.listen((event) {
      _emojiController.add(introEmoji);
    });

    _sub = _emojiController.stream.listen(
      (emoji) => print('Current emoji: $emoji'),
    );
  }

  @preResolve
  Future<void> init() async {
    try {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(hours: 1),
        ),
      );

      // Отключаем A/B тестирование
      await _remoteConfig.setDefaults(const {});

      await _remoteConfig.fetchAndActivate();

      // Эмитим начальное значение
      _emojiController.add(introEmoji);
    } catch (e) {
      print('Error initializing Remote Config: $e');
    }
  }

  String get introEmoji {
    try {
      return _remoteConfig.getString('day_emodji');
    } catch (e) {
      print('Error getting intro emoji: $e');
      return '';
    }
  }

  Stream<String> get introEmojiStream => _emojiController.stream;

  Future<void> fetchAndActivate() async {
    try {
      await _remoteConfig.fetchAndActivate();
      _emojiController.add(introEmoji);
    } catch (e) {
      print('Error fetching remote config: $e');
    }
  }

  Future<void> forceFetch() async {
    try {
      await _remoteConfig.fetch();
      await _remoteConfig.activate();
      _emojiController.add(introEmoji);
    } catch (e) {
      print('Error force fetching remote config: $e');
    }
  }

  void dispose() {
    _emojiController.close();
    _sub?.cancel();
    _sub = null;
  }
}
