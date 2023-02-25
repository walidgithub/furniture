import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture/presentation/resources/strings_manager.dart';

import 'dart:math' as math;

import '../../../core/app_prefs.dart';
import '../../../core/services/service_locator.dart';
import '../authentication/authCubit/auth_cubit.dart';
import '../authentication/authCubit/auth_state.dart';
import '../resources/assets_manager.dart';
import '../resources/colors_manager.dart';
import '../resources/language_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/values_manager.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final AppPreferences _appPreferences = sl<AppPreferences>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          BlocProvider(
            create: (context) => sl<AuthCubit>()..getCurrentUser(),
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is NoInternetState) {
                  return UserAccountsDrawerHeader(
                    accountName:
                        Text('', style: Theme.of(context).textTheme.bodyMedium),
                    accountEmail:
                        Text('', style: Theme.of(context).textTheme.bodyMedium),
                    currentAccountPicture: CircleAvatar(
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s25),
                            color: Colors.transparent),
                        child: SvgPicture.asset(
                          ImageAssets.profile,
                          color: ColorManager.darkBlack,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        // color: Colors.blue,
                        image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.dstATop),
                      image: const AssetImage(
                        ImageAssets.drawer,
                      ),
                      fit: BoxFit.cover,
                    )),
                  );
                } else if (state is AuthGetCurrentUserLoadingState) {
                  return UserAccountsDrawerHeader(
                    accountName:
                        Text('', style: Theme.of(context).textTheme.bodyMedium),
                    accountEmail:
                        Text('', style: Theme.of(context).textTheme.bodyMedium),
                    currentAccountPicture: CircleAvatar(
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s25),
                            color: Colors.transparent),
                        child: SvgPicture.asset(
                          ImageAssets.profile,
                          color: ColorManager.darkBlack,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        // color: Colors.blue,
                        image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.dstATop),
                      image: const AssetImage(
                        ImageAssets.drawer,
                      ),
                      fit: BoxFit.cover,
                    )),
                  );
                } else if (state is AuthGetUserDataState) {
                  return UserAccountsDrawerHeader(
                    accountName: Text('${AuthCubit.get(context).user[0].name}',
                        style: Theme.of(context).textTheme.bodyMedium),
                    accountEmail: Text(
                        '${AuthCubit.get(context).user[0].email}',
                        style: Theme.of(context).textTheme.bodyMedium),
                    currentAccountPicture: CircleAvatar(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  '${AuthCubit.get(context).user[0].photoUrl}'),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        // color: Colors.blue,
                        image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.dstATop),
                      image: const AssetImage(
                        ImageAssets.drawer,
                      ),
                      fit: BoxFit.cover,
                    )),
                  );
                } else {
                  return const Text('Error');
                }
              },
            ),
          ),
          ListTile(
            leading: SvgPicture.asset(
              ImageAssets.cart,
              color: Theme.of(context).backgroundColor,
              width: AppSize.s25,
            ),
            title: Text(AppStrings.cart.tr(),
                style: Theme.of(context).textTheme.bodyLarge),
            onTap: () {
              Navigator.of(context).pushNamed(Routes.allCartsRoute);
            },
          ),
          const Divider(),
          ListTile(
            leading: SvgPicture.asset(
              ImageAssets.notification,
              color: Theme.of(context).backgroundColor,
              width: AppSize.s25,
            ),
            title: Text(AppStrings.notification.tr(),
                style: Theme.of(context).textTheme.bodyLarge),
            onTap: () {
              Navigator.of(context).pushNamed(Routes.notificationRoute);
            },
          ),
          const Divider(),
          ListTile(
            leading: SvgPicture.asset(
              ImageAssets.settings,
              color: ColorManager.grey,
              width: AppSize.s25,
            ),
            title: Text(AppStrings.settings.tr(),
                style: Theme.of(context).textTheme.bodyLarge),
            onTap: () {
              Navigator.of(context).pushNamed(Routes.settingsRoute);
            },
          ),
          const Divider(),
          BlocProvider(
            create: (context) => sl<AuthCubit>(),
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return ListTile(
                  leading: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
                    child: SvgPicture.asset(
                      ImageAssets.logout,
                      color: ColorManager.darkBlack,
                      width: AppSize.s28,
                    ),
                  ),
                  title: Text(AppStrings.logout.tr(),
                      style: Theme.of(context).textTheme.bodyLarge),
                  onTap: () {
                    _appPreferences.logout();
                    AuthCubit.get(context).userLogout();
                    Navigator.of(context)
                        .pushReplacementNamed(Routes.loginRoute);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }
}
