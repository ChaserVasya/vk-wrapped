import 'dart:async';

import 'package:dartx/dartx.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/domain/config.dart';
import 'package:front/domain/services/token_generator.dart';
import 'package:front/domain/storages/auth_storage.dart';
import 'package:front/features/utils/bloc/safe_bloc.dart';
import 'package:injectable/injectable.dart';

part 'token_setup_bloc.freezed.dart';
part 'token_setup_effect.dart';
part 'token_setup_event.dart';
part 'token_setup_state.dart';

@injectable
class TokenSetupBloc extends EffectBloc<TokenSetupEvent, TokenSetupState> {
  final AuthStorage _authStorage;
  final TokenGenerator _tokenGenerator;

  TokenSetupBloc(this._authStorage, this._tokenGenerator)
    : super(() {
        final vkAppId = _authStorage.getVkAppId() ?? Config.fallbackVkAppId;
        final currentToken = _authStorage.getToken();
        final tokenGenerationUrl = _tokenGenerator.generateAuthUrl(vkAppId);
        return TokenSetupState(
          vkAppId: vkAppId,
          currentToken: currentToken,
          tokenGenerationUrl: tokenGenerationUrl,
        );
      }()) {
    on<_VkTokenResponseProvided>(_onVkTokenResponseProvided);
    on<_VkAppIdSaved>(_onVkAppIdSaved);
  }

  Future<void> _onVkTokenResponseProvided(
    _VkTokenResponseProvided event,
    Emitter<TokenSetupState> emit,
  ) async {
    final url = event.url;

    if (url.isBlank) {
      emitErrorEffect('Вставьте ссылку');
      return;
    }

    final token = _tokenGenerator.extractTokenFromUrl(url);

    if (token == null) {
      emitErrorEffect('Не удалось получить токен :(');
      return;
    }

    await _authStorage.saveToken(token);
    emitEffect(const TokenSetupEffect.finish());
  }

  Future<void> _onVkAppIdSaved(
    _VkAppIdSaved event,
    Emitter<TokenSetupState> emit,
  ) async {
    var vkAppId = event.vkAppId;

    if (vkAppId.isBlank) {
      vkAppId = Config.fallbackVkAppId;
    }

    await _authStorage.saveVkAppId(vkAppId);
    final url = _tokenGenerator.generateAuthUrl(vkAppId);
    emit(state.copyWith(tokenGenerationUrl: url, vkAppId: vkAppId));
  }
}
