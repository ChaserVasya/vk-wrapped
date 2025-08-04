import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:front/data/services/token_service.dart';
import 'package:front/features/utils/lib/src/bloc/safe_bloc.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';
part 'home_effect.dart';

@injectable
class HomeBloc extends EffectBloc<HomeEvent, HomeState> {
  final TokenService _tokenService;

  HomeBloc({required TokenService tokenService})
    : _tokenService = tokenService,
      super(const HomeState.initial()) {
    on<_SaveToken>(_onSaveToken);
    on<_ShowTokenDialog>(_onShowTokenDialog);
  }

  Future<void> _onSaveToken(_SaveToken event, Emitter<HomeState> emit) async {
    try {
      if (!TokenService.isValidToken(event.token)) {
        emitEffect(
          const HomeEffect.tokenError(message: 'Неверный формат токена'),
        );
        return;
      }

      await _tokenService.saveToken(event.token);
      emitEffect(const HomeEffect.tokenSaved());
    } catch (e) {
      emitEffect(HomeEffect.tokenError(message: e.toString()));
    }
  }

  Future<void> _onShowTokenDialog(
    _ShowTokenDialog event,
    Emitter<HomeState> emit,
  ) async {
    emitEffect(const HomeEffect.showTokenDialog());
  }
}
