import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:furniture/presentation/resources/colors_manager.dart';
import 'package:furniture/presentation/resources/constants_manager.dart';
import 'package:lottie/lottie.dart';

import '../resources/assets_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';

Widget errorMessage(){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(
        height: AppConstants.bigHeightBetweenElements,
      ),
      SizedBox(
          height: AppSize.s100,
          width: AppSize.s100,
          child: Lottie.asset(JsonAssets.checkError('somethingError'))),
      Center(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            AppStrings.checkFields('somethingError').tr(),
            style: TextStyle(fontSize: AppSize.s20,color: ColorManager.darkBlack),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ],
  );
}