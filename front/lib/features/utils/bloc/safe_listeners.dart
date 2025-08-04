import 'package:flutter/material.dart';
import 'package:front/features/utils/bloc/safe_bloc.dart';

class ShowErrorSafeListener<B extends ErrorEmitterMixin>
    extends EffectListener<B, EffectBase> {
  ShowErrorSafeListener({
    super.child,
    super.bloc,
    super.key,
    String? Function(EffectBase)? messageBuilder,
    BlocPresentationWidgetListener<EffectBase>? delegateListener,
  }) : super(
         listener: (context, error) {
           if (delegateListener != null) {
             delegateListener(context, error);
             return;
           }
           ScaffoldMessenger.of(
             context,
           ).showSnackBar(SnackBar(content: Text(error.toString())));
         },
       );
}
