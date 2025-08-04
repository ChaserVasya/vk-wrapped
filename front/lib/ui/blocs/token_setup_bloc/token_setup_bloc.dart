import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/data/services/token_generator.dart';
import 'package:front/data/services/token_service.dart';
import 'package:front/features/utils/bloc/safe_bloc.dart';
import 'package:injectable/injectable.dart';

part 'token_setup_bloc.freezed.dart';
part 'token_setup_effect.dart';
part 'token_setup_event.dart';
part 'token_setup_state.dart';

@injectable
class TokenSetupBloc extends EffectBloc<TokenSetupEvent, TokenSetupState> {
  final TokenService _tokenService;
  final TokenGenerator _tokenGenerator;

  TokenSetupBloc({
    required TokenService tokenService,
    required TokenGenerator tokenGenerator,
  }) : _tokenService = tokenService,
       _tokenGenerator = tokenGenerator,
       super(const TokenSetupState.initial()) {
    on<_LoadCurrentData>(_onLoadCurrentData);
    on<_SaveToken>(_onSaveToken);
    on<_OpenTokenUrl>(_onOpenTokenUrl);
  }

  Future<void> _onLoadCurrentData(
    _LoadCurrentData event,
    Emitter<TokenSetupState> emit,
  ) async {
    try {
      emit(const TokenSetupState.loading());

      final currentToken = await _tokenService.getToken();
      final currentClientId = await _tokenService.getClientId();

      emit(
        TokenSetupState.dataLoaded(
          currentToken: currentToken,
          currentClientId: currentClientId,
        ),
      );
    } catch (e) {
      emitEffect(TokenSetupEffect.error(message: e.toString()));
    }
  }

  Future<void> _onSaveToken(
    _SaveToken event,
    Emitter<TokenSetupState> emit,
  ) async {
    if (event.token.trim().isEmpty) {
      emitEffect(
        const TokenSetupEffect.validationError(message: 'Введите токен'),
      );
      return;
    }

    try {
      emit(const TokenSetupState.saving());

      await _tokenService.saveToken(event.token.trim());

      if (event.clientId.trim().isNotEmpty) {
        await _tokenService.setClientId(event.clientId.trim());
      }

      emitEffect(const TokenSetupEffect.tokenSaved());
    } catch (e) {
      emitEffect(TokenSetupEffect.error(message: 'Ошибка сохранения: $e'));
    }
  }

  Future<void> _onOpenTokenUrl(
    _OpenTokenUrl event,
    Emitter<TokenSetupState> emit,
  ) async {
    try {
      final clientId = await _tokenService.getClientId();
      const redirectUri = 'https://oauth.vk.com/blank.html';
      final url = _tokenGenerator.generateAuthUrl(clientId, redirectUri);
      emitEffect(TokenSetupEffect.openUrl(url: url));
    } catch (e) {
      emitEffect(
        TokenSetupEffect.error(message: 'Ошибка генерации ссылки: $e'),
      );
    }
  }
}
