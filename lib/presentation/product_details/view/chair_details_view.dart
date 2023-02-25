import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture/presentation/resources/constants_manager.dart';
import 'package:furniture/presentation/resources/strings_manager.dart';
import 'package:readmore/readmore.dart';

import '../../../core/services/service_locator.dart';
import '../../../core/utils/enums.dart';
import '../../components/error_dialog.dart';
import '../../components/error_widget.dart';
import '../../cubit/interact_cubit.dart';
import '../../cubit/interact_state.dart';
import '../../resources/assets_manager.dart';
import '../../resources/colors_manager.dart';
import '../../resources/language_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/values_manager.dart';
import '../bloc/chair_details_bloc.dart';

import 'dart:math' as math;

class ChairDetailsView extends StatefulWidget {
  int idChair;

  ChairDetailsView({Key? key, required this.idChair}) : super(key: key);

  @override
  State<ChairDetailsView> createState() => _ChairDetailsViewState();
}

class _ChairDetailsViewState extends State<ChairDetailsView> {
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
                    )),
              ),
            )),
        title: Text(
          AppStrings.details.tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: bodyContent(context),
    ));
  }

  BlocProvider<ChairDetailsBloc> bodyContent(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<ChairDetailsBloc>()..add(GetChairDetailsEvent(widget.idChair)),
      child: BlocBuilder<ChairDetailsBloc, ChairDetailsState>(
        buildWhen: (previous, current) =>
            previous.chairDetailsState != current.chairDetailsState,
        builder: (context, state) {
          switch (state.chairDetailsState) {
            case RequestState.loading:
              return const SizedBox(
                  height: 400,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ));
            case RequestState.error:
              return errorMessage();
            case RequestState.loaded:
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(AppPadding.p8),
                          child: Container(
                              height: 350,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: AppSize.s1,
                                    color: Theme.of(context).hintColor),
                                borderRadius:
                                    BorderRadius.circular(AppSize.s25),
                                color: Theme.of(context).hintColor,
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(state
                                        .chairDetailsList[0].image
                                        .toString()),
                                    fit: BoxFit.fill),
                              )),
                        ),
                        Positioned(
                            top: 280,
                            left: isRtl() ? 0 : 255,
                            child: Container(
                                width: 110,
                                height: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: AppSize.s1,
                                      color: Theme.of(context).hintColor),
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s16),
                                  color: Theme.of(context).hintColor,
                                  shape: BoxShape.rectangle,
                                ))),
                        Positioned(
                            top: 285,
                            left: isRtl() ? 10 : 260,
                            child: Container(
                                width: 95,
                                height: 75,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: AppSize.s1,
                                      color: Theme.of(context).backgroundColor),
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s16),
                                  color: Theme.of(context).backgroundColor,
                                  shape: BoxShape.rectangle,
                                ),
                                child: Padding(
                                  padding: isRtl()
                                      ? const EdgeInsets.fromLTRB(
                                          AppPadding.p8,
                                          AppPadding.p8,
                                          AppPadding.p8,
                                          AppPadding.p2)
                                      : const EdgeInsets.all(AppPadding.p8),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SvgPicture.asset(
                                            ImageAssets.star,
                                            color: ColorManager.price,
                                          ),
                                          Text(
                                            state.chairDetailsList[0].rate
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall,
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: AppConstants.smallDistance,
                                      ),
                                      const SizedBox(
                                        height: AppConstants.smallDistance,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              state.chairDetailsList[0].reviews
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall),
                                          Text(AppStrings.reviews.tr(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall),
                                        ],
                                      ),
                                    ],
                                  ),
                                ))),
                        Positioned(
                            top: isRtl() ? 300 : 305,
                            left: isRtl() ? 260 : 30,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.chairDetailsList[0].title.toString(),
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                const SizedBox(
                                    height: AppConstants.smallDistance),
                                Text(AppStrings.chair.tr(),
                                    style:
                                        Theme.of(context).textTheme.titleSmall)
                              ],
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: AppConstants.heightBetweenElements,
                    ),
                    BlocProvider(
                      create: (context) => sl<InterActCubit>()
                        ..checkFavorites(
                            widget.idChair.toString(), 'Chair', 'walid barakat')
                        ..checkCart(widget.idChair.toString(), 'Chair',
                            'walid barakat'),
                      child: BlocConsumer<InterActCubit, InterActState>(
                        listener: (context, state2) {
                          if (state2 is NoInternetState) {
                            ErrorDialog.show(context, 'noInternet');
                          }
                        },
                        builder: (context, state2) {
                          return Padding(
                              padding: const EdgeInsets.all(AppPadding.p8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppStrings.description.tr(),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  const SizedBox(
                                    height: AppConstants.heightBetweenElements,
                                  ),
                                  ReadMoreText(
                                    state.chairDetailsList[0].description
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                          color: ColorManager.lightGrey,
                                        ),
                                    trimLines: 3,
                                    colorClickableText:
                                        Theme.of(context).backgroundColor,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: AppStrings.readMore.tr(),
                                    trimExpandedText: AppStrings.less.tr(),
                                  ),
                                  const SizedBox(
                                    height: AppConstants.heightBetweenElements,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppStrings.price.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                      isRtl()
                                          ? Row(
                                              children: [
                                                Text(
                                                  state
                                                      .chairDetailsList[0].price
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(
                                                          color: ColorManager
                                                              .price),
                                                ),
                                                Text('\$',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge
                                                        ?.copyWith(
                                                          color: ColorManager
                                                              .price,
                                                        )),
                                              ],
                                            )
                                          : Row(
                                              children: [
                                                Text('\$',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge
                                                        ?.copyWith(
                                                          color: ColorManager
                                                              .price,
                                                        )),
                                                Text(
                                                  state
                                                      .chairDetailsList[0].price
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(
                                                          color: ColorManager
                                                              .price),
                                                ),
                                              ],
                                            ),
                                      Container(
                                          width: 110,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: AppSize.s1,
                                                color: Theme.of(context)
                                                    .backgroundColor),
                                            borderRadius: BorderRadius.circular(
                                                AppSize.s16),
                                            color: Theme.of(context)
                                                .backgroundColor,
                                            shape: BoxShape.rectangle,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(
                                                AppPadding.p10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Bounceable(
                                                  onTap:(){},
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      await InterActCubit.get(
                                                              context)
                                                          .incrementCount();
                                                    },
                                                    child: Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: AppSize.s1,
                                                            color: ColorManager
                                                                .white),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                AppSize.s4),
                                                        color: Theme.of(context)
                                                            .hintColor,
                                                        shape: BoxShape.rectangle,
                                                      ),
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Theme.of(context)
                                                            .backgroundColor,
                                                        size: AppSize.s16,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                    InterActCubit.get(context)
                                                        .countOfSale
                                                        .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall),
                                                Bounceable(
                                                  onTap:(){},
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      await InterActCubit.get(
                                                              context)
                                                          .decrementCount();
                                                    },
                                                    child: Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: AppSize.s1,
                                                            color: ColorManager
                                                                .white),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                AppSize.s4),
                                                        color: Theme.of(context)
                                                            .hintColor,
                                                        shape: BoxShape.rectangle,
                                                      ),
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: Theme.of(context)
                                                            .backgroundColor,
                                                        size: AppSize.s16,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: AppConstants.heightBetweenElements,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: AppPadding.p20),
                                        child: GestureDetector(
                                          onTap: () async {
                                            await InterActCubit.get(context)
                                                .toggleFavorites(
                                                    widget.idChair.toString(),
                                                    'Chair',
                                                    'walid barakat');
                                          },
                                          child: Bounceable(
                                            onTap:(){},
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: AppSize.s1,
                                                    color: Theme.of(context)
                                                        .hintColor),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppSize.s4),
                                                color:
                                                    Theme.of(context).hintColor,
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: Icon(
                                                InterActCubit.get(context)
                                                        .ifItemFoundInFavorites!
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color: InterActCubit.get(context)
                                                        .ifItemFoundInFavorites!
                                                    ? ColorManager.error
                                                    : Theme.of(context)
                                                        .backgroundColor,
                                                size: AppSize.s28,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Bounceable(
                                        onTap: () {},
                                        child: GestureDetector(
                                          onTap: () async {
                                            await InterActCubit.get(context)
                                                .toggleCart(
                                                    widget.idChair.toString(),
                                                    'Chair',
                                                    'walid barakat',
                                                    InterActCubit.get(context)
                                                        .countOfSale
                                                        .toString());
                                          },
                                          child: Container(
                                            width: 230,
                                            height: 70,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: AppSize.s1,
                                                  color: Theme.of(context)
                                                      .backgroundColor),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppSize.s16),
                                              color: Theme.of(context)
                                                  .backgroundColor,
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  InterActCubit.get(context)
                                                          .ifItemFoundInCart!
                                                      ? AppStrings.inCart.tr()
                                                      : AppStrings.addToCart
                                                          .tr(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(
                                                        color: Theme.of(context)
                                                            .hintColor,
                                                      ),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    await InterActCubit.get(
                                                            context)
                                                        .toggleCart(
                                                            widget.idChair
                                                                .toString(),
                                                            'Chair',
                                                            'walid barakat',
                                                            InterActCubit.get(
                                                                    context)
                                                                .countOfSale
                                                                .toString());
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: 40,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            AppPadding.p8),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: AppSize.s1,
                                                            color: ColorManager
                                                                .lightPrimary),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    AppSize
                                                                        .s25),
                                                        color: Theme.of(context)
                                                            .hintColor),
                                                    child: SvgPicture.asset(
                                                      InterActCubit.get(context)
                                                              .ifItemFoundInCart!
                                                          ? ImageAssets.inCart
                                                          : ImageAssets.cart,
                                                      color: InterActCubit.get(
                                                                  context)
                                                              .ifItemFoundInCart!
                                                          ? ColorManager.error
                                                          : Theme.of(context)
                                                              .backgroundColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ));
                        },
                      ),
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }

  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }
}
