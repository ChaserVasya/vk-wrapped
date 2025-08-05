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
         listener: (context, error) {
           if (delegateListener != null) {
             delegateListener(context, error);
             return;
           }
           context.showSnackBar(error.toString());
         },
       );
}
