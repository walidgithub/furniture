import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture/presentation/about/view/about_view.dart';
import 'package:furniture/presentation/authentication/authCubit/auth_state.dart';
import 'package:furniture/presentation/location/view/location_view.dart';
import 'package:furniture/presentation/profile/view/profile_view.dart';
import 'package:furniture/presentation/resources/assets_manager.dart';
import 'package:furniture/presentation/resources/colors_manager.dart';
import 'package:furniture/presentation/resources/language_manager.dart';
import 'package:furniture/presentation/resources/strings_manager.dart';
import 'package:furniture/presentation/resources/values_manager.dart';
import '../core/services/service_locator.dart';
import 'authentication/authCubit/auth_cubit.dart';
import 'components/nav_bar.dart';
import 'home_page/view/home_view.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  List<Widget> pages = [
    const HomeView(),
    const LocationView(),
    const ProfileView(),
    const AboutView()
  ];

  List<String> titles = [
    AppStrings.home.tr(),
    AppStrings.location.tr(),
    AppStrings.profile.tr(),
    AppStrings.about.tr(),
  ];

  var _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: pages[_currentPage],
        key: scaffoldKey,
        drawer: NavBar(),
        backgroundColor: Theme.of(context).hintColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).hintColor,
          elevation: 0,
          leading: Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppPadding.p10, AppPadding.p10, 0, 0),
              child: GestureDetector(
                  onTap: () {
                    scaffoldKey.currentState?.openDrawer();
                  },
                  child: SvgPicture.asset(ImageAssets.menuImage))),
          actions: [
            BlocProvider(
              create: (context) => sl<AuthCubit>()..getCurrentUser(),
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is NoInternetState) {
                    return Padding(
                        padding: isRtl()
                            ? const EdgeInsets.fromLTRB(
                                AppPadding.p10, AppPadding.p8, 0, AppPadding.p2)
                            : const EdgeInsets.fromLTRB(0, AppPadding.p8,
                                AppPadding.p10, AppPadding.p2),
                        child: SizedBox(
                            height: 60,
                            width: 60,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s25),
                                  color: Colors.transparent),
                              child: SvgPicture.asset(
                                ImageAssets.profile,
                                color: ColorManager.darkBlack,
                              ),
                            )));
                  } else if (state is AuthGetCurrentUserLoadingState) {
                    return Padding(
                        padding: isRtl()
                            ? const EdgeInsets.fromLTRB(
                                AppPadding.p10, AppPadding.p8, 0, AppPadding.p2)
                            : const EdgeInsets.fromLTRB(0, AppPadding.p8,
                                AppPadding.p10, AppPadding.p2),
                        child: SizedBox(
                            height: 60,
                            width: 60,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s25),
                                  color: Colors.transparent),
                              child: SvgPicture.asset(
                                ImageAssets.profile,
                                color: ColorManager.darkBlack,
                              ),
                            )));
                  } else if (state is AuthGetUserDataState) {
                    return Padding(
                        padding: isRtl()
                            ? const EdgeInsets.fromLTRB(
                                AppPadding.p10, AppPadding.p8, 0, AppPadding.p2)
                            : const EdgeInsets.fromLTRB(0, AppPadding.p8,
                                AppPadding.p10, AppPadding.p2),
                        child: SizedBox(
                            height: 60,
                            width: 60,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        '${AuthCubit.get(context).user[0].photoUrl}'),
                                    fit: BoxFit.cover),
                              ),
                            )));
                  } else {
                    return const Text('Error');
                  }
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(color: ColorManager.secondary, spreadRadius: AppSize.s1)
          ]),
          child: BottomNavigationBar(
            selectedItemColor: Theme.of(context).backgroundColor,
            unselectedItemColor: ColorManager.secondary,
            currentIndex: _currentPage,
            onTap: onTap,
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    ImageAssets.home,
                    color: Theme.of(context).backgroundColor,
                    width: AppSize.s25,
                  ),
                  label: AppStrings.home.tr()),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    ImageAssets.location,
                    color: Theme.of(context).backgroundColor,
                    width: AppSize.s25,
                  ),
                  label: AppStrings.location.tr()),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    ImageAssets.profile,
                    color: Theme.of(context).backgroundColor,
                    width: AppSize.s25,
                  ),
                  label: AppStrings.profile.tr()),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    ImageAssets.about,
                    color: Theme.of(context).backgroundColor,
                    width: AppSize.s25,
                  ),
                  label: AppStrings.about.tr()),
            ],
          ),
        ),
      ),
    );
  }

  onTap(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }
}
