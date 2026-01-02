import 'package:front/domain/entities/date_range_filter.dart';
import 'package:front/domain/storages/auth_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: AuthStorage)
class PrefsStorage implements AuthStorage {
  static const String _tokenKey = 'vk_token';
  static const String _vkAppId = 'vk_app_id';
  static const String _tokenExpiryKey = 'vk_token_expiry';
  static const String _dateRangeFilterStartKey = 'date_range_filter_start';
  static const String _dateRangeFilterEndKey = 'date_range_filter_end';

  const PrefsStorage(this._prefs);

  final SharedPreferencesWithCache _prefs;

  /// token id

  @override
  Future<void> saveToken(String token) async =>
      await _prefs.setString(_tokenKey, token);

  @override
  String? getToken() => _prefs.getString(_tokenKey);

  @override
  Future<void> clearToken() async => await _prefs.remove(_tokenKey);

  @override
  Future<void> saveTokenExpiry(DateTime? expiresAt) async {
    if (expiresAt == null) {
      await _prefs.remove(_tokenExpiryKey);
      return;
    }
    await _prefs.setInt(_tokenExpiryKey, expiresAt.millisecondsSinceEpoch);
  }

  @override
  DateTime? getTokenExpiry() {
    final ts = _prefs.getInt(_tokenExpiryKey);
    if (ts == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(ts);
  }

  /// client id

  @override
  Future<void> saveVkAppId(String vkAppId) async =>
      await _prefs.setString(_vkAppId, vkAppId);

  @override
  String? getVkAppId() => _prefs.getString(_vkAppId);

  @override
  Future<void> clearVkAppId() async => await _prefs.remove(_vkAppId);

  /// other

  Future<void> clear() async => await _prefs.clear();

  /// Date range filter

  /// Сохраняет фильтр диапазона дат
  Future<void> saveDateRangeFilter(DateRangeFilter? filter) async {
    if (filter == null) {
      await _prefs.remove(_dateRangeFilterStartKey);
      await _prefs.remove(_dateRangeFilterEndKey);
      return;
    }

    if (filter.startDate != null) {
      await _prefs.setInt(
        _dateRangeFilterStartKey,
        filter.startDate!.millisecondsSinceEpoch,
      );
    } else {
      await _prefs.remove(_dateRangeFilterStartKey);
    }

    if (filter.endDate != null) {
      await _prefs.setInt(
        _dateRangeFilterEndKey,
        filter.endDate!.millisecondsSinceEpoch,
      );
    } else {
      await _prefs.remove(_dateRangeFilterEndKey);
    }
  }

  /// Загружает фильтр диапазона дат
  DateRangeFilter? getDateRangeFilter() {
    final startTimestamp = _prefs.getInt(_dateRangeFilterStartKey);
    final endTimestamp = _prefs.getInt(_dateRangeFilterEndKey);

    if (startTimestamp == null && endTimestamp == null) {
      return null;
    }

    final startDate = startTimestamp != null
        ? DateTime.fromMillisecondsSinceEpoch(startTimestamp)
        : null;
    final endDate = endTimestamp != null
        ? DateTime.fromMillisecondsSinceEpoch(endTimestamp)
        : null;

    return DateRangeFilter(startDate: startDate, endDate: endDate);
  }
}
