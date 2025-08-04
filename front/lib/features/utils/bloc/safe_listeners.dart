import 'package:front/features/utils/bloc/safe_bloc.dart';
import 'package:front/ui/widgets/extensions.dart';

class ShowErrorSafeListener<B extends ErrorEmitterMixin>
    extends EffectListener<B, Exception> {
  ShowErrorSafeListener({
    super.child,
    super.bloc,
    super.key,
    String? Function(Exception)? messageBuilder,
    BlocPresentationWidgetListener<Exception>? delegateListener,
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
