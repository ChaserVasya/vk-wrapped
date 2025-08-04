import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:front/domain/services/cache_service_interface.dart';
import 'package:front/data/services/enhanced_cache_service.dart';

import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  await getIt.init();
  
  // Регистрируем интерфейс как синглтон
  getIt.registerSingleton<CacheServiceInterface>(getIt<EnhancedCacheService>());
}
