import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture/presentation/notification/cubit/notification_cubit.dart';
import 'package:furniture/presentation/resources/constants_manager.dart';
import 'package:readmore/readmore.dart';

import '../../../core/services/service_locator.dart';
import '../../resources/assets_manager.dart';
import '../../resources/colors_manager.dart';
import '../../resources/language_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';

import 'dart:math' as math;

import '../cubit/notification_state.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
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
              onTap:(){},
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
          AppStrings.notification.tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: bodyContent(context),
    ));
  }

  Widget bodyContent(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: BlocProvider(
          create: (context) => sl<NotificationCubit>()..showAllNotifications(),
          child: BlocConsumer<NotificationCubit, NotificationState>(
            listener: (context, state) {
              if (state is NotificationDeletedSucceededState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    AppStrings.successDeleted.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: ColorManager.white),
                  ),
                  duration: const Duration(seconds: 2),
                ));

                Future.delayed(const Duration(seconds: 2), () {
                  if (NotificationCubit.get(context).notificationsList.isEmpty){
                    Navigator.of(context).pushNamed(Routes.mainRoute);
                  }
                });
              } else if (state is NotificationDeletingErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    AppStrings.deletingError.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: ColorManager.white),
                  ),
                  duration: const Duration(seconds: 2),
                ));
              } else if (state is NotificationShowingErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    AppStrings.showNotificationError.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: ColorManager.white),
                  ),
                  duration: const Duration(seconds: 2),
                ));
              } else if (state is NotificationShowSucceededState) {
                NotificationCubit.get(context).showAllNotifications();
              }
            },
            builder: (context, state) {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:
                      NotificationCubit.get(context).notificationsList.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => cartDetails(index, context));
            },
          ),
        ),
      ),
    );
  }

  Widget cartDetails(int index, BuildContext context) {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      ImageAssets.notification,
                      color: ColorManager.darkBlack,
                    ),
                    const SizedBox(
                      width: AppConstants.smallDistance,
                    ),
                    Expanded(
                      child: ReadMoreText(
                        NotificationCubit.get(context).notificationsList[index]
                            ['notificationText'],
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  color: ColorManager.darkBlack,
                                ),
                        trimLines: 3,
                        colorClickableText: Theme.of(context).backgroundColor,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: AppStrings.readMore.tr(),
                        trimExpandedText: AppStrings.less.tr(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppConstants.heightBetweenElements,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          NotificationCubit.get(context).delete(
                              NotificationCubit.get(context)
                                  .notificationsList[index]['id']);

                        },
                        child: Icon(Icons.delete, color: ColorManager.error))
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: AppConstants.heightBetweenElements,
        )
      ],
    );
  }

  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }
}
