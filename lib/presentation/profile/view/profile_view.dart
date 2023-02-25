import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture/presentation/resources/colors_manager.dart';
import 'package:furniture/presentation/resources/values_manager.dart';

import '../../../core/services/service_locator.dart';
import '../../authentication/authCubit/auth_cubit.dart';
import '../../authentication/authCubit/auth_state.dart';
import '../../resources/assets_manager.dart';
import '../../resources/constants_manager.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).hintColor,
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              painter: HeaderCurvedContainer(),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 150,
              ),
            ),
            BlocProvider(
              create: (context) => sl<AuthCubit>()..getCurrentUser(),
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthGetCurrentUserLoadingState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                                border: Border.all(color: Theme.of(context).hintColor,width: AppSize.s8),
                                shape: BoxShape.circle,
                                color: Theme.of(context).hintColor),
                            child: SvgPicture.asset(
                              ImageAssets.profile,
                              color: ColorManager.darkBlack,
                            )),
                        const SizedBox(
                          height: AppConstants.heightBetweenElements,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              AppPadding.p20, AppPadding.p50, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    ImageAssets.user,
                                    color: ColorManager.darkBlack,
                                  ),
                                  const SizedBox(
                                    width: AppConstants.widthBetweenElements,
                                  ),
                                  Text(
                                    '',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: AppConstants.heightBetweenElements,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    ImageAssets.email,
                                    color: ColorManager.darkBlack,
                                    width: AppSize.s20,
                                  ),
                                  const SizedBox(
                                    width: AppConstants.widthBetweenElements,
                                  ),
                                  Text(
                                    '',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: AppConstants.heightBetweenElements,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    ImageAssets.work,
                                    color: ColorManager.darkBlack,
                                  ),
                                  const SizedBox(
                                    width: AppConstants.widthBetweenElements,
                                  ),
                                  Text(
                                    'Developer',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: AppConstants.heightBetweenElements,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    ImageAssets.location,
                                    color: ColorManager.darkBlack,
                                  ),
                                  const SizedBox(
                                    width: AppConstants.widthBetweenElements,
                                  ),
                                  Text(
                                    'Egypt',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else if (state is NoInternetState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                              border: Border.all(color: Theme.of(context).hintColor,width: AppSize.s8),
                              shape: BoxShape.circle,
                              color: Theme.of(context).hintColor),
                          child: SvgPicture.asset(
                            ImageAssets.profile,
                            color: ColorManager.darkBlack,
                          ),
                        ),
                        const SizedBox(
                          height: AppConstants.heightBetweenElements,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              AppPadding.p20, AppPadding.p50, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    ImageAssets.user,
                                    color: ColorManager.darkBlack,
                                  ),
                                  const SizedBox(
                                    width: AppConstants.widthBetweenElements,
                                  ),
                                  Text(
                                    '',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: AppConstants.heightBetweenElements,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    ImageAssets.email,
                                    color: ColorManager.darkBlack,
                                    width: AppSize.s20,
                                  ),
                                  const SizedBox(
                                    width: AppConstants.widthBetweenElements,
                                  ),
                                  Text(
                                    '',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: AppConstants.heightBetweenElements,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    ImageAssets.work,
                                    color: ColorManager.darkBlack,
                                  ),
                                  const SizedBox(
                                    width: AppConstants.widthBetweenElements,
                                  ),
                                  Text(
                                    'Developer',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: AppConstants.heightBetweenElements,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    ImageAssets.location,
                                    color: ColorManager.darkBlack,
                                  ),
                                  const SizedBox(
                                    width: AppConstants.widthBetweenElements,
                                  ),
                                  Text(
                                    'Egypt',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else if (state is AuthGetUserDataState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                              border: Border.all(color: Theme.of(context).hintColor,width: AppSize.s8),
                              shape: BoxShape.circle,
                              color: Theme.of(context).hintColor,
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    '${AuthCubit.get(context).user[0].photoUrl}'),
                                fit: BoxFit.cover,
                              )),
                        ),
                        const SizedBox(
                          height: AppConstants.heightBetweenElements,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              AppPadding.p20, AppPadding.p50, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    ImageAssets.user,
                                    color: ColorManager.darkBlack,
                                  ),
                                  const SizedBox(
                                    width: AppConstants.widthBetweenElements,
                                  ),
                                  Text(
                                    AuthCubit.get(context)
                                        .user[0]
                                        .name
                                        .toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: AppConstants.heightBetweenElements,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    ImageAssets.email,
                                    color: ColorManager.darkBlack,
                                    width: AppSize.s20,
                                  ),
                                  const SizedBox(
                                    width: AppConstants.widthBetweenElements,
                                  ),
                                  Text(
                                    AuthCubit.get(context)
                                        .user[0]
                                        .email
                                        .toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: AppConstants.heightBetweenElements,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    ImageAssets.work,
                                    color: ColorManager.darkBlack,
                                  ),
                                  const SizedBox(
                                    width: AppConstants.widthBetweenElements,
                                  ),
                                  Text(
                                    'Developer',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: AppConstants.heightBetweenElements,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    ImageAssets.location,
                                    color: ColorManager.darkBlack,
                                  ),
                                  const SizedBox(
                                    width: AppConstants.widthBetweenElements,
                                  ),
                                  Text(
                                    'Egypt',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Text('Error');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color.fromRGBO(39, 89, 110, 1.0);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 250.0, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
