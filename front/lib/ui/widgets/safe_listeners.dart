import 'package:front/domain/exceptions/app_exception.dart';
import 'package:front/features/utils/bloc/safe_bloc.dart';
import 'package:front/ui/widgets/extensions.dart';

class ShowErrorSafeListener<B extends ErrorEmitterMixin>
    extends EffectListener<B, AppException> {
  ShowErrorSafeListener({
    super.child,
    super.bloc,
    super.key,
    String? Function(AppException)? messageBuilder,
    BlocPresentationWidgetListener<AppException>? delegateListener,
  }) : super(
         listener: (context, state) {
           String? message = messageBuilder?.call(state);
           message ??= state.constructMessageInUI(context, state);
           final errorInfo = state.debugInfo;
           context.showSnackBar(message, errorInfo: errorInfo);
         },
       );
}
