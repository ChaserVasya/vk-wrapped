import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/domain/exceptions/app_exception.dart';

part 'generated/common_states.freezed.dart';

@freezed
sealed class CommonStates<T> with _$CommonStates<T> {
  const CommonStates._();

  const factory CommonStates.data(T data) = CommonStateData<T>;
  const factory CommonStates.error(AppException e) = CommonStateError;
  const factory CommonStates.loading() = CommonStateLoading<T>;

  T? get dataOrNull {
    final self = this;
    if (self is! CommonStateData<T>) return null;
    return self.data;
  }

  T get ensureData {
    final self = this;
    if (self is CommonStateData<T>) {
      return self.data;
    }
    // Should never be reached
    throw StateError('Unexpected state: $self');
  }

  bool get isLoading => this is CommonStateLoading;
  bool get isData => this is CommonStateData;
  bool get isError => this is CommonStateError;
  bool get isNotData => this is! CommonStateData;
}
