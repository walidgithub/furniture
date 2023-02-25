import 'package:flutter/material.dart';
import 'package:furniture/presentation/resources/styles_manager.dart';
import 'package:furniture/presentation/resources/values_manager.dart';

import 'colors_manager.dart';
import 'font_manager.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: ColorManager.primary,
  primaryColorLight: ColorManager.lightPrimary,
  primaryColorDark: ColorManager.secondPrimary,
  disabledColor: ColorManager.grey1,
  splashColor: ColorManager.lightPrimary,
  backgroundColor: ColorManager.darkBlack,
  hintColor: ColorManager.white,
  // ripple effect color
  // cardview theme
  cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4),
  // app bar theme
  appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: AppSize.s4,
      shadowColor: ColorManager.lightPrimary,
      titleTextStyle:
          getRegularStyle(fontSize: FontSize.s16, color: ColorManager.white)),
  // button theme
  buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.lightPrimary),

  // elevated button them
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          textStyle: getRegularStyle(
              color: ColorManager.white, fontSize: FontSize.s17),
          backgroundColor: ColorManager.darkBlack,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s18)))),

  textTheme: TextTheme(
    displayLarge:
        getSemiBoldStyle(color: ColorManager.black, fontSize: FontSize.s22),
    headlineLarge:
        getSemiBoldStyle(color: ColorManager.black, fontSize: FontSize.s16),
    headlineMedium:
        getRegularStyle(color: ColorManager.secondary, fontSize: FontSize.s14),
    titleSmall:
        getSemiBoldStyle(color: ColorManager.white, fontSize: FontSize.s16),
    bodySmall:
        getSemiBoldStyle(color: ColorManager.darkBlack, fontSize: FontSize.s12),
    bodyMedium:
        getSemiBoldStyle(color: ColorManager.darkBlack, fontSize: FontSize.s16),
    bodyLarge:
        getSemiBoldStyle(color: ColorManager.darkBlack, fontSize: FontSize.s20),
    labelSmall:
        getSemiBoldStyle(color: ColorManager.white, fontSize: FontSize.s16),
    displaySmall:
        getRegularStyle(color: ColorManager.white, fontSize: FontSize.s14),
  ),

  // input decoration theme (text form field)
  inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorManager.primary,
      // content padding
      contentPadding: const EdgeInsets.all(AppPadding.p20),
      // hint style
      hintStyle:
          getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),
      labelStyle:
          getMediumStyle(color: ColorManager.grey, fontSize: FontSize.s14),
      errorStyle: getRegularStyle(color: ColorManager.error),

      // enabled border style
      enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s18))),
      //

      // // focused border style
      focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.secondary, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s18))),

      // // error border style
      errorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.error, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s18))),
      // // focused border style
      focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.secondary, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s18)))),
);

ThemeData darkTheme = ThemeData(
  primaryColor: ColorManager.primary,
  primaryColorLight: ColorManager.lightPrimary,
  primaryColorDark: ColorManager.secondPrimary,
  disabledColor: ColorManager.grey1,
  splashColor: ColorManager.lightPrimary,
  backgroundColor: ColorManager.darkBlack,
  hintColor: ColorManager.white,
  // ripple effect color
  // cardview theme
  cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4),
  // app bar theme
  appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: AppSize.s4,
      shadowColor: ColorManager.lightPrimary,
      titleTextStyle:
      getRegularStyle(fontSize: FontSize.s16, color: ColorManager.white)),
  // button theme
  buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.lightPrimary),

  // elevated button them
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          textStyle: getRegularStyle(
              color: ColorManager.white, fontSize: FontSize.s17),
          backgroundColor: ColorManager.darkBlack,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s18)))),

  textTheme: TextTheme(
    displayLarge:
    getSemiBoldStyle(color: ColorManager.black, fontSize: FontSize.s22),
    headlineLarge:
    getSemiBoldStyle(color: ColorManager.black, fontSize: FontSize.s16),
    headlineMedium:
    getRegularStyle(color: ColorManager.secondary, fontSize: FontSize.s14),
    titleSmall:
    getSemiBoldStyle(color: ColorManager.white, fontSize: FontSize.s16),
    bodySmall:
    getSemiBoldStyle(color: ColorManager.darkBlack, fontSize: FontSize.s12),
    bodyMedium:
    getSemiBoldStyle(color: ColorManager.darkBlack, fontSize: FontSize.s16),
    bodyLarge:
    getSemiBoldStyle(color: ColorManager.darkBlack, fontSize: FontSize.s20),
    labelSmall:
    getSemiBoldStyle(color: ColorManager.white, fontSize: FontSize.s16),
    displaySmall:
    getRegularStyle(color: ColorManager.white, fontSize: FontSize.s14),
  ),

  // input decoration theme (text form field)
  inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorManager.primary,
      // content padding
      contentPadding: const EdgeInsets.all(AppPadding.p20),
      // hint style
      hintStyle:
      getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),
      labelStyle:
      getMediumStyle(color: ColorManager.grey, fontSize: FontSize.s14),
      errorStyle: getRegularStyle(color: ColorManager.error),

      // enabled border style
      enabledBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s18))),
      //

      // // focused border style
      focusedBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: ColorManager.secondary, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s18))),

      // // error border style
      errorBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: ColorManager.error, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s18))),
      // // focused border style
      focusedErrorBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: ColorManager.secondary, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s18)))),
);
