import 'package:smart_garden/di/di_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/index.dart';
import 'bloc/index.dart';

abstract class BaseState<W extends StatefulWidget, E, S extends BaseBlocState,
B extends BaseBloc<E, S>> extends State<W> with BaseMethodMixin<S> {
  late B bloc;

  B provideBloc(BuildContext context) {
    return getIt.get<B>();
  }

  void initBloc(BuildContext context) {
    bloc = provideBloc(context);
  }

  Widget blocBuilder(
      Widget Function(BuildContext context, S state) builder, {
        bool Function(S previous, S current)? buildWhen,
      }) {
    return BlocBuilder<B, S>(
      bloc: bloc,
      buildWhen: buildWhen,
      builder: builder,
    );
  }

  @override
  void initState() {
    // bloc = getIt.get<B>();
    initBloc(context);
    /*
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      if (!mounted) return;
      context.pushNamed(
        Routes.forgotPasswordDynamicLink,
        params: {
          RouterParamConstants.deepLink: dynamicLinkData.link.toString()
        },
      );
    }).onError((error) {
      //DO NOTHING
      injector<LogUtils>().logD(error.toString());
    });
    */

    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  // void showMessage(String message, {type = SnackBarType.success}) {
  //   final SnackBarHelper helper = getIt<SnackBarHelper>();
  //   switch (type) {
  //     case SnackBarType.error:
  //       helper.showError(context, message);
  //       break;
  //     case SnackBarType.info:
  //       helper.showInfo(context, message);
  //       break;
  //     default:
  //       helper.showSuccess(context, message);
  //       break;
  //   }
  // }
  //
  // bool listenWhen(S previous, S current) {
  //   return previous != current ||
  //       previous.status != current.status ||
  //       previous.message != current.message;
  // }
  //
  // void listener(BuildContext context, S state) {
  //   if (state.status == BaseStateStatus.failed) {
  //     showMessage(state.message ?? "");
  //   }
  // }

  @required
  Widget renderUI(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<B, S>(
        listenWhen: listenWhen,
        listener: listener,
        child: renderUI(context),
      ),
    );
  }
}

abstract class BaseShareState<
W extends StatefulWidget,
E,
S extends BaseBlocState,
B extends BaseBloc<E, S>> extends State<W> with BaseMethodMixin<S> {
  late B bloc;

  B provideBloc(BuildContext context) {
    return getIt.get<B>();
  }

  void initBloc(BuildContext context) {
    bloc = provideBloc(context);
  }

  @override
  void initState() {
    initBloc(context);
    /*
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      if (!mounted) return;
      context.pushNamed(
        Routes.forgotPasswordDynamicLink,
        params: {
          RouterParamConstants.deepLink: dynamicLinkData.link.toString()
        },
      );
    }).onError((error) {
      //DO NOTHING
      injector<LogUtils>().logD(error.toString());
    });
    */

    super.initState();
  }

  Widget blocBuilder(
      Widget Function(BuildContext c, S) builder, [
        bool Function(S, S)? buildWhen,
      ]) {
    return BlocBuilder<B, S>(
      bloc: bloc,
      buildWhen: buildWhen,
      builder: builder,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  // void showMessage(String message, {type = SnackBarType.success}) {
  //   final SnackBarHelper helper = getIt<SnackBarHelper>();
  //   switch (type) {
  //     case SnackBarType.error:
  //       helper.showError(context, message);
  //       break;
  //     case SnackBarType.info:
  //       helper.showInfo(context, message);
  //       break;
  //     default:
  //       helper.showSuccess(context, message);
  //       break;
  //   }
  // }
  //
  // bool listenWhen(S previous, S current) {
  //   return previous != current ||
  //       previous.status != current.status ||
  //       previous.message != current.message;
  // }
  //
  // void listener(BuildContext context, S state) {
  //   if (state.status == BaseStateStatus.failed) {
  //     showMessage(state.message ?? "");
  //   }
  // }

  @required
  Widget renderUI(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocListener<B, S>(
        listenWhen: listenWhen,
        listener: listener,
        child: renderUI(context),
      ),
    );
  }
}

mixin BaseMethodMixin<S extends BaseBlocState> {
  void showMessage(
      BuildContext context,
      String message, {
        type = SnackBarType.success,
        int duration = Config.defaultDurationShowToast,
      }) {
    final SnackBarHelper helper = getIt<SnackBarHelper>();
    switch (type) {
      case SnackBarType.error:
        helper.showError(context, message,);
        break;
      case SnackBarType.info:
        helper.showInfo(context, message);
        break;
      default:
        helper.showSuccess(context, message);
        break;
    }
  }

  bool listenWhen(S previous, S current) {
    return previous != current ||
        previous.status != current.status ||
        previous.message != current.message;
  }

  void listener(BuildContext context, S state) {
    if (state.status == BaseStateStatus.loading) {
      DialogService.showLoading();
    } else {
      DialogService.hideLoading();
    }
  }
}
