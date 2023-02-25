import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture/presentation/authentication/authCubit/auth_state.dart';
import 'package:furniture/presentation/notification/dbHelper.dart';
import 'package:furniture/presentation/resources/constants_manager.dart';

import '../../../core/services/service_locator.dart';
import '../../../core/utils/enums.dart';
import '../../../domain/model/models.dart';
import '../../components/error_widget.dart';
import '../../notification/cubit/notification_cubit.dart';
import '../../notification/cubit/notification_state.dart';
import '../../resources/assets_manager.dart';
import '../../resources/colors_manager.dart';
import '../../resources/language_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import '../bloc/cart_bloc.dart';
import 'package:flutter/services.dart';

import 'dart:math' as math;

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
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
          AppStrings.carts.tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: bodyContent(),
    ));
  }

  Widget bodyContent() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: BlocProvider(
              create: (context) => sl<CartBloc>()..add(GetAllCartsEvent()),
              child: BlocBuilder<CartBloc, CartState>(
                buildWhen: (previous, current) =>
                    previous.cartState != current.cartState,
                builder: (context, state) {
                  switch (state.cartState) {
                    case RequestState.loading:
                      return const SizedBox(
                          height: 400,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ));
                    case RequestState.loaded:
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.cartList.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) =>
                              cartDetails(index, state));
                    case RequestState.error:
                      return errorMessage();
                  }
                },
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => sl<NotificationCubit>()..checkInternet(),
          child: BlocConsumer<NotificationCubit, NotificationState>(
            listener: (context, state) {
              if (state is NotificationSentSucceededState) {
                Navigator.of(context).pushNamed(Routes.mainRoute);
              } else if (state is NotificationErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    AppStrings.notificationNotSent.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: ColorManager.white),
                  ),
                  duration: const Duration(seconds: 2),
                ));
              }
            },
            builder: (context, state) {
              if (state is NotificationNoInternetState) {
                return Container();
              } else {
                return Bounceable(
                  onTap: (){},
                  child: GestureDetector(
                    onTap: () async {
                      NotificationModel notificationModel = NotificationModel({
                        'notificationText': 'Hey you have a new notification',
                        'userName': 'walid barakat'
                      });
                      await NotificationCubit.get(context)
                          .sendNotification(notificationModel);
                    },
                    child: Container(
                      width: 230,
                      height: 70,
                      margin: const EdgeInsets.only(bottom: AppSize.s20),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: AppSize.s1,
                            color: Theme.of(context).backgroundColor),
                        borderRadius: BorderRadius.circular(AppSize.s16),
                        color: ColorManager.darkBlack,
                        shape: BoxShape.rectangle,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            AppStrings.checkOut.tr(),
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Theme.of(context).hintColor,
                                    ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            padding: const EdgeInsets.all(AppPadding.p8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: AppSize.s1,
                                    color: Theme.of(context).backgroundColor),
                                borderRadius: BorderRadius.circular(AppSize.s25),
                                color: Theme.of(context).hintColor),
                            child: SvgPicture.asset(
                              ImageAssets.checkout,
                              color: Theme.of(context).backgroundColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget cartDetails(int index, CartState state) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Column(
        children: [
          Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                border: Border.all(
                    width: AppSize.s1, color: Theme.of(context).hintColor),
                borderRadius: BorderRadius.circular(AppSize.s25),
                color: Theme.of(context).hintColor,
                shape: BoxShape.rectangle,
                image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        state.cartList[index].image.toString()),
                    fit: BoxFit.fill),
              )),
          const SizedBox(
            height: AppConstants.heightBetweenElements,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    AppStrings.productName.tr(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: AppConstants.smallDistance,
                  ),
                  Text(
                    state.cartList[index].title.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: ColorManager.grey),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    AppStrings.price.tr(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: AppConstants.smallDistance,
                  ),
                  Row(
                    children: [
                      Text('\$',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: ColorManager.price,
                                  )),
                      Text(
                        state.cartList[index].price.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: ColorManager.price),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    AppStrings.productCount.tr(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: AppConstants.smallDistance,
                  ),
                  Text(
                    state.cartList[index].count.toString(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: AppConstants.heightBetweenElements,
          ),
          Divider(
            color: Theme.of(context).backgroundColor,
          )
        ],
      ),
    );
  }

  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }
}
