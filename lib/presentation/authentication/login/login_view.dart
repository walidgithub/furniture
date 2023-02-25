import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture/presentation/resources/constants_manager.dart';
import 'package:furniture/presentation/resources/values_manager.dart';

import '../../../core/app_prefs.dart';
import '../../../core/services/service_locator.dart';
import '../../components/error_dialog.dart';
import '../../components/loading_dialog.dart';
import '../../resources/assets_manager.dart';
import '../../resources/colors_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../authCubit/auth_cubit.dart';
import '../authCubit/auth_state.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final AppPreferences _appPreferences = sl<AppPreferences>();

  final TextEditingController _emailEditingController = TextEditingController();

  final TextEditingController _passwordEditingController =
      TextEditingController();

  final _fbKey = GlobalKey<FormState>();

  bool revealPass = true;

  RegExp regexPassword =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  RegExp regexMail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoginLoadingState) {
            LoadingDialog.show(context);
          } else if (state is AuthLoginState) {
            LoadingDialog.hide(context);
            _appPreferences.setUserLoggedIn();
            Navigator.of(context).pushReplacementNamed(Routes.splashRoute);
          } else if (state is NoInternetState) {
            LoadingDialog.hide(context);
            ErrorDialog.show(context, 'noInternet');
          } else if (state is AuthLoginErrorState) {
            LoadingDialog.hide(context);
            ErrorDialog.show(context, 'userOrPassError');
          }
        },
        builder: (context, state) {
          return SafeArea(
              child: Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p18),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Furniture',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontSize: 30),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: AppConstants.bigHeightBetweenElements,
                      ),
                      Form(
                        key: _fbKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.loginToAccount.tr(),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(
                              height: AppConstants.heightBetweenElements,
                            ),
                            TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppStrings.checkFields('empty');
                                  }
                                  if (!regexMail.hasMatch(value)) {
                                    return AppStrings.checkFields(
                                        'notValidMail');
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailEditingController,
                                decoration: InputDecoration(
                                  hintText: AppStrings.email.tr(),
                                  prefixIcon: Icon(Icons.email,
                                      color: ColorManager.lightGrey),
                                  border: InputBorder.none,
                                )),
                            const SizedBox(
                              height: AppConstants.heightBetweenElements,
                            ),
                            TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppStrings.checkFields('empty');
                                  }
                                  if (!regexPassword.hasMatch(value)) {
                                    return AppStrings.checkFields(
                                        'checkPassword');
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: revealPass,
                                controller: _passwordEditingController,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: (){
                                      setState(() {
                                        revealPass = !revealPass;
                                      });
                                    },
                                    icon: revealPass ? Icon(Icons.visibility_off_outlined) : Icon(Icons.visibility),
                                  ),
                                  hintText: AppStrings.password.tr(),
                                  prefixIcon: Icon(Icons.key,
                                      color: ColorManager.lightGrey),
                                  border: InputBorder.none,
                                )),
                            const SizedBox(
                              height: AppConstants.heightBetweenElements,
                            ),
                            Bounceable(
                              onTap:(){},
                              child: GestureDetector(
                                onTap: () async {
                                  if (_fbKey.currentState!.validate()) {
                                    await AuthCubit.get(context).login(
                                        _emailEditingController.text,
                                        _passwordEditingController.text);
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: AppSize.s1,
                                        color: Theme.of(context).backgroundColor),
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s16),
                                    color: Theme.of(context).backgroundColor,
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        AppStrings.signIn.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              color: Theme.of(context).hintColor,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: AppConstants.bigHeightBetweenElements,
                      ),
                      Column(
                        children: [
                          Text(
                            AppStrings.orSignInWith.tr(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(
                            height: AppConstants.heightBetweenElements,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await AuthCubit.get(context).signInByGoogle();
                                },
                                child: SvgPicture.asset(
                                  ImageAssets.google,
                                  width: AppSize.s40,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: AppConstants.bigHeightBetweenElements,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppStrings.dontHaveAnAccount.tr(),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(
                                width: AppConstants.smallDistance,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      Routes.registerRoute);
                                },
                                child: Text(
                                  AppStrings.signUp.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: ColorManager.lightBlack),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ));
        },
      ),
    );
  }
}
