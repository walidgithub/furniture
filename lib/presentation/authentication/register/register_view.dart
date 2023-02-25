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

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final AppPreferences _appPreferences = sl<AppPreferences>();

  final TextEditingController _emailEditingController = TextEditingController();

  final TextEditingController _nameEditingController = TextEditingController();

  final TextEditingController _passwordEditingController =
      TextEditingController();

  final TextEditingController _confirmPasswordEditingController =
      TextEditingController();

  final _fbKey = GlobalKey<FormState>();

  bool revealPass = true;

  bool revealConfirmPass = true;

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
          if (state is AuthRegisterLoadingState) {
            LoadingDialog.show(context);
          } else if (state is AuthErrorInRegisterState) {
            LoadingDialog.hide(context);
            ErrorDialog.show(context, 'foundSameEmail');
          } else if (state is AuthRegisterSucceededState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                AppStrings.successfullyRegistered.tr(),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: ColorManager.white),
              ),
              duration: const Duration(seconds: 2),
            ));

            Future.delayed(const Duration(seconds: 3), () {
              LoadingDialog.hide(context);
            });

            Future.delayed(const Duration(seconds: 5), () {
              Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
            });

          } else if (state is NoInternetState) {
            ErrorDialog.show(context, 'noInternet');
          } else if (state is AuthErrorLoadingImageState) {
            ErrorDialog.show(context, 'imageError');
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
                      Form(
                          key: _fbKey,
                          child: Column(
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppStrings.createYourAccount.tr(),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  const SizedBox(
                                    height: AppConstants.heightBetweenElements,
                                  ),
                                  TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return AppStrings.checkFields(
                                              'empty');
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.text,
                                      controller: _nameEditingController,
                                      decoration: InputDecoration(
                                        hintText: AppStrings.name.tr(),
                                        prefixIcon: Icon(
                                          Icons.account_circle,
                                          color: ColorManager.lightGrey,
                                        ),
                                        border: InputBorder.none,
                                      )),
                                  const SizedBox(
                                    height: AppConstants.heightBetweenElements,
                                  ),
                                  TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return AppStrings.checkFields(
                                              'empty');
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
                                          return AppStrings.checkFields(
                                              'empty');
                                        }
                                        if (!regexPassword.hasMatch(value)) {
                                          return AppStrings.checkFields(
                                              'checkPassword');
                                        } else {
                                          return null;
                                        }
                                      },

                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      obscureText: revealPass,
                                      controller: _passwordEditingController,
                                      decoration: InputDecoration(
                                        hintText: AppStrings.password.tr(),
                                        suffixIcon: IconButton(
                                          onPressed: (){
                                            setState(() {
                                              revealPass = !revealPass;
                                            });
                                          },
                                          icon: revealPass ? Icon(Icons.visibility_off_outlined) : Icon(Icons.visibility),
                                        ),
                                        prefixIcon: Icon(Icons.key,
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
                                      if (value !=
                                          _passwordEditingController.text) {
                                        return AppStrings.checkFields(
                                            'checkMainPassword');
                                      }
                                      if (!regexPassword.hasMatch(value)) {
                                        return AppStrings.checkFields(
                                            'checkPassword');
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.visiblePassword,
                                    controller:
                                        _confirmPasswordEditingController,
                                    obscureText: revealConfirmPass,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        onPressed: (){
                                          setState(() {
                                            revealConfirmPass = !revealConfirmPass;
                                          });
                                        },
                                        icon: revealConfirmPass ? Icon(Icons.visibility_off_outlined) : Icon(Icons.visibility),
                                      ),
                                      hintText: AppStrings.confirmPassword.tr(),
                                      prefixIcon: Icon(Icons.key,
                                          color: ColorManager.lightGrey),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: AppConstants.heightBetweenElements,
                                  ),
                                  Bounceable(
                                    onTap: (){},
                                    child: GestureDetector(
                                      onTap: () {
                                        AuthCubit.get(context).image('cam');
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: AppSize.s1,
                                              color: Theme.of(context)
                                                  .backgroundColor),
                                          borderRadius:
                                              BorderRadius.circular(AppSize.s16),
                                          color: Theme.of(context).indicatorColor,
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              AppStrings.pickPhoto.tr(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: AppConstants.heightBetweenElements,
                                  ),
                                  Bounceable(
                                    onTap:(){},
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (_fbKey.currentState!.validate()) {
                                          await AuthCubit.get(context)
                                              .registerByEmailAndPassword(
                                                  _emailEditingController.text,
                                                  _passwordEditingController.text,
                                                  _nameEditingController.text);
                                        }
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: AppSize.s1,
                                              color: Theme.of(context)
                                                  .backgroundColor),
                                          borderRadius:
                                              BorderRadius.circular(AppSize.s16),
                                          color:
                                              Theme.of(context).backgroundColor,
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              AppStrings.signUp.tr(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: AppConstants.bigHeightBetweenElements,
                      ),
                      // Column(
                      //   children: [
                      //     Text(
                      //       AppStrings.orSignUpWith.tr(),
                      //       style: Theme.of(context).textTheme.bodyMedium,
                      //     ),
                      //     const SizedBox(
                      //       height: AppConstants.heightBetweenElements,
                      //     ),
                      //     Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //       children: [
                      //         GestureDetector(
                      //           onTap: () async {
                      //
                      //           },
                      //           child: SvgPicture.asset(
                      //             ImageAssets.google,
                      //             width: AppSize.s40,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // )
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
