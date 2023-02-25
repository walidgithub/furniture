import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/app_prefs.dart';
import '../../../core/services/service_locator.dart';
import '../../resources/assets_manager.dart';
import '../../resources/colors_manager.dart';
import '../../resources/language_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/theme_manager.dart';
import '../../resources/values_manager.dart';

import 'dart:math' as math;

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final AppPreferences _appPreferences = sl<AppPreferences>();

  bool isTwoSwitched = false;

  final ThemeManager _themeManager = sl<ThemeManager>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).hintColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).hintColor,
        elevation: 0,
        leading: Padding(
            padding:
                const EdgeInsets.fromLTRB(AppPadding.p8, AppPadding.p8, 0, 0),
            child: Bounceable(
              onTap: (){},
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
                },
                child: Container(
                  height: 60,
                  width: 60,
                  padding: const EdgeInsets.all(AppPadding.p12),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: AppSize.s1, color: ColorManager.primary),
                      borderRadius: BorderRadius.circular(AppSize.s12),
                      color: ColorManager.primary),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
                    child: SvgPicture.asset(
                      ImageAssets.back,
                      color: ColorManager.grey,
                    ),
                  ),
                ),
              ),
            )),
        title: Text(
          AppStrings.settings.tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: bodyContent(),
    ));
  }

  Widget bodyContent() {
    return Center(
      child: ListView(
        padding: const EdgeInsets.all(AppPadding.p8),
        children: [
          ListTile(
            leading: SvgPicture.asset(
              ImageAssets.changeLangIc,
              color: Theme.of(context).backgroundColor,
              width: AppSize.s25,
            ),
            title: Text(AppStrings.changeLang.tr(),
                style: Theme.of(context).textTheme.bodyLarge),
            trailing: Switch(
              value: AppPreferences.isLangChanged,
              onChanged: (value) {
                setState(() {
                  _changeLanguage();
                });
              },
              activeTrackColor: ColorManager.secondary,
              activeColor: Theme.of(context).backgroundColor,
            ),
          ),
          ListTile(
            leading: SvgPicture.asset(
              _themeManager.themeMode == ThemeMode.dark
                  ? ImageAssets.darkThemeMode
                  : ImageAssets.lightThemeMode,
              color: Theme.of(context).backgroundColor,
              width: AppSize.s25,
            ),
            title: Text(
                _themeManager.themeMode == ThemeMode.dark
                    ? AppStrings.darkMode.tr()
                    : AppStrings.lightMode.tr(),
                style: Theme.of(context).textTheme.bodyLarge),
            trailing: Switch(
              value: _themeManager.themeMode == ThemeMode.dark,
              onChanged: (value) {
                _themeManager.toggleTheme(value);
                setState(() {
                  isTwoSwitched = value;
                });
              },
              activeTrackColor: ColorManager.secondary,
              activeColor: Theme.of(context).backgroundColor,
            ),
          ),
        ],
      ),
    );
  }

  _changeLanguage() {
    _appPreferences.changeAppLanguage();
    Phoenix.rebirth(context);
  }

  bool isRtl() {
    print('hereeeeeeeeeeee');
    return context.locale == ARABIC_LOCAL;
  }
}
