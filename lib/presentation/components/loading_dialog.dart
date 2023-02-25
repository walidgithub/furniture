import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:furniture/presentation/resources/assets_manager.dart';
import 'package:furniture/presentation/resources/constants_manager.dart';
import 'package:furniture/presentation/resources/strings_manager.dart';
import 'package:lottie/lottie.dart';

import '../resources/values_manager.dart';

class LoadingDialog extends StatefulWidget {
  static void show(BuildContext context) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => const LoadingDialog(),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.of(context).pop();

  const LoadingDialog({super.key});

  @override
  State<LoadingDialog> createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Container(
          height: 250,
          width: 300,
          decoration: BoxDecoration(
              color: Theme.of(context).hintColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(AppSize.s14),
              boxShadow: const [BoxShadow(color: Colors.black26)]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: AppSize.s100,
                  width: AppSize.s100,
                  child: Lottie.asset(JsonAssets.loading)),
              const SizedBox(
                height: AppConstants.bigHeightBetweenElements,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: Text(
                    AppStrings.loading.tr(),
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
