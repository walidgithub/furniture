import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:furniture/presentation/resources/assets_manager.dart';
import 'package:furniture/presentation/resources/strings_manager.dart';
import 'package:lottie/lottie.dart';

import '../resources/values_manager.dart';


class ErrorDialog extends StatefulWidget {
  String errorName;

  static void show(BuildContext context, String errorName) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => ErrorDialog(
          errorName: errorName,
        ),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.of(context).pop();

  ErrorDialog({required this.errorName, super.key});

  @override
  State<ErrorDialog> createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ErrorDialog> {
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
                  child: Lottie.asset(JsonAssets.checkError(widget.errorName))),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: Text(
                    AppStrings.checkFields(widget.errorName).tr(),
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p18),
                  child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(AppStrings.close.tr()))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
